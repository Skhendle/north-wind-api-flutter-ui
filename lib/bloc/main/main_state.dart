part of 'main_bloc.dart';

@immutable
abstract class MainState {}

// enum MainStateNames { categories, products, orders }

class Loading extends MainState {}

// class ChangedItem extends MainState {}

class Error extends MainState {
  Error({required this.msg});
  final String msg;
}

class Categories extends MainState {
  Categories(
      {required this.selectedCategory,
      required this.list,
      required this.index});
  final CategoryModel selectedCategory;
  final List<CategoryModel> list;
  final int index;
}

class Products extends MainState {
    Products(
      {required this.selectedProduct,
      required this.list,
      required this.index});
  final ProductModel selectedProduct;
  final List<ProductModel> list;
  final int index;
}

class Orders extends MainState {
  Orders(
      {required this.selectedOrder,
      required this.list,
      required this.index});
  final OrderModel selectedOrder;
  final List<OrderModel> list;
  final int index;
}
