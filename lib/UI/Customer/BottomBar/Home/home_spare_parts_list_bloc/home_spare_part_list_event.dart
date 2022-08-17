import 'package:equatable/equatable.dart';

class SparePartListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSparePartListEvent extends SparePartListEvent {

  String modelname,search,fromcost,tocost;

  FetchSparePartListEvent(this.modelname,this.search,this.fromcost,this.tocost);

  @override
  List<Object> get props => [];
}