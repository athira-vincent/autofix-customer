import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/delete_address_model/delete_address_model.dart';
import 'package:auto_fix/Models/delete_cart_model/delete_cart_model.dart';

import 'package:equatable/equatable.dart';

class DeleteAddressState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteAddressInitialState extends DeleteAddressState {
  @override
  List<Object> get props => [];
}

class DeleteAddressLoadingState extends DeleteAddressState {
  @override
  List<Object> get props => [];
}

class DeleteAddressLoadedState extends DeleteAddressState {
  final DeleteAddressModel deleteAddressModel;

  DeleteAddressLoadedState({required this.deleteAddressModel});

  @override
  List<Object> get props => [];
}

class DeleteAddressErrorState extends DeleteAddressState {
  String message;

  DeleteAddressErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
