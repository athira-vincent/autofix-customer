import 'package:equatable/equatable.dart';

class EditAddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEditAddressEvent extends EditAddressEvent {
  final String fullname,
      phone,
      pincode,
      city,
      state,
      address,
      addressline2,
      type;

  FetchEditAddressEvent(
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
