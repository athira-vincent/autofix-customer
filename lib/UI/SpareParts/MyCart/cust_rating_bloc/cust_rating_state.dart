import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/delete_address_model/delete_address_model.dart';
import 'package:auto_fix/Models/customer_rating_model/customer_rating_model.dart';
import 'package:auto_fix/Models/delete_cart_model/delete_cart_model.dart';

import 'package:equatable/equatable.dart';

class CustRatingState extends Equatable {
  @override
  List<Object> get props => [];
}

class CustRatingInitialState extends CustRatingState {
  @override
  List<Object> get props => [];
}

class CustRatingLoadingState extends CustRatingState {
  @override
  List<Object> get props => [];
}

class CustRatingLoadedState extends CustRatingState {
  final CustomerRatingModel customerRatingModel;

  CustRatingLoadedState({required this.customerRatingModel});

  @override
  List<Object> get props => [];
}

class CustRatingErrorState extends CustRatingState {
  String message;

  CustRatingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
