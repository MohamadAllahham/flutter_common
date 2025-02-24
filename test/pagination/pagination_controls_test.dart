import 'package:common/pagination/numbered_controls/current_page_control.dart';
import 'package:common/pagination/paginated.dart';
import 'package:common/pagination/pagination_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';
import '../text/helpers.dart';

const int _limit = 10;
const int _totalCount = 100;
const int _pageCount = 10;

int? _jumpedToPageIndex;

const previousIcon = Icons.chevron_left_rounded;
const nextIcon = Icons.chevron_right_rounded;

MaterialApp _paginationControlsWidget({required int pageIndex}) {
  return MaterialApp(
    home: Scaffold(
      body: PaginationControls<int?>(
        paginated: Paginated<int?>(
          totalCount: _totalCount,
          data: List.filled(_limit, null),
          skip: pageIndex * _limit,
          limit: _limit,
        ),
        onJumpToPage: (index) {
          _jumpedToPageIndex = index;
        },
        showPreviousCount: 1,
        showNextCount: 3,
      ),
    ),
  );
}

void main() {
  group('PaginationControls', () {
    setUp(() {
      _jumpedToPageIndex = null;
    });

    testWidgets('when on the first page', (widgetTester) async {
      await widgetTester.pumpWidget(_paginationControlsWidget(pageIndex: 0));
      expect(find.byIcon(previousIcon), findsNothing);
      expect(find.byIcon(nextIcon), findsOneWidget);
      expect(
        findAllTexts(),
        ['1', '2', '3', '4', '...', '10'],
      );
      expect(findWidget<CurrentPageControl>().index, 0);
    });

    testWidgets('when on the second page', (widgetTester) async {
      await widgetTester.pumpWidget(_paginationControlsWidget(pageIndex: 1));
      expect(find.byIcon(previousIcon), findsOneWidget);
      expect(find.byIcon(nextIcon), findsOneWidget);
      expect(
        findAllTexts(),
        ['1', '2', '3', '4', '5', '...', '10'],
      );
      expect(findWidget<CurrentPageControl>().index, 1);
    });

    testWidgets('when on a center page', (widgetTester) async {
      await widgetTester.pumpWidget(_paginationControlsWidget(pageIndex: 4));
      expect(find.byIcon(previousIcon), findsOneWidget);
      expect(find.byIcon(nextIcon), findsOneWidget);
      expect(
        findAllTexts(),
        ['1', '...', '4', '5', '6', '7', '8', '...', '10'],
      );
      expect(findWidget<CurrentPageControl>().index, 4);
    });

    testWidgets('when on the second to last page', (widgetTester) async {
      await widgetTester
          .pumpWidget(_paginationControlsWidget(pageIndex: _pageCount - 2));
      expect(find.byIcon(previousIcon), findsOneWidget);
      expect(find.byIcon(nextIcon), findsOneWidget);
      expect(
        findAllTexts(),
        ['1', '...', '8', '9', '10'],
      );
      expect(findWidget<CurrentPageControl>().index, _pageCount - 2);
    });

    testWidgets('when on the last page', (widgetTester) async {
      await widgetTester
          .pumpWidget(_paginationControlsWidget(pageIndex: _pageCount - 1));
      expect(find.byIcon(previousIcon), findsOneWidget);
      expect(find.byIcon(nextIcon), findsNothing);
      expect(
        findAllTexts(),
        ['1', '...', '9', '10'],
      );
      expect(findWidget<CurrentPageControl>().index, _pageCount - 1);
    });

    testWidgets('when next is clicked', (widgetTester) async {
      await widgetTester.pumpWidget(_paginationControlsWidget(pageIndex: 0));

      await widgetTester.tap(find.byIcon(nextIcon));

      expect(_jumpedToPageIndex, 1);
    });

    testWidgets('when previous is clicked', (widgetTester) async {
      await widgetTester
          .pumpWidget(_paginationControlsWidget(pageIndex: _pageCount - 1));

      await widgetTester.tap(find.byIcon(previousIcon));

      expect(_jumpedToPageIndex, _pageCount - 2);
    });

    testWidgets('when a numbered control is clicked', (widgetTester) async {
      await widgetTester.pumpWidget(_paginationControlsWidget(pageIndex: 0));

      await widgetTester.tap(find.text('3'));

      expect(_jumpedToPageIndex, 2);
    });
  });
}
