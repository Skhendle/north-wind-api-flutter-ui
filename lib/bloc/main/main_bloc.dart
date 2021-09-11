import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:novasat/api_repo/repositories.dart';
import 'package:novasat/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:novasat/models/orders.dart';
import 'package:novasat/models/products.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(Loading());
  final Repository repo = Repository();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is CategoriesEvent) {
      try {
        yield Loading();
        var list = await repo.getCategories();
        yield Categories(
            list: list,
            selectedCategory: list[event.index],
            index: event.index);
      } catch (e) {
        print(e);
        yield Error(msg: e.toString());
      }
    }

    if (event is ProductsEvent) {
      try {
        yield Loading();
        var list = await repo.getProducts();
        yield Products(
            list: list, selectedProduct: list[event.index], index: event.index);
      } catch (e) {
        yield Error(msg: e.toString());
      }
    }

    if (event is OrdersEvent) {
      try {
        yield Loading();
        var list = await repo.getorders();
        yield Orders(
            selectedOrder: list[event.index], list: list, index: event.index);
      } catch (e) {
        yield Error(msg: e.toString());
      }
    }
  }
}
