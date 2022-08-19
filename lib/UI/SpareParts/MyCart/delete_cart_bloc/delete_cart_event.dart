import 'package:equatable/equatable.dart';

class DeleteCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDeleteCartEvent extends DeleteCartEvent {

  final String productid;
  FetchDeleteCartEvent(this.productid);

  @override
  List<Object> get props => [];
}