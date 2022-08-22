import 'package:auto_fix/Models/customer_models/add_address_model/add_address_model.dart';
import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';
import 'package:auto_fix/Models/customer_models/get_address_model/get_address_model.dart';

import 'package:equatable/equatable.dart';

class AddAddressState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddAddressInitialState extends AddAddressState {
  @override
  List<Object> get props => [];
}

class AddAddressLoadingState extends AddAddressState {
  @override
  List<Object> get props => [];
}

class AddAddressLoadedState extends AddAddressState {
  final AddAddressModel addaddressModel;

  AddAddressLoadedState({required this.addaddressModel});

  @override
  List<Object> get props => [];
}

class AddAddressErrorState extends AddAddressState {
  String message;

  AddAddressErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
