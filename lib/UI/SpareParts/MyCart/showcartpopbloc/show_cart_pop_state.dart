import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';

import 'package:equatable/equatable.dart';

class ShowCartPopState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowCartPopInitialState extends ShowCartPopState {
  @override
  List<Object> get props => [];
}

class ShowCartPopLoadingState extends ShowCartPopState {
  @override
  List<Object> get props => [];
}

class ShowCartPopLoadedState extends ShowCartPopState {
  final CartListModel cartlistmodel;

  ShowCartPopLoadedState({required this.cartlistmodel});

  @override
  List<Object> get props => [];
}

class ShowCartPopErrorState extends ShowCartPopState {
  String message;

  ShowCartPopErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
