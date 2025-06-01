class Certificate {
  final String name;
  final String templatePath;
  final int templateIndex;
  final int categoryIndex;
  final String fontFamily;

  Certificate(
      {required this.name,
      required this.templatePath,
      required this.templateIndex,
      this.categoryIndex = 0,
      this.fontFamily = 'Great Vibes'});
}
