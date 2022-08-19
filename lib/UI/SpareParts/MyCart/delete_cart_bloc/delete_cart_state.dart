import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/delete_cart_model/delete_cart_model.dart';

import 'package:equatable/equatable.dart';

class DeleteCartState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteCartInitialState extends DeleteCartState {
  @override
  List<Object> get props => [];
}

class DeleteCartLoadingState extends DeleteCartState {
  @override
  List<Object> get props => [];
}

class DeleteCartLoadedState extends DeleteCartState {
  final DeleteCartModel deleteCartModel;

  DeleteCartLoadedState({required this.deleteCartModel});

  @override
  List<Object> get props => [];
}

class DeleteCartErrorState extends DeleteCartState {
  String message;

  DeleteCartErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
