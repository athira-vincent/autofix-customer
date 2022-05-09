import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final vehicleCreateMdl = vehicleCreateMdlFromJson(jsonString);

import 'dart:convert';

MechanicActiveServiceUpdateMdl mechanicActiveServiceMdlFromJson(String str) => MechanicActiveServiceUpdateMdl.fromJson(json.decode(str));

String vehicleCreateMdlToJson(MechanicActiveServiceUpdateMdl data) => json.encode(data.toJson());

class MechanicActiveServiceUpdateMdl {
  MechanicActiveServiceUpdateMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicActiveServiceUpdateMdl.fromJson(Map<String, dynamic> json) => MechanicActiveServiceUpdateMdl(
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

