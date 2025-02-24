import 'package:flutter/material.dart';

class MultiSelectDialogField<T> extends StatelessWidget {
  final List<T> options;
  final String title;
  final List<T> initialValue;
  final void Function(List<T>) onConfirm;
  final Widget Function(T) buildListItem;
  final Widget Function(T) buildChipContent;
  final FormFieldValidator<List<T>>? validator;

  const MultiSelectDialogField({
    super.key,
    required this.options,
    required this.title,
    required this.initialValue,
    required this.onConfirm,
    required this.buildListItem,
    required this.buildChipContent,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
