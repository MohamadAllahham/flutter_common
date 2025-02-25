import 'package:flutter_common/form/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidUrl', () {
    test('valid URLs', () {
      expect(isValidUrl('http://www.google.de'), true);
      expect(isValidUrl('https://www.google.de'), true);
      expect(isValidUrl('http://google.de'), true);
      expect(isValidUrl('https://google.de'), true);
      expect(isValidUrl('www.google.de'), true);
      expect(isValidUrl('ww2.google.de'), true);
      expect(isValidUrl('google.de'), true);
      expect(isValidUrl('https://www.google.de?hl=de'), true);
      expect(isValidUrl('https://www.google.com/maps'), true);
    });
    test('valid URLs with special characters', () {
      expect(isValidUrl('google.de-'), true);
      expect(isValidUrl('google.de%'), true);
      expect(isValidUrl('google.de!'), true);
      expect(isValidUrl('google.de+'), true);
      expect(isValidUrl('google.de.'), true);
      expect(isValidUrl('google.de,'), true);
      expect(isValidUrl('google.deä'), true);
      expect(isValidUrl('google.deö'), true);
      expect(isValidUrl('google.deü'), true);
      expect(isValidUrl('google.de_'), true);
    });
    test('valid URL with many parameters', () {
      expect(
        isValidUrl(
          'https://www.google.com/maps/place/M%C3%BCnchen+Hbf/@48.1409987,11.5590178,15.5z/data=!4m5!3m4!1s0x479e75fec5b151b9:0x43ec2bf2c2451cc2!8m2!3d48.1402669!4d11.559998',
        ),
        true,
      );
    });
    test('invalid URLs with spaces', () {
      expect(isValidUrl(' google.de'), false);
      expect(isValidUrl('google.de '), false);
      expect(isValidUrl('goog le.de'), false);
      expect(isValidUrl('google .de'), false);
      expect(isValidUrl('google. de'), false);
    });
    test('invalid URLs not starting with a character', () {
      expect(isValidUrl('/google.de'), false);
      expect(isValidUrl('.google.de'), false);
    });
    test('invalid URLs without a dot', () {
      expect(isValidUrl('google'), false);
      expect(isValidUrl('http://google'), false);
      expect(isValidUrl('https://google'), false);
    });
    test('uncaught invalid URLs', () {
      expect(isValidUrl('google..de'), true);
      expect(isValidUrl('www.google'), true);
      expect(isValidUrl('a.b'), true);
    });
  });
  group('replaceUrls', () {
    test('a single URL', () {
      expect(
        replaceUrls('google.de', ((url) => url.toUpperCase())),
        'GOOGLE.DE',
      );
    });
    test('no URL', () {
      expect(
        replaceUrls('google', ((url) => url.toUpperCase())),
        'google',
      );
    });
    test('a URL within a sentence', () {
      expect(
        replaceUrls('go to google.de to search', ((url) => url.toUpperCase())),
        'go to GOOGLE.DE to search',
      );
    });
    test('multiple URLs', () {
      expect(
        replaceUrls('a.b c.d e.f', ((url) => url.toUpperCase())),
        'A.B C.D E.F',
      );
    });
  });
  group('isValidEmail', () {
    test('valid email', () {
      expect(isValidEmail('test@test.de'), true);
      expect(isValidEmail('test.test@test.de'), true);
      expect(isValidEmail('test-test@test.de'), true);
      expect(isValidEmail('test+test@test.de'), true);
      expect(isValidEmail('test_test@test.de'), true);
      expect(isValidEmail('test@test-test.de'), true);
      expect(isValidEmail('test@test.de.com'), true);
    });
    test('invalid email with spaces', () {
      expect(isValidEmail(' test@test.de '), false);
      expect(isValidEmail(' test@test.de'), false);
      expect(isValidEmail('test@test.de '), false);
      expect(isValidEmail('test@ test.de'), false);
      expect(isValidEmail('test @test.de'), false);
    });
    test('invalid email without @', () {
      expect(isValidEmail('testtest.de '), false);
    });
    test('invalid email without .', () {
      expect(isValidEmail('test@testde '), false);
    });
  });
  group('isValidPhoneNumber', () {
    test('valid phone number', () {
      expect(isValidPhoneNumber('017612312345'), true);
      expect(isValidPhoneNumber('0176 123 12345'), true);
      expect(isValidPhoneNumber('+49 176 123 12345'), true);
      expect(isValidPhoneNumber('0176/123/12345'), true);
      expect(isValidPhoneNumber('0176\\123\\12345'), true);
      expect(isValidPhoneNumber('0176-123-12345'), true);
      expect(isValidPhoneNumber('(0176)12312345'), true);
    });
    test('invalid phone number with letters', () {
      expect(isValidPhoneNumber('0176aaa12345'), false);
    });
    test('ignored invalid phone number with too many digits', () {
      expect(isValidPhoneNumber('017612312356789'), true);
    });
  });
}
