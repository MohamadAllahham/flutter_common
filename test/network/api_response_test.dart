import 'package:flutter_common/logging.dart';
import 'package:flutter_common/network/api_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('decode', () {
    setUpAll(() => muteLogging());
    tearDownAll(() => unmuteLogging());

    test('throws for invalid json', () {
      expect(() => ApiResponse.decode('.'), throwsA(isA<FormatException>()));
    });

    test('does not throw for an empty string', () {
      expect(() => ApiResponse.decode(''), returnsNormally);
    });

    test('does not throw for valid json', () {
      expect(() => ApiResponse.decode('{}'), returnsNormally);
      expect(() => ApiResponse.decode('[]'), returnsNormally);
      expect(() => ApiResponse.decode('0'), returnsNormally);
      expect(() => ApiResponse.decode('""'), returnsNormally);
      expect(() => ApiResponse.decode('true'), returnsNormally);
      expect(() => ApiResponse.decode('false'), returnsNormally);
    });
  });

  group('isEmpty', () {
    test('returns true for null body', () {
      expect(ApiResponse(null).isEmpty, true);
    });

    test('returns false for non-null body', () {
      expect(ApiResponse(<void, void>{}).isEmpty, false);
      expect(ApiResponse(<void>[]).isEmpty, false);
      expect(ApiResponse(0).isEmpty, false);
      expect(ApiResponse('').isEmpty, false);
      expect(ApiResponse(true).isEmpty, false);
      expect(ApiResponse(false).isEmpty, false);
    });
  });

  group('isNotEmpty', () {
    test('returns the opposite of isEmpty', () {
      expect(
        ApiResponse(null).isNotEmpty,
        // ignore: prefer_is_not_empty
        !ApiResponse(null).isEmpty,
      );
      expect(
        ApiResponse(0).isNotEmpty,
        // ignore: prefer_is_not_empty
        !ApiResponse(0).isEmpty,
      );
    });
  });

  group('asMap', () {
    setUpAll(() => muteLogging());
    tearDownAll(() => unmuteLogging());

    test('returns the body of type Map<String, dynamic>', () {
      expect(
        ApiResponse(<String, dynamic>{}).asMap(),
        <String, dynamic>{},
      );
      expect(
        ApiResponse(<String, int>{}).asMap(),
        <String, int>{},
      );
      expect(
        ApiResponse({'0': 1}).asMap(),
        {'0': 1},
      );
    });

    test('converts the type of an empty body', () {
      expect(
        ApiResponse(<int, int>{}).asMap(),
        <String, dynamic>{},
      );
    });

    test('throws if the body is not a Map<String, dynamic>', () {
      expect(
        () => ApiResponse(1).asMap(),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => ApiResponse({0: 1}).asMap(),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => ApiResponse([1]).asMap(),
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('asList', () {
    setUpAll(() => muteLogging());
    tearDownAll(() => unmuteLogging());

    test('returns the body of type List<Map<<String, dynamic>>', () {
      expect(
        ApiResponse(<Map<String, dynamic>>[]).asList(),
        <Map<String, dynamic>>[],
      );
      expect(
        ApiResponse(<Map<String, int>>[]).asList(),
        <Map<String, dynamic>>[],
      );
      expect(
        ApiResponse([
          {'0': 1},
        ]).asList(),
        [
          {'0': 1},
        ],
      );
    });

    test('converts the type of an empty list body', () {
      expect(
        ApiResponse(<Map<int, int>>[]).asList(),
        <Map<String, dynamic>>[],
      );
    });

    test('converts the type of a List<dynamic> body', () {
      expect(
        ApiResponse(<dynamic>[
          {'0': 1},
        ]).asList(),
        <Map<String, dynamic>>[
          {'0': 1},
        ],
      );
    });

    test('throws if the body is not a List<Map<<String, dynamic>>', () {
      expect(
        () => ApiResponse(1).asList(),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => ApiResponse({0: 1}).asList(),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => ApiResponse([1]).asList(),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => ApiResponse([
          {0: 1},
        ]).asList(),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
