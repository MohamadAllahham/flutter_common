import 'package:flutter_common/pagination/pagination_controls.dart';
import 'package:flutter_common/text/link_text.dart';
import 'package:flutter/material.dart';

class JumpToPageControl extends StatelessWidget {
  final int index;
  final JumpToPageCallback onJumpToPage;

  const JumpToPageControl({
    super.key,
    required this.index,
    required this.onJumpToPage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LinkText(
      onTap: () {
        onJumpToPage(index);
      },
      child: Text(
        (index + 1).toString(),
        style: TextStyle(
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
