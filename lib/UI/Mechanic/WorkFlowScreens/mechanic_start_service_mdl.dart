// To parse this JSON data, do
//
//     final mechanicIncomingJobMdl = mechanicIncomingJobMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicAddMoreServiceMdl mechanicIncomingJobMdlFromJson(String str) => MechanicAddMoreServiceMdl.fromJson(json.decode(str));

String mechanicIncomingJobMdlToJson(MechanicAddMoreServiceMdl data) => json.encode(data.toJson());

class MechanicAddMoreServiceMdl {
  MechanicAddMoreServiceMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicAddMoreServiceMdl.fromJson(Map<String, dynamic> json) => MechanicAddMoreServiceMdl(
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



  factory Data.fromJson(Map<String, dynamic> json) => Data(

  );

  Map<String, dynamic> toJson() => {
  };
}

