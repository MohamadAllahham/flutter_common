import 'package:flutter_common/text/unselectable/unselectable_ink_well.dart';
import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  const LinkText({
    super.key,
    required this.child,
    this.onTap,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = DefaultTextStyle.of(context);

    return UnselectableInkWell(
      focusNode: focusNode,
      child: DefaultTextStyle(
        style: style.style.copyWith(
          color: theme.colorScheme.primary,
        ),
        child: child,
      ),
      onTap: onTap,
    );
  }
}
