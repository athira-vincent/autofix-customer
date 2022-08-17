import 'package:auto_fix/Models/customer_models/spare_parts_list_model/spare_parts_list_model.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:equatable/equatable.dart';

class SparePartListState extends Equatable {
  @override
  List<Object> get props => [];
}

class SparePartListInitialState extends SparePartListState {
  @override
  List<Object> get props => [];
}

class SparePartListLoadingState extends SparePartListState {
  @override
  List<Object> get props => [];
}

class SparePartListLoadedState extends SparePartListState {
  final SparePartsListModel sparePartslistModel;

  SparePartListLoadedState({required this.sparePartslistModel});

  @override
  List<Object> get props => [];
}

class SparePartListErrorState extends SparePartListState {
  String message;

  SparePartListErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
