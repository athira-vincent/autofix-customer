import 'package:equatable/equatable.dart';

class CancelOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCancelOrderEvent extends CancelOrderEvent {

  final String orderid;
  FetchCancelOrderEvent(this.orderid);

  @override
  List<Object> get props => [];
}