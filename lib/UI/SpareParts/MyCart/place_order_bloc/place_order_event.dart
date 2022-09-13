import 'package:equatable/equatable.dart';

class PlaceOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPlaceOrderEvent extends PlaceOrderEvent {

  final String qty,totalprice,productid,addressid;
  FetchPlaceOrderEvent(this.qty,this.totalprice,this.productid,this.addressid,);

  @override
  List<Object> get props => [];
}