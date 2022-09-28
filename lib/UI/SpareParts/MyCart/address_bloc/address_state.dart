import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';
import 'package:auto_fix/Models/customer_models/get_address_model/get_address_model.dart';

import 'package:equatable/equatable.dart';

class AddressState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddressInitialState extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressLoadingState extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressLoadedState extends AddressState {
  final AddressModel addressModel;

  AddressLoadedState({required this.addressModel});

  @override
  List<Object> get props => [];
}

class AddressErrorState extends AddressState {
  String message;

  AddressErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
