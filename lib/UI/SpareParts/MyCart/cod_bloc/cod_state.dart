import 'package:auto_fix/Models/cod_model/cod_model.dart';
import 'package:auto_fix/Models/customer_models/delete_address_model/delete_address_model.dart';

import 'package:equatable/equatable.dart';

class CodState extends Equatable {
  @override
  List<Object> get props => [];
}

class CodInitialState extends CodState {
  @override
  List<Object> get props => [];
}

class CodLoadingState extends CodState {
  @override
  List<Object> get props => [];
}

class CodLoadedState extends CodState {
  final Codmodel codmodel;

  CodLoadedState({required this.codmodel});

  @override
  List<Object> get props => [];
}

class CodErrorState extends CodState {
  String message;

  CodErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
