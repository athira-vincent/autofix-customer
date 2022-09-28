// To parse this JSON data, do
//
//     final addAddressModel = addAddressModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddAddressModel addAddressModelFromMap(String str) => AddAddressModel.fromMap(json.decode(str));

String addAddressModelToMap(AddAddressModel data) => json.encode(data.toMap());

class AddAddressModel {
  AddAddressModel({
    required this.status,
    required this.message,
    required this.data,
  });
  String status;
  String message;
  Data? data;

  factory AddAddressModel.fromMap(Map<String, dynamic> json) => AddAddressModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    required this.addAddress,
  });

  AddAddress addAddress;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    addAddress: AddAddress.fromMap(json["addAddress"]),
  );

  Map<String, dynamic> toMap() => {
    "addAddress": addAddress.toMap(),
  };
}

class AddAddress {
  AddAddress({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory AddAddress.fromMap(Map<String, dynamic> json) => AddAddress(
    status: json["status"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "code": code,
    "message": message,
  };
}
