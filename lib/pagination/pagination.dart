import 'package:common/pagination/paginated.dart';
import 'package:common/pagination/pagination_controls.dart';
import 'package:flutter/material.dart';

typedef LoadCallback<T> = Future<Paginated<T>> Function({
  required int limit,
  required int skip,
});

typedef WrapControlsCallback<T> = Widget Function({
  required Paginated<T> paginated,
  required Widget child,
});

typedef PaginatedBuilderCallback<T> = Widget Function({
  required Future<Paginated<T>> future,
  required WrapControlsCallback<T> wrapControls,
});

class PaginationController<T> {
  final key = GlobalKey<_PaginationState<T>>();

  void reset() {
    key.currentState?.reset();
  }

  Future<void> reload() async {
    await key.currentState?.reload();
  }
}

class Pagination<T> extends StatefulWidget {
  final LoadCallback<T> load;
  final int limit;
  final PaginatedBuilderCallback<T> builder;
  final int initialSkip;

  const Pagination({
    super.key,
    required this.load,
    required this.limit,
    required this.builder,
    this.initialSkip = 0,
  });

  @override
  _PaginationState<T> createState() => _PaginationState<T>();
}

class _PaginationState<T> extends State<Pagination<T>> {
  late final PaginationController<T>? controller;
  late Future<Paginated<T>> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = widget.load(
      limit: widget.limit,
      skip: widget.initialSkip,
    );
  }

  void reset() {
    setState(() {
      _loadFuture = widget.load(
        limit: widget.limit,
        skip: widget.initialSkip,
      );
    });
  }

  Future<void> reload() async {
    final currentPage = await _loadFuture;
    setState(() {
      _loadFuture = widget.load(
        limit: currentPage.limit,
        skip: currentPage.skip,
      );
    });
  }

  void _jumpToPage(int pageIndex) {
    setState(() {
      _loadFuture = widget.load(
        limit: widget.limit,
        skip: pageIndex * widget.limit,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      future: _loadFuture,
      wrapControls: ({
        required paginated,
        required child,
      }) {
        if (paginated.totalPageCount <= 1) return child;
        return Column(
          children: [
            child,
            SizedBox(height: 16),
            PaginationControls(
              paginated: paginated,
              onJumpToPage: _jumpToPage,
            ),
          ],
        );
      },
    );
  }
}
