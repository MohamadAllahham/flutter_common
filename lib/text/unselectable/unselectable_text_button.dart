import 'package:flutter/material.dart';

class UnselectableTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final FocusNode? focusNode;

  const UnselectableTextButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: TextButton(
        onPressed: onPressed,
        child: child,
        focusNode: focusNode,
        style: style,
      ),
    );
  }
}
