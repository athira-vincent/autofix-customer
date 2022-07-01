// To parse this JSON data, do
//
//     final mechanicOrderStatusUpdateMdl = mechanicOrderStatusUpdateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicOrderStatusUpdateMdl mechanicOrderStatusUpdateMdlFromJson(String str) => MechanicOrderStatusUpdateMdl.fromJson(json.decode(str));

String mechanicOrderStatusUpdateMdlToJson(MechanicOrderStatusUpdateMdl data) => json.encode(data.toJson());

class MechanicOrderStatusUpdateMdl {
  MechanicOrderStatusUpdateMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicOrderStatusUpdateMdl.fromJson(Map<String, dynamic> json) => MechanicOrderStatusUpdateMdl(
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
    required this.mechanicStatusUpdate,
  });

  MechanicStatusUpdate? mechanicStatusUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicStatusUpdate: json["mechanic_status_update"] == null ? null : MechanicStatusUpdate.fromJson(json["mechanic_status_update"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_status_update": mechanicStatusUpdate == null ? null : mechanicStatusUpdate!.toJson(),
  };
}

class MechanicStatusUpdate {
  MechanicStatusUpdate({
    required this.message,
  });

  String message;

  factory MechanicStatusUpdate.fromJson(Map<String, dynamic> json) => MechanicStatusUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
