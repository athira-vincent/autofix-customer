import 'package:meta/meta.dart';
import 'dart:convert';

AddressModel addressModelFromMap(String str) =>
    AddressModel.fromMap(json.decode(str));

String addressModelToMap(AddressModel data) => json.encode(data.toMap());

class AddressModel {
  AddressModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data!.toMap(),
      };
}

class Data {
  Data({
    required this.selectAddress,
  });

  List<SelectAddress> selectAddress;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        selectAddress: List<SelectAddress>.from(
            json["selectAddress"].map((x) => SelectAddress.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "selectAddress":
            List<dynamic>.from(selectAddress.map((x) => x.toMap())),
      };
}

class SelectAddress {
  SelectAddress({
    required this.id,
    required this.fullName,
    required this.phoneNo,
    required this.pincode,
    required this.city,
    required this.state,
    required this.address,
    required this.addressLine2,
    required this.type,
    required this.userId,
    required this.isDefault,
  });

  String id;
  String fullName;
  String phoneNo;
  String pincode;
  String city;
  String state;
  String address;
  String addressLine2;
  String type;
  int userId;
  int isDefault;

  factory SelectAddress.fromMap(Map<String, dynamic> json) => SelectAddress(
        id: json["id"],
        fullName: json["fullName"],
        phoneNo: json["phoneNo"],
        pincode: json["pincode"],
        city: json["city"],
        state: json["state"],
        address: json["address"],
        addressLine2: json["addressLine2"],
        type: json["type"] ?? "",
        userId: json["userId"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullName": fullName,
        "phoneNo": phoneNo,
        "pincode": pincode,
        "city": city,
        "state": state,
        "address": address,
        "addressLine2": addressLine2,
        "type": type,
        "userId": userId,
        "isDefault": isDefault,
      };
}
