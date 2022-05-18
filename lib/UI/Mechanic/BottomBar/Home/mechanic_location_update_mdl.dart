// To parse this JSON data, do
//
//     final mechanicLocationUpdateMdl = mechanicLocationUpdateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicLocationUpdateMdl mechanicLocationUpdateMdlFromJson(String str) => MechanicLocationUpdateMdl.fromJson(json.decode(str));

String mechanicLocationUpdateMdlToJson(MechanicLocationUpdateMdl data) => json.encode(data.toJson());

class MechanicLocationUpdateMdl {
  MechanicLocationUpdateMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicLocationUpdateMdl.fromJson(Map<String, dynamic> json) => MechanicLocationUpdateMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.mechanicLocationUpdate,
  });

  MechanicLocationUpdate? mechanicLocationUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicLocationUpdate: json["mechanic_location_update"] == null ? null : MechanicLocationUpdate.fromJson(json["mechanic_location_update"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_location_update": mechanicLocationUpdate == null ? null : mechanicLocationUpdate!.toJson(),
  };
}

class MechanicLocationUpdate {
  MechanicLocationUpdate({
    required this.message,
  });

  String message;

  factory MechanicLocationUpdate.fromJson(Map<String, dynamic> json) => MechanicLocationUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
