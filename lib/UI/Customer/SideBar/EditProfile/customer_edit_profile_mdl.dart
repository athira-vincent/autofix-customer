// To parse this JSON data, do
//
//     final customerEditProfileMdl = customerEditProfileMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerEditProfileMdl customerEditProfileMdlFromJson(String str) => CustomerEditProfileMdl.fromJson(json.decode(str));

String customerEditProfileMdlToJson(CustomerEditProfileMdl data) => json.encode(data.toJson());

class CustomerEditProfileMdl {
  CustomerEditProfileMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory CustomerEditProfileMdl.fromJson(Map<String, dynamic> json) => CustomerEditProfileMdl(
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
    required this.customerIndividualProfileUpdate,
  });

  CustomerIndividualProfileUpdate? customerIndividualProfileUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerIndividualProfileUpdate: json["customer_Individual_profile_update"] == null ? null : CustomerIndividualProfileUpdate.fromJson(json["customer_Individual_profile_update"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_Individual_profile_update": customerIndividualProfileUpdate == null ? null : customerIndividualProfileUpdate!.toJson(),
  };
}

class CustomerIndividualProfileUpdate {
  CustomerIndividualProfileUpdate({
    required this.message,
  });

  String message;

  factory CustomerIndividualProfileUpdate.fromJson(Map<String, dynamic> json) => CustomerIndividualProfileUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
