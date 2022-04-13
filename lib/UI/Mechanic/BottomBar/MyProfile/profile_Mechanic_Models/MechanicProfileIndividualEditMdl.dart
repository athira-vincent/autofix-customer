// To parse this JSON data, do
//
//     final mechanicProfileIndividualEditMdl = mechanicProfileIndividualEditMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicProfileIndividualEditMdl mechanicProfileIndividualEditMdlFromJson(String str) => MechanicProfileIndividualEditMdl.fromJson(json.decode(str));

String mechanicProfileIndividualEditMdlToJson(MechanicProfileIndividualEditMdl data) => json.encode(data.toJson());

class MechanicProfileIndividualEditMdl {
  MechanicProfileIndividualEditMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicProfileIndividualEditMdl.fromJson(Map<String, dynamic> json) => MechanicProfileIndividualEditMdl(
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
    required this.mechanicSignUpIndividualUpdate,
  });

  MechanicSignUpIndividualUpdate? mechanicSignUpIndividualUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicSignUpIndividualUpdate: json["mechanic_signUp_Individual_Update"] == null ? null : MechanicSignUpIndividualUpdate.fromJson(json["mechanic_signUp_Individual_Update"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_signUp_Individual_Update": mechanicSignUpIndividualUpdate == null ? null : mechanicSignUpIndividualUpdate?.toJson(),
  };
}

class MechanicSignUpIndividualUpdate {
  MechanicSignUpIndividualUpdate({
    required this.message,
  });

  String message;

  factory MechanicSignUpIndividualUpdate.fromJson(Map<String, dynamic> json) => MechanicSignUpIndividualUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
