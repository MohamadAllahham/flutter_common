import 'package:flutter/material.dart';

class UnselectableElevatedIconButton extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final ButtonStyle? style;

  const UnselectableElevatedIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.focusNode,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        focusNode: focusNode,
        label: label,
        icon: icon,
        style: style,
      ),
    );
  }
}
