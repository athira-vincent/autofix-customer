import 'package:equatable/equatable.dart';

class AddCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAddCartEvent extends AddCartEvent {

  final String productid;
  FetchAddCartEvent(this.productid);

  @override
  List<Object> get props => [];
}