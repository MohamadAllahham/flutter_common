import 'package:common/pagination/paginated.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Paginated', () {
    const limit = 2;

    test('empty collection and page', () async {
      final paginated = Paginated<int?>(
        totalCount: 0,
        data: [],
        skip: 0,
        limit: limit,
      );

      expect(paginated.hasPrevious, false);
      expect(paginated.hasNext, false);
      expect(paginated.totalPageCount, 0);
      expect(paginated.pageIndex, 0);
    });

    for (int missingOnLastPage in Iterable<int>.generate(limit)) {
      const pageCount = 12;
      final itemsOnLastPage = limit - missingOnLastPage;
      final totalCount = pageCount * limit - missingOnLastPage;

      test('on the first page (with $itemsOnLastPage items on last page)',
          () async {
        const pageIndex = 0;
        final paginated = Paginated<int?>(
          totalCount: totalCount,
          data: List.filled(limit, null),
          skip: pageIndex * limit,
          limit: limit,
        );

        expect(paginated.hasPrevious, false);
        expect(paginated.previousSkip, -limit);
        expect(paginated.hasNext, true);
        expect(paginated.nextSkip, limit);
        expect(paginated.totalPageCount, pageCount);
        expect(paginated.pageIndex, pageIndex);
      });

      test('on an arbitrary page (with $itemsOnLastPage items on last page)',
          () async {
        const pageIndex = pageCount ~/ 2;

        final paginated = Paginated<int?>(
          totalCount: totalCount,
          data: List.filled(limit, null),
          skip: pageIndex * limit,
          limit: limit,
        );

        expect(paginated.hasPrevious, true);
        expect(paginated.previousSkip, pageIndex * limit - limit);
        expect(paginated.hasNext, true);
        expect(paginated.nextSkip, pageIndex * limit + limit);
        expect(paginated.totalPageCount, pageCount);
        expect(paginated.pageIndex, pageIndex);
      });

      test('on the last page (with $itemsOnLastPage items on last page)',
          () async {
        const pageIndex = pageCount - 1;
        final paginated = Paginated<int?>(
          totalCount: totalCount,
          data: List.filled(itemsOnLastPage, null),
          skip: pageIndex * limit,
          limit: limit,
        );

        expect(paginated.hasPrevious, true);
        expect(paginated.previousSkip, pageIndex * limit - limit);
        expect(paginated.hasNext, false);
        expect(paginated.nextSkip, pageIndex * limit + itemsOnLastPage);
        expect(paginated.totalPageCount, pageCount);
        expect(paginated.pageIndex, pageIndex);
      });

      for (final (pageIndexInWords, pageIndex) in [
        ('second', 1),
        ('center', pageCount ~/ 2),
        ('second to last', pageCount - 2),
      ]) {
        final page = Paginated<int>(
          totalCount: totalCount,
          data: List.filled(limit, 2),
          skip: pageIndex * limit,
          limit: limit,
        );
        final previousPage = Paginated<int>(
          totalCount: totalCount,
          data: List.filled(limit, 1),
          skip: (pageIndex - 1) * limit,
          limit: limit,
        );
        final subsequentPage = Paginated<int>(
          totalCount: totalCount,
          data: List.filled(limit, 3),
          skip: (pageIndex + 1) * limit,
          limit: limit,
        );
        test('merge pages around the $pageIndexInWords page', () async {
          final merged = Paginated.merge([page, previousPage, subsequentPage]);

          expect(merged.totalCount, totalCount);
          expect(
            merged.data,
            previousPage.data + page.data + subsequentPage.data,
          );
          expect(merged.skip, previousPage.skip);
          expect(merged.limit, limit);
          expect(merged.hasPrevious, previousPage.hasPrevious);
          expect(merged.previousSkip, previousPage.previousSkip);
          expect(merged.hasNext, subsequentPage.hasNext);
          expect(merged.nextSkip, subsequentPage.nextSkip);
          expect(merged.totalPageCount, page.totalPageCount);
          expect(merged.pageIndex, previousPage.pageIndex);
        });

        test('merge pages around the $pageIndexInWords page reversed',
            () async {
          final merged = Paginated.merge(
            [page, previousPage, subsequentPage],
            reversed: true,
          );

          expect(merged.totalCount, totalCount);
          expect(
            merged.data,
            subsequentPage.data + page.data + previousPage.data,
          );
          expect(merged.skip, previousPage.skip);
          expect(merged.limit, limit);
          expect(merged.hasPrevious, previousPage.hasPrevious);
          expect(merged.previousSkip, previousPage.previousSkip);
          expect(merged.hasNext, subsequentPage.hasNext);
          expect(merged.nextSkip, subsequentPage.nextSkip);
          expect(merged.totalPageCount, page.totalPageCount);
          expect(merged.pageIndex, previousPage.pageIndex);
        });
      }
    }
  });
}
