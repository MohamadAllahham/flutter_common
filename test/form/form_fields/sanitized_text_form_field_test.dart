import 'package:common/form/form_fields/sanitized_text_form_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sanitizedValidator', () {
    const syntaxError = 'syntaxError';
    const valid = 'valid';
    const invalid = 'invalid';
    final validator = sanitizedValidator(
      isValidSyntax: (value) => value == valid,
      syntaxError: syntaxError,
    );

    test('returns null for null', () {
      expect(validator(null), null);
    });

    test('returns syntax error for empty string', () {
      expect(validator(''), syntaxError);
    });

    test('returns syntax error for invalid value', () {
      expect(validator(invalid), syntaxError);
    });

    test('returns null for valid value', () {
      expect(validator(valid), null);
    });
  });
}
