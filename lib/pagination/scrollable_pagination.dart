import 'dart:async';

import 'package:flutter_common/pagination/paginated.dart';
import 'package:flutter_common/pagination/pagination.dart';
import 'package:flutter_common/typedefs.dart';
import 'package:flutter/material.dart';

class ScrollablePagination<T> extends StatefulWidget {
  final LoadCallback<T> load;
  final DecoratorBuilderCallback? decoratorBuilder;
  final AsyncBuilderCallback<Paginated<T>> builder;
  final int limit;
  final bool reversed;
  final int initialSkip;
  final ScrollController? scrollController;
  final OnDoneLoadingCallback<Paginated<T>>? onDoneLoading;

  const ScrollablePagination({
    super.key,
    required this.load,
    required this.decoratorBuilder,
    required this.builder,
    required this.limit,
    this.reversed = false,
    this.initialSkip = 0,
    this.scrollController,
    this.onDoneLoading,
  });

  @override
  ScrollablePaginationState<T> createState() => ScrollablePaginationState();
}

class ScrollablePaginationState<T> extends State<ScrollablePagination<T>> {
  late Future<Paginated<T>> _loadFuture;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loadFuture = _load(
      limit: widget.limit,
      skip: widget.initialSkip,
    );

    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_tryLoadMoreItems);

    _tryLoadMoreItems();
  }

  Future<void> _tryLoadMoreItems() async {
    final currentPage = await _loadFuture;
    if (!currentPage.hasNext) return;

    // wait for scroll position to adjust
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isAtMaxScrollExtend()) return;

      setState(() {
        _loadFuture = _load(
          pageToMerge: currentPage,
          limit: currentPage.limit,
          skip: currentPage.nextSkip,
        );
      });

      _tryLoadMoreItems();
    });
  }

  bool _isAtMaxScrollExtend() {
    final scrollPosition = _scrollController.position;
    return scrollPosition.pixels == scrollPosition.maxScrollExtent;
  }

  Future<void> reload() async {
    setState(() {
      _loadFuture = _load(
        limit: widget.limit,
        skip: widget.initialSkip,
      );
    });
  }

  Future<Paginated<T>> _load({
    Paginated<T>? pageToMerge,
    required int limit,
    required int skip,
  }) async {
    var newPage = await widget.load(
      limit: limit,
      skip: skip,
    );
    if (pageToMerge != null)
      newPage = Paginated.merge(
        [pageToMerge, newPage],
        reversed: widget.reversed,
      );
    if (widget.onDoneLoading != null) widget.onDoneLoading!(newPage);
    return newPage;
  }

  @override
  Widget build(BuildContext context) {
    final scrollable = SingleChildScrollView(
      controller: _scrollController,
      reverse: widget.reversed,
      child: widget.builder(_loadFuture),
    );

    if (widget.decoratorBuilder == null) return scrollable;

    return widget.decoratorBuilder!(scrollable);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
