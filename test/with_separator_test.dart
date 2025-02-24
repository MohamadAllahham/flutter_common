import 'package:common/with_separator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('withSeparator', () {
    test('list should be separated by dividers', () {
      Iterable<int> dividedList = withSeparator(
        list: [],
        separator: 0,
      );
      expect(dividedList, <int>[]);
      dividedList = withSeparator(
        list: [1],
        separator: 0,
      );
      expect(dividedList, [1]);
      dividedList = withSeparator(
        list: [1, 1],
        separator: 0,
      );
      expect(dividedList, [1, 0, 1]);
      dividedList = withSeparator(
        list: [1, 2, 3],
        separator: 0,
      );
      expect(dividedList, [1, 0, 2, 0, 3]);
    });
  });
}
