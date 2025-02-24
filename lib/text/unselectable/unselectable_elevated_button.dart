import 'package:flutter/material.dart';

class UnselectableElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final ButtonStyle? style;

  const UnselectableElevatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        focusNode: focusNode,
        style: style,
      ),
    );
  }
}
