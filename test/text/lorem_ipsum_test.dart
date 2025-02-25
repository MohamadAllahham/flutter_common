import 'package:flutter_common/text/lorem_ipsum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('loremIpsumLetters', () {
    test('returns an empty string for 0 letters', () {
      expect(loremIpsumLetters(0), '');
    });
    test('returns no leading space', () {
      expect(loremIpsumLetters(100), isNot(startsWith(' ')));
    });
    test('returns no trailing space', () {
      expect(loremIpsumLetters(100), isNot(endsWith(' ')));
    });
    test('returns a specific number of letters', () {
      expect(loremIpsumLetters(1), hasLength(1));
      expect(loremIpsumLetters(2), hasLength(2));
      expect(loremIpsumLetters(5), hasLength(5));
      expect(loremIpsumLetters(100), hasLength(100));
    });
  });
  group('loremIpsumWords', () {
    test('returns an empty string for 0 words', () {
      expect(loremIpsumWords(0), '');
    });
    test('returns no leading space', () {
      expect(loremIpsumWords(1000), isNot(startsWith(' ')));
    });
    test('returns no trailing space', () {
      expect(loremIpsumWords(1000), isNot(endsWith(' ')));
    });
    test('returns a specific number of words', () {
      expect(loremIpsumWords(1).split(' '), hasLength(1));
      expect(loremIpsumWords(2).split(' '), hasLength(2));
      expect(loremIpsumWords(5).split(' '), hasLength(5));
      expect(loremIpsumWords(100).split(' '), hasLength(100));
      expect(loremIpsumWords(1000).split(' '), hasLength(1000));
    });
  });
}
