class ProductModel {
  final int id;
  String name;
  int unitsInStock;
  double unitPrice;


  ProductModel(this.id, this.name, this.unitsInStock, this.unitPrice);

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        unitsInStock = json['unitsInStock'],
        unitPrice = json['unitPrice'];
}
