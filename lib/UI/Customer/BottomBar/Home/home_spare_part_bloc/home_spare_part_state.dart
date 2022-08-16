import 'package:auto_fix/Models/customer_models/spare_parts_model/spare_parts_model.dart';
import 'package:equatable/equatable.dart';

class SparePartState extends Equatable {
  @override
  List<Object> get props => [];
}

class SparePartInitialState extends SparePartState {
  @override
  List<Object> get props => [];
}

class SparePartLoadingState extends SparePartState {
  @override
  List<Object> get props => [];
}

class SparePartLoadedState extends SparePartState {
  final SparePartsModel sparePartsModel;

  SparePartLoadedState({required this.sparePartsModel});

  @override
  List<Object> get props => [];
}

class SparePartErrorState extends SparePartState {
  String message;

  SparePartErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
