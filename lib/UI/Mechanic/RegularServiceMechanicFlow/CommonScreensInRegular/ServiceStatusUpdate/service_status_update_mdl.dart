// To parse this JSON data, do
//
//     final serviceStatusUpdateMdl = serviceStatusUpdateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceStatusUpdateMdl serviceStatusUpdateMdlFromJson(String str) => ServiceStatusUpdateMdl.fromJson(json.decode(str));

String serviceStatusUpdateMdlToJson(ServiceStatusUpdateMdl data) => json.encode(data.toJson());

class ServiceStatusUpdateMdl {
  ServiceStatusUpdateMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory ServiceStatusUpdateMdl.fromJson(Map<String, dynamic> json) => ServiceStatusUpdateMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.regularMechStatusUpdate,
  });

  RegularMechStatusUpdate? regularMechStatusUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    regularMechStatusUpdate: json["regularMechStatusUpdate"] == null ? null : RegularMechStatusUpdate.fromJson(json["regularMechStatusUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "regularMechStatusUpdate": regularMechStatusUpdate == null ? null : regularMechStatusUpdate!.toJson(),
  };
}

class RegularMechStatusUpdate {
  RegularMechStatusUpdate({
    required this.message,
  });

  String message;

  factory RegularMechStatusUpdate.fromJson(Map<String, dynamic> json) => RegularMechStatusUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}