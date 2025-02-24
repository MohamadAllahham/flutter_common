import 'package:common/typedefs.dart';
import 'package:flutter/material.dart';

FormFieldValidator<String> sanitizedValidator({
  required bool Function(String value) isValidSyntax,
  required String syntaxError,
}) {
  return (String? sanitized) {
    if (sanitized != null && !isValidSyntax(sanitized)) return syntaxError;
    return null;
  };
}

class SanitizedTextFormField extends StatelessWidget {
  final String? initialValue;
  final FormFieldSetter<String> onSaved;
  final Iterable<String>? autofillHints;
  final String label;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final SetterCallback<String>? onChanged;

  String? _emptyToNull(String? value) {
    if (value == null) return value;
    if (value.isEmpty) return null;
    return value;
  }

  String? _sanitize(String? value) {
    return _emptyToNull(value)?.trim();
  }

  const SanitizedTextFormField({
    super.key,
    required this.initialValue,
    required this.onSaved,
    required this.label,
    required this.textInputAction,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.validator,
    this.onChanged,
    this.autofillHints,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
  });

  const SanitizedTextFormField.big({
    super.key,
    required this.initialValue,
    required this.onSaved,
    required this.label,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.onFieldSubmitted,
    this.autofillHints,
    this.maxLines,
    this.minLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      onSaved: (value) => onSaved(_sanitize(value)),
      validator:
          validator == null ? null : (value) => validator!(_sanitize(value)),
      decoration: InputDecoration(labelText: label),
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      onChanged: onChanged,
    );
  }
}
