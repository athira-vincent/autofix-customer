// To parse this JSON data, do
//
//     final updateDefaultVehicleMdl = updateDefaultVehicleMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateDefaultVehicleMdl updateDefaultVehicleMdlFromJson(String str) => UpdateDefaultVehicleMdl.fromJson(json.decode(str));

String updateDefaultVehicleMdlToJson(UpdateDefaultVehicleMdl data) => json.encode(data.toJson());

class UpdateDefaultVehicleMdl {
  UpdateDefaultVehicleMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  Data? data;
  String message;
  String status;

  factory UpdateDefaultVehicleMdl.fromJson(Map<String, dynamic> json) => UpdateDefaultVehicleMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data?.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    @required this.updateDefaultVehicle,
  });

  UpdateDefaultVehicle? updateDefaultVehicle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    updateDefaultVehicle: json["updateDefaultVehicle"] == null ? null : UpdateDefaultVehicle.fromJson(json["updateDefaultVehicle"]),
  );

  Map<String, dynamic> toJson() => {
    "updateDefaultVehicle": updateDefaultVehicle == null ? null : updateDefaultVehicle?.toJson(),
  };
}

class UpdateDefaultVehicle {
  UpdateDefaultVehicle({
    required this.message,
  });

  String message;

  factory UpdateDefaultVehicle.fromJson(Map<String, dynamic> json) => UpdateDefaultVehicle(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
