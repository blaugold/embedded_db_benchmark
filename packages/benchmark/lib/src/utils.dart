extension StringExt on String {
  String get kebabCase =>
      split(RegExp('[A-Z]_')).map((s) => s.toLowerCase()).join('-');
}
