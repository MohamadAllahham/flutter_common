import 'package:flutter/material.dart';

class UnselectableInkWell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;

  const UnselectableInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.focusNode,
    this.onHover,
    this.onLongPress,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final inkWell = InkWell(
      onTap: onTap,
      child: child,
      focusNode: focusNode,
      onHover: onHover,
      onLongPress: onLongPress,
      borderRadius: borderRadius,
    );

    if (onTap == null && onLongPress == null) return inkWell;

    return SelectionContainer.disabled(
      child: inkWell,
    );
  }
}
