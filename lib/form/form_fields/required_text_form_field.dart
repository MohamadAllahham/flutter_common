import 'package:common/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FormFieldValidator<String> requiredValidator({
  required bool Function(String value) isValidSyntax,
  required String syntaxError,
  required String emptyError,
}) {
  return (String? value) {
    if (value == null || value.isEmpty) return emptyError;
    if (!isValidSyntax(value)) return syntaxError;
    return null;
  };
}

class RequiredTextFormField extends StatelessWidget {
  final String? initialValue;
  final SetterCallback<String> onSaved;
  final ValidatorCallback<String> validator;
  final Iterable<String>? autofillHints;
  final String label;
  final String? errorLabel;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final Widget? suffixIcon;
  final SetterCallback<String>? onChanged;

  const RequiredTextFormField({
    super.key,
    required this.initialValue,
    required this.onSaved,
    required this.validator,
    required this.label,
    this.autofillHints,
    this.errorLabel,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.suffixIcon, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: (value) => onSaved(value!),
      validator: (value) => validator(value!),
      decoration: InputDecoration(
        labelText: '$label*',
        errorText: errorLabel,
        suffixIcon: suffixIcon,
      ),
      autofillHints: autofillHints,
      onEditingComplete: TextInput.finishAutofillContext,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
