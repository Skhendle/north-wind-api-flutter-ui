import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationCategories());

  int _index = 0;
  int get activeView => _index;

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    switch (event) {
      case NavigationEvent.categories:
        _index = 0;
        yield NavigationCategories();
        break;
      case NavigationEvent.products:
        _index = 1;
        yield NavigationProducts();
        break;
      case NavigationEvent.orders:
        _index = 2;
        yield NavigationOrders();
        break;
    }
  }
}
