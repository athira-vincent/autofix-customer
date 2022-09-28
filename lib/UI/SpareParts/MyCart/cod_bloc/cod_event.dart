import 'package:equatable/equatable.dart';

class CodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCodEvent extends CodEvent {

  final String amount,orderid;
  FetchCodEvent(this.amount,this.orderid);

  @override
  List<Object> get props => [];
}