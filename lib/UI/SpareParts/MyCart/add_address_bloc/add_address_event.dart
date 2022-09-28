import 'package:equatable/equatable.dart';

class AddAddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAddAddressEvent extends AddAddressEvent {
  final String fullname,
      phone,
      pincode,
      city,
      state,
      address,
      addressline2,
      type;

  FetchAddAddressEvent(
    this.fullname,
    this.phone,
    this.pincode,
    this.city,
    this.state,
    this.address,
    this.addressline2,
    this.type,
  );

  @override
  List<Object> get props => [];
}
