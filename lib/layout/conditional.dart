T conditional<T>({
  required bool condition,
  required T trueCase,
  required T falseCase,
}) {
  if (condition) return trueCase;
  return falseCase;
}
