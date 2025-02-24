extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    if (name == null) return null;

    try {
      return byName(name);
    } on ArgumentError catch (_) {
      return null;
    }
  }
}

extension EnumIndexOfOrNull<T extends Enum> on List<T> {
  int? indexOfOrNull(T? element, [int start = 0]) {
    if (element == null) return null;
    return indexOf(element, start);
  }
}
