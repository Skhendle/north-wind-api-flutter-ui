part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
  
  @override
  List<Object> get props => [];
}

class NavigationCategories extends NavigationState {}

class NavigationProducts extends NavigationState {}

class NavigationOrders extends NavigationState {}
