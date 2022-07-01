
import 'dart:convert';

VehicleUpdateMdl vehicleUpdateMdlFromJson(String str) => VehicleUpdateMdl.fromJson(json.decode(str));

String vehicleUpdateMdlToJson(VehicleUpdateMdl data) => json.encode(data.toJson());

class VehicleUpdateMdl {
  VehicleUpdateMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory VehicleUpdateMdl.fromJson(Map<String, dynamic> json) => VehicleUpdateMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data?.toJson(),
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
    "vehicle_Update": vehicleUpdate == null ? null : vehicleUpdate?.toJson(),
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
