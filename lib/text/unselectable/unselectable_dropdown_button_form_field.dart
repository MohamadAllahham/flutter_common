import 'package:common/typedefs.dart';
import 'package:flutter/material.dart';

class UnselectableDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final ValidatorCallback<T?>? validator;
  final OnChangedCallback<T?> onChanged;
  final List<DropdownMenuItem<T>>? items;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final bool isExpanded;

  const UnselectableDropdownButtonFormField({
    super.key,
    this.value,
    this.validator,
    required this.onChanged,
    required this.items,
    this.decoration,
    this.focusNode,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: DropdownButtonFormField<T>(
        value: value,
        validator: validator,
        onChanged: onChanged,
        items: items,
        decoration: decoration,
        focusNode: focusNode,
        isExpanded: isExpanded,
      ),
    );
  }
}
