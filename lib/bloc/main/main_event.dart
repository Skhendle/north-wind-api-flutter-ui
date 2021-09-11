part of 'main_bloc.dart';



abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class CategoriesEvent extends MainEvent {
  const CategoriesEvent({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class ProductsEvent extends MainEvent {
  const ProductsEvent({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class OrdersEvent extends MainEvent {
  const OrdersEvent({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}
