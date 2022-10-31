// To parse this JSON data, do
//
//     final editVehicleMdl = editVehicleMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditVehicleMdl editVehicleMdlFromJson(String str) => EditVehicleMdl.fromJson(json.decode(str));

String editVehicleMdlToJson(EditVehicleMdl data) => json.encode(data.toJson());

class EditVehicleMdl {
  EditVehicleMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  Data? data;
  String message;
  String status;


  factory EditVehicleMdl.fromJson(Map<String, dynamic> json) => EditVehicleMdl(
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
    required this.vehicleUpdate,
  });

  VehicleUpdate? vehicleUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vehicleUpdate: json["vehicle_Update"] == null ? null : VehicleUpdate.fromJson(json["vehicle_Update"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicle_Update": vehicleUpdate == null ? null : vehicleUpdate!.toJson(),
  };
}

class VehicleUpdate {
  VehicleUpdate({
    required this.message,
  });

  String message;

  factory VehicleUpdate.fromJson(Map<String, dynamic> json) => VehicleUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
