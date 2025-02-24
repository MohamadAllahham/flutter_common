import 'dart:math';

class Paginated<T> {
  final int totalCount;
  final List<T> data;
  final int skip;
  final int limit;

  Paginated({
    required this.totalCount,
    required this.data,
    required this.skip,
    required this.limit,
  }) {
    assert(limit > 0);
  }

  bool get hasPrevious => skip > 0;
  int get previousSkip => skip - limit;
  bool get hasNext => (skip + data.length) < totalCount;
  int get nextSkip => skip + data.length;
  int get totalPageCount => (totalCount / limit).ceil();
  int get pageIndex => skip ~/ limit;

  @override
  String toString() {
    return {
      'totalCount': totalCount,
      'data': data,
      'skip': skip,
      'limit': limit,
    }.toString();
  }

  factory Paginated.mergeTwo(Paginated<T> page, Paginated<T> subsequentPage) {
    return Paginated<T>(
      totalCount: max(page.totalCount, subsequentPage.totalCount),
      data: page.data + subsequentPage.data,
      skip: min(page.skip, subsequentPage.skip),
      limit: max(page.limit, subsequentPage.limit),
    );
  }

  factory Paginated.merge(
    List<Paginated<T>> pages, {
    bool reversed = false,
  }) {
    final sortedPages = [...pages];
    if (reversed)
      sortedPages.sort((a, b) => b.skip.compareTo(a.skip));
    else
      sortedPages.sort((a, b) => a.skip.compareTo(b.skip));

    return sortedPages.reduce(Paginated<T>.mergeTwo);
  }

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    var list = json['data'] as List;
    List<T> dataList =
        list.map((i) => fromJsonT(i as Map<String, dynamic>)).toList();

    return Paginated(
      totalCount: json['totalCount'] as int,
      data: dataList,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}
