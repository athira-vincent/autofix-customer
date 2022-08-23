import 'package:auto_fix/Models/customer_models/add_address_model/add_address_model.dart';
import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';
import 'package:auto_fix/Models/customer_models/get_address_model/get_address_model.dart';

import 'package:equatable/equatable.dart';

class EditAddressState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditAddressInitialState extends EditAddressState {
  @override
  List<Object> get props => [];
}

class EditAddressLoadingState extends EditAddressState {
  @override
  List<Object> get props => [];
}

class EditAddressLoadedState extends EditAddressState {
  final AddAddressModel addaddressModel;

  EditAddressLoadedState({required this.addaddressModel});

  @override
  List<Object> get props => [];
}

class EditAddressErrorState extends EditAddressState {
  String message;

  EditAddressErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
