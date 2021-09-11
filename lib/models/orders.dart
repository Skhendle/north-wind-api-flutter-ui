class OrderModel {
  final int id;
  String customerId;
  DateTime orderDate;
  DateTime requiredDate;
  DateTime shippedDate;
  List<ProductDescriptionModel> products;
  OrderModel(this.id, this.customerId, this.orderDate, this.requiredDate,
      this.shippedDate, this.products);

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        customerId = json['customerId'],
        orderDate = DateTime.parse(json['orderDate']),
        requiredDate = DateTime.parse(json['requiredDate']),
        shippedDate = DateTime.parse(json['shippedDate']),
        products = List<ProductDescriptionModel>.from(
            json["details"].map((x) => ProductDescriptionModel.fromJson(x)));

}

class ProductDescriptionModel {
  final int id;
  double unitPrice;
  int quantity;
  double discount;

  ProductDescriptionModel(
      this.id, this.unitPrice, this.quantity, this.discount);

  ProductDescriptionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        unitPrice = json['name'],
        quantity = json['unitsInStock'],
        discount = json['unitPrice'];
}
