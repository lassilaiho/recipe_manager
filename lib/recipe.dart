class Recipe {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String steps;

  const Recipe(
      {this.id, this.name, this.description, this.ingredients, this.steps});
}
