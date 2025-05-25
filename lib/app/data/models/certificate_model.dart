class Certificate {
  final String name;
  final String templatePath;
  final int templateIndex;
  final String fontFamily;

  Certificate(
      {required this.name,
      required this.templatePath,
      required this.templateIndex,
      this.fontFamily = 'Great Vibes'});
}
