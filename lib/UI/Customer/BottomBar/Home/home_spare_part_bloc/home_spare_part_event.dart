import 'package:equatable/equatable.dart';

class SparePartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSparePartEvent extends SparePartEvent {

  final String modelid;
  FetchSparePartEvent(this.modelid);

  @override
  List<Object> get props => [];
}