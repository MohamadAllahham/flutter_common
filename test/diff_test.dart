import 'package:flutter_common/diff.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('==', () {
    test('returns true for equal empty instances', () {
      final instance = DiffResult(
        added: <int>{},
        removed: <int>{},
        overlap: <int>{},
      );
      final other = DiffResult(
        added: <int>{},
        removed: <int>{},
        overlap: <int>{},
      );
      expect(
        instance == other,
        true,
      );
    });
    test('returns true for equal filled instances', () {
      final instance = DiffResult(
        added: <int>{0},
        removed: <int>{1},
        overlap: <int>{0, 1, 2},
      );
      final other = DiffResult(
        added: <int>{0},
        removed: <int>{1},
        overlap: <int>{0, 1, 2},
      );
      expect(
        instance == other,
        true,
      );
    });
    test('returns false for non equal instances', () {
      final instance = DiffResult(
        added: <int>{0},
        removed: <int>{0},
        overlap: <int>{0},
      );
      final other1 = DiffResult(
        added: <int>{1},
        removed: <int>{0},
        overlap: <int>{0},
      );
      final other2 = DiffResult(
        added: <int>{0},
        removed: <int>{1},
        overlap: <int>{0},
      );
      final other3 = DiffResult(
        added: <int>{0},
        removed: <int>{0},
        overlap: <int>{1},
      );
      expect(
        instance == other1,
        false,
      );
      expect(
        instance == other2,
        false,
      );
      expect(
        instance == other3,
        false,
      );
    });
  });
  group('diff', () {
    test('returns empty outputs for empty inputs', () {
      expect(
        diff(<int>[], <int>[]),
        DiffResult(
          added: <int>{},
          removed: <int>{},
          overlap: <int>{},
        ),
      );
    });
    test('returns the correct result', () {
      final intial = [1, 2, 3, 4];
      final altered = [3, 4, 5, 6];
      expect(
        diff(intial, altered),
        DiffResult(
          added: {5, 6},
          removed: {1, 2},
          overlap: {3, 4},
        ),
      );
    });
  });
}
