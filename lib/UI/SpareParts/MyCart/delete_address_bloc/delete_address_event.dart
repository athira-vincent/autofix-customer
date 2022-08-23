import 'package:equatable/equatable.dart';

class DeleteAddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDeleteAddressEvent extends DeleteAddressEvent {

  final String addressid,status;
  FetchDeleteAddressEvent(this.addressid,this.status);

  @override
  List<Object> get props => [];
}