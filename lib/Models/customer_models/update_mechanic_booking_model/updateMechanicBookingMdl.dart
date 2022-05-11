// To parse this JSON data, do
//
//     final updateMechanicBookingMdl = updateMechanicBookingMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateMechanicBookingMdl updateMechanicBookingMdlFromJson(String str) => UpdateMechanicBookingMdl.fromJson(json.decode(str));

String updateMechanicBookingMdlToJson(UpdateMechanicBookingMdl data) => json.encode(data.toJson());

class UpdateMechanicBookingMdl {
  UpdateMechanicBookingMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory UpdateMechanicBookingMdl.fromJson(Map<String, dynamic> json) => UpdateMechanicBookingMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.updateMechanicBooking,
  });

  UpdateMechanicBooking? updateMechanicBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    updateMechanicBooking: json["updateMechanicBooking"] == null ? null : UpdateMechanicBooking.fromJson(json["updateMechanicBooking"]),
  );

  Map<String, dynamic> toJson() => {
    "updateMechanicBooking": updateMechanicBooking == null ? null : updateMechanicBooking!.toJson(),
  };
}

class UpdateMechanicBooking {
  UpdateMechanicBooking({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory UpdateMechanicBooking.fromJson(Map<String, dynamic> json) => UpdateMechanicBooking(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
