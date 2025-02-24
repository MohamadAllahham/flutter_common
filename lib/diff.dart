import 'package:flutter/foundation.dart';

class DiffResult<T> {
  Set<T> added;
  Set<T> removed;
  Set<T> overlap;

  DiffResult({
    required this.added,
    required this.removed,
    required this.overlap,
  });

  Future<void> process({
    Future<void> Function(T added)? processAdded,
    Future<void> Function(T removed)? processRemoved,
    Future<void> Function(T overlap)? processOverlap,
  }) async {
    if (processAdded != null)
      for (final instance in added) await processAdded(instance);
    if (processRemoved != null)
      for (final instance in removed) await processRemoved(instance);
    if (processOverlap != null)
      for (final instance in overlap) await processOverlap(instance);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is DiffResult<T> &&
            setEquals(other.added, added) &&
            setEquals(other.removed, removed) &&
            setEquals(other.overlap, overlap);
  }

  @override
  int get hashCode => Object.hash(runtimeType, added, removed, overlap);

  @override
  String toString() =>
      '$DiffResult(added: $added, removed: $removed, overlap: $overlap)';
}

DiffResult<T> diff<T>(Iterable<T> initial, Iterable<T> altered) {
  final overlap = initial.toSet().intersection(altered.toSet());
  return DiffResult(
    added: altered.where((e) => !overlap.contains(e)).toSet(),
    removed: initial.where((e) => !overlap.contains(e)).toSet(),
    overlap: overlap,
  );
}
