import 'package:equatable/equatable.dart';

class DeleteCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDeleteCartEvent extends DeleteCartEvent {

  final String productid,quantity,status;
  FetchDeleteCartEvent(this.productid,this.quantity,this.status);

  @override
  List<Object> get props => [];
}