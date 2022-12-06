import 'package:equatable/equatable.dart';

class PlaceOrderAllEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPlaceOrderAllEvent extends PlaceOrderAllEvent {
  final String addressid;

  FetchPlaceOrderAllEvent(
    this.addressid,
  );

  @override
  List<Object> get props => [];
}
