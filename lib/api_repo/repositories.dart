import 'package:http/http.dart' as http;
import 'package:novasat/models/category.dart';
import 'package:novasat/models/orders.dart';
import 'dart:convert';

import 'package:novasat/models/products.dart';

class Repository {
  Future<List<CategoryModel>> getCategories() async {
    final request = await http
        .get(Uri.parse('https://northwind.vercel.app/api/categories'))
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('Network Connection Errors'));

    var object = <CategoryModel>[];
    if (request.statusCode == 200) {
      var body = jsonDecode(request.body);

      for (var item in body) {
        if (item['description'] != null)
          object.add(CategoryModel.fromJson(item));
      }
      // causes a bug because we call the API everytime state changes
      // object.shuffle();
      object.sort((a, b) => a.id.compareTo(b.id));

      return object;
    } else {
      throw ('Request Error');
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final request = await http
        .get(Uri.parse('https://northwind.vercel.app/api/products'))
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('Network Connection Errors'));

    var object = <ProductModel>[];
    if (request.statusCode == 200) {
      var body = jsonDecode(request.body);
      for (var item in body) {
        object.add(ProductModel.fromJson(item));
      }
      // causes a bug because we call the API everytime state changes
      // object.shuffle();
      object.sort((a, b) => a.id.compareTo(b.id));
      return object;
    } else {
      throw ('Request Error');
    }
  }

  Future<List<OrderModel>> getOrders() async {
    final request = await http
        .get(Uri.parse('https://northwind.vercel.app/api/orders'))
        .timeout(Duration(seconds: 30))
        .catchError((e) => throw ('Network Connection Errors'));

    var object = <OrderModel>[];
    if (request.statusCode == 200) {
      var body = jsonDecode(request.body);
      int i = 1;
      for (var item in body) {
        try {
          object.add(OrderModel.fromJson(item, i));
          i++;
        } catch (e) {}
      }
      object.sort((a, b) => a.id.compareTo(b.id));
      // causes a bug because we call the API everytime state changes
      return object;
    } else {
      throw ('Request Error');
    }
  }
}
