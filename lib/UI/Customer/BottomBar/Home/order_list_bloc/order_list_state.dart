import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';

import 'package:equatable/equatable.dart';

class OrderListState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderListInitialState extends OrderListState {
  @override
  List<Object> get props => [];
}

class OrderListLoadingState extends OrderListState {
  @override
  List<Object> get props => [];
}

class OrderListLoadedState extends OrderListState {
  final OrderDetails orderDetailsmodel;

  OrderListLoadedState({required this.orderDetailsmodel});

  @override
  List<Object> get props => [];
}

class OrderListErrorState extends OrderListState {
  String message;

  OrderListErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
