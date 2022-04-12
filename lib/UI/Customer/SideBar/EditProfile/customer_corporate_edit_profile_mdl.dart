// To parse this JSON data, do
//
//     final customerCorporateEditProfileMdl = customerCorporateEditProfileMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerCorporateEditProfileMdl customerCorporateEditProfileMdlFromJson(String str) => CustomerCorporateEditProfileMdl.fromJson(json.decode(str));

String customerCorporateEditProfileMdlToJson(CustomerCorporateEditProfileMdl data) => json.encode(data.toJson());

class CustomerCorporateEditProfileMdl {
  CustomerCorporateEditProfileMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory CustomerCorporateEditProfileMdl.fromJson(Map<String, dynamic> json) => CustomerCorporateEditProfileMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    required this.customerCorporateProfileUpdate,
  });

  CustomerCorporateProfileUpdate? customerCorporateProfileUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerCorporateProfileUpdate: json["customer_Corporate_profile_update"] == null ? null : CustomerCorporateProfileUpdate.fromJson(json["customer_Corporate_profile_update"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_Corporate_profile_update": customerCorporateProfileUpdate == null ? null : customerCorporateProfileUpdate!.toJson(),
  };
}

class CustomerCorporateProfileUpdate {
  CustomerCorporateProfileUpdate({
    required this.message,
  });

  String message;

  factory CustomerCorporateProfileUpdate.fromJson(Map<String, dynamic> json) => CustomerCorporateProfileUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
