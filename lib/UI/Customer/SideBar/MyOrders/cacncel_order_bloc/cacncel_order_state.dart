import 'package:auto_fix/Models/customer_models/cancel_order_module/cancel_order_module.dart';
import 'package:auto_fix/Models/customer_models/delete_address_model/delete_address_model.dart';

import 'package:equatable/equatable.dart';

class CancelOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class CancelOrderInitialState extends CancelOrderState {
  @override
  List<Object> get props => [];
}

class CancelOrderLoadingState extends CancelOrderState {
  @override
  List<Object> get props => [];
}

class CancelOrderLoadedState extends CancelOrderState {
  final CancelOrder cancelOrder;

  CancelOrderLoadedState({required this.cancelOrder});

  @override
  List<Object> get props => [];
}

class CancelOrderErrorState extends CancelOrderState {
  String message;

  CancelOrderErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
