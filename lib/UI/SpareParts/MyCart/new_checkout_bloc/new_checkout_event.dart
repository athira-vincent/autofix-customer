import 'package:equatable/equatable.dart';

class NewCheckoutEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNewCheckoutEvent extends NewCheckoutEvent {
  final String cartid, addressid;

  FetchNewCheckoutEvent(this.cartid, this.addressid);

  @override
  List<Object> get props => [];
}
