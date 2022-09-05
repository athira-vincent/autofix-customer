import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/place_order_model/place_order_model.dart';

import 'package:equatable/equatable.dart';

class PlaceOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceOrderInitialState extends PlaceOrderState {
  @override
  List<Object> get props => [];
}

class PlaceOrderLoadingState extends PlaceOrderState {
  @override
  List<Object> get props => [];
}

class PlaceOrderLoadedState extends PlaceOrderState {
  final PlaceOrderModel placeorderModel;

  PlaceOrderLoadedState({required this.placeorderModel});

  @override
  List<Object> get props => [];
}

class PlaceOrderErrorState extends PlaceOrderState {
  String message;

  PlaceOrderErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
