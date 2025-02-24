import 'package:common/layout/conditional.dart';
import 'package:common/pagination/numbered_controls/current_page_control.dart';
import 'package:common/pagination/numbered_controls/jump_to_page_control.dart';
import 'package:common/pagination/paginated.dart';
import 'package:common/with_separator.dart';
import 'package:flutter/material.dart';

typedef JumpToPageCallback = void Function(int index);

class PaginationControls<T> extends StatelessWidget {
  final Paginated<T> paginated;
  final JumpToPageCallback onJumpToPage;
  final int showPreviousCount;
  final int showNextCount;
  final Widget fillerChild;

  const PaginationControls({
    super.key,
    required this.paginated,
    required this.onJumpToPage,
    this.showPreviousCount = 1,
    this.showNextCount = 3,
    this.fillerChild = const Text('...'),
  });

  List<Widget> _buildNumberedControls(BuildContext context) {
    final List<Widget> controls = [];
    bool previousIsFiller = false;
    for (int i = 0; i < paginated.totalPageCount; i++) {
      if (i == paginated.pageIndex) {
        controls.add(CurrentPageControl(index: i));
        previousIsFiller = false;
        continue;
      }

      if (i == 0 ||
          i == paginated.totalPageCount - 1 ||
          (i >= paginated.pageIndex - showPreviousCount &&
              i < paginated.pageIndex) ||
          (i <= paginated.pageIndex + showNextCount &&
              paginated.pageIndex < i)) {
        controls.add(
          JumpToPageControl(
            index: i,
            onJumpToPage: onJumpToPage,
          ),
        );
        previousIsFiller = false;
        continue;
      }

      if (!previousIsFiller) {
        controls.add(fillerChild);
        previousIsFiller = true;
      }
    }
    return controls;
  }

  @override
  Widget build(BuildContext context) {
    final disabledButton = IconButton(onPressed: null, icon: SizedBox.shrink());

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge ?? TextStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: withSeparator(
          separator: const SizedBox(width: 16),
          list: [
            conditional(
              condition: paginated.hasPrevious,
              trueCase: IconButton(
                icon: Icon(Icons.chevron_left_rounded),
                onPressed: () => onJumpToPage(paginated.pageIndex - 1),
              ),
              falseCase: disabledButton,
            ),
            ..._buildNumberedControls(context),
            conditional(
              condition: paginated.hasNext,
              trueCase: IconButton(
                icon: Icon(Icons.chevron_right_rounded),
                onPressed: () => onJumpToPage(paginated.pageIndex + 1),
              ),
              falseCase: disabledButton,
            ),
          ],
        ).toList(),
      ),
    );
  }
}
