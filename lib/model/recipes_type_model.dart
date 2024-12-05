class RecipeType {
  final int id;
  final String name;

  RecipeType({required this.id, required this.name});

  factory RecipeType.fromJson(Map<String, dynamic> json) {
    return RecipeType(
      id: json['id'],
      name: json['name'],
    );
  }
}
