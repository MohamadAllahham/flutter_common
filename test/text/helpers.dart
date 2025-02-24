import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

List<String> findAllTexts() {
  return find
      .byType(Text)
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .nonNulls
      .toList();
}
