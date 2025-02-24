import 'package:flutter/material.dart';

class UnselectableListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Color? tileColor;

  const UnselectableListTile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.focusNode,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    final listTile = ListTile(
      onTap: onTap,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      focusNode: focusNode,
      tileColor: tileColor,
    );

    if (onTap == null) return listTile;

    return SelectionContainer.disabled(
      child: listTile,
    );
  }
}
