class CategoryModel {
  final int id;
  String name;
  String description;

  CategoryModel(this.id, this.name, this.description);

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];
}
