import 'package:flutter/material.dart';

class CurrentPageControl extends StatelessWidget {
  final int index;

  const CurrentPageControl({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      (index + 1).toString(),
      style: TextStyle(
        color: colorScheme.primary,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
