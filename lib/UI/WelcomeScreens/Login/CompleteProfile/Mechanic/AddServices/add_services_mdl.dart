
// To parse this JSON data, do
//
//     final addServicesMdl = addServicesMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddServicesMdl addServicesMdlFromJson(String str) => AddServicesMdl.fromJson(json.decode(str));

String addServicesMdlToJson(AddServicesMdl data) => json.encode(data.toJson());

class AddServicesMdl {
  AddServicesMdl({
    required this.data,
    required this.status,
    required this.message,
  });

  Data? data;
  String? status;
  String? message;

  factory AddServicesMdl.fromJson(Map<String, dynamic> json) => AddServicesMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] ,
    status:  json["status"] ,
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.mechanicServiceAdd,
  });

  MechanicServiceAdd? mechanicServiceAdd;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicServiceAdd: json["mechanic_service_add"] == null ? null : MechanicServiceAdd.fromJson(json["mechanic_service_add"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_service_add": mechanicServiceAdd == null ? null : mechanicServiceAdd!.toJson(),
  };
}

class MechanicServiceAdd {
  MechanicServiceAdd({
    required this.message,
  });

  String message;

  factory MechanicServiceAdd.fromJson(Map<String, dynamic> json) => MechanicServiceAdd(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
