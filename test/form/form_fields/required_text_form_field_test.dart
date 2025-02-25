import 'package:flutter_common/form/form_fields/required_text_form_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('requiredValidator', () {
    const syntaxError = 'syntaxError';
    const emptyError = 'emptyError';
    const valid = 'valid';
    const invalid = 'invalid';
    final validator = requiredValidator(
      isValidSyntax: (value) => value == valid,
      syntaxError: syntaxError,
      emptyError: emptyError,
    );

    test('returns empty error for null', () {
      expect(validator(null), emptyError);
    });

    test('returns empty error for empty string', () {
      expect(validator(''), emptyError);
    });

    test('returns syntax error for invalid value', () {
      expect(validator(invalid), syntaxError);
    });

    test('returns null for valid value', () {
      expect(validator(valid), null);
    });
  });
}
