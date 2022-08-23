// To parse this JSON data, do
//
//     final deleteAddressModel = deleteAddressModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteAddressModel deleteAddressModelFromMap(String str) => DeleteAddressModel.fromMap(json.decode(str));

String deleteAddressModelToMap(DeleteAddressModel data) => json.encode(data.toMap());

class DeleteAddressModel {
  DeleteAddressModel({
    required this.status,
    required this.message,
    required this.data,
  });
  String status;
  String message;
  Data? data;

  factory DeleteAddressModel.fromMap(Map<String, dynamic> json) => DeleteAddressModel(
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
    required this.updateAddress,
  });

  UpdateAddress updateAddress;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    updateAddress: UpdateAddress.fromMap(json["updateAddress"]),
  );

  Map<String, dynamic> toMap() => {
    "updateAddress": updateAddress.toMap(),
  };
}

class UpdateAddress {
  UpdateAddress({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory UpdateAddress.fromMap(Map<String, dynamic> json) => UpdateAddress(
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
