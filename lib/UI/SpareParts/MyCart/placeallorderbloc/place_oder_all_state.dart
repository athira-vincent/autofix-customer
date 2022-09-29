import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/place_order_model/place_order_model.dart';

import 'package:equatable/equatable.dart';

class PlaceOrderAllState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceOrderAllInitialState extends PlaceOrderAllState {
  @override
  List<Object> get props => [];
}

class PlaceOrderAllLoadingState extends PlaceOrderAllState {
  @override
  List<Object> get props => [];
}

class PlaceOrderAllLoadedState extends PlaceOrderAllState {
  final PlaceOrderModel placeorderModel;

  PlaceOrderAllLoadedState({required this.placeorderModel});

  @override
  List<Object> get props => [];
}

class PlaceOrderAllErrorState extends PlaceOrderAllState {
  String message;

  PlaceOrderAllErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
