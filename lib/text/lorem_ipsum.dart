
const _loremIpsum =
    'Lorem ipsum dolor sit amet,'; // consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

String loremIpsumLetters(int letterCount) {
  int loremIpsumLength = _loremIpsum.length + 1;
  int fullLoremIpsumCount = letterCount ~/ loremIpsumLength;
  int partialLoremIpsumLength = letterCount % loremIpsumLength;

  return [
    for (int i = 0; i < fullLoremIpsumCount; i++) _loremIpsum,
    _loremIpsum.substring(0, partialLoremIpsumLength),
  ].join(' ');
}

String loremIpsumWords(int wordCount) {
  List<String> words = _loremIpsum.split(' ');
  int fullLoremIpsumCount = wordCount ~/ words.length;
  int partialLoremIpsumWordCount = wordCount % words.length;
  return [
    for (int i = 0; i < fullLoremIpsumCount; i++) _loremIpsum,
    for (int i = 0; i < partialLoremIpsumWordCount; i++) words[i],
  ].join(' ');
}
