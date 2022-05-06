// To parse this JSON data, do
//
//     final vehicleCreateMdl = vehicleCreateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicUpcomingServiceMdl vehicleCreateMdlFromJson(String str) => MechanicUpcomingServiceMdl.fromJson(json.decode(str));

String vehicleCreateMdlToJson(MechanicUpcomingServiceMdl data) => json.encode(data.toJson());

class MechanicUpcomingServiceMdl {
  MechanicUpcomingServiceMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicUpcomingServiceMdl.fromJson(Map<String, dynamic> json) => MechanicUpcomingServiceMdl(
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
  Data();


  factory Data.fromJson(Map<String, dynamic> json) => Data(

  );

  Map<String, dynamic> toJson() => {

  };
}

