import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';

import 'package:equatable/equatable.dart';

class AddCartState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCartInitialState extends AddCartState {
  @override
  List<Object> get props => [];
}

class AddCartLoadingState extends AddCartState {
  @override
  List<Object> get props => [];
}

class AddCartLoadedState extends AddCartState {
  final AddCartModel addCartModel;

  AddCartLoadedState({required this.addCartModel});

  @override
  List<Object> get props => [];
}

class AddCartErrorState extends AddCartState {
  String message;

  AddCartErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
