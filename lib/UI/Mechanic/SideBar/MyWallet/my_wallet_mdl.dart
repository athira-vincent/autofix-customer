// To parse this JSON data, do
//
//     final mechanicBrandSpecializationMdl = mechanicBrandSpecializationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicMyWalletMdl mechanicMyWalletMdlFromJson(String str) => MechanicMyWalletMdl.fromJson(json.decode(str));

String mechanicMyWalletMdlToJson(MechanicMyWalletMdl data) => json.encode(data.toJson());

class MechanicMyWalletMdl {
  MechanicMyWalletMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicMyWalletMdl.fromJson(Map<String, dynamic> json) => MechanicMyWalletMdl(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {
  };

}

