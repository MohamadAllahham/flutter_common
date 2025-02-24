import 'package:flutter/material.dart';

class UnselectableTextIconButton extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final FocusNode? focusNode;

  const UnselectableTextIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.style,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: TextButton.icon(
        onPressed: onPressed,
        focusNode: focusNode,
        style: style,
        icon: icon,
        label: label,
      ),
    );
  }
}
