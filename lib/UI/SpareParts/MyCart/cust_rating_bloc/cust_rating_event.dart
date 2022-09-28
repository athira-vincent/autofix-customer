import 'package:equatable/equatable.dart';

class CustRatingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCustRatingEvent extends CustRatingEvent {

  final String rating, orderid, productid;
  FetchCustRatingEvent(this.rating,this.orderid,this.productid);

  @override
  List<Object> get props => [];
}