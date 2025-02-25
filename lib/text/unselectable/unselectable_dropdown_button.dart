import 'package:flutter_common/typedefs.dart';
import 'package:flutter/material.dart';

class UnselectableDropdownButton<T> extends StatelessWidget {
  final T? value;
  final OnChangedCallback<T?> onChanged;
  final List<DropdownMenuItem<T>>? items;

  const UnselectableDropdownButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
