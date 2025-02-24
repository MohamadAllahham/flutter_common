Iterable<T> withSeparator<T>({
  required T separator,
  required Iterable<T> list,
}) sync* {
  int index = 0;
  for (var e in list) {
    yield e;
    if (index != list.length - 1) yield separator;
    index++;
  }
}
