// To parse this JSON data, do
//
//     final mechanicProfileCorporateEditMdl = mechanicProfileCorporateEditMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicProfileCorporateEditMdl mechanicProfileCorporateEditMdlFromJson(String str) => MechanicProfileCorporateEditMdl.fromJson(json.decode(str));

String mechanicProfileCorporateEditMdlToJson(MechanicProfileCorporateEditMdl data) => json.encode(data.toJson());

class MechanicProfileCorporateEditMdl {
  MechanicProfileCorporateEditMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicProfileCorporateEditMdl.fromJson(Map<String, dynamic> json) => MechanicProfileCorporateEditMdl(
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
    required this.mechanicSignUpCorporateUpdate,
  });

  MechanicSignUpCorporateUpdate? mechanicSignUpCorporateUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicSignUpCorporateUpdate: json["mechanic_signUp_Corporate_Update"] == null ? null : MechanicSignUpCorporateUpdate.fromJson(json["mechanic_signUp_Corporate_Update"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_signUp_Corporate_Update": mechanicSignUpCorporateUpdate == null ? null : mechanicSignUpCorporateUpdate?.toJson(),
  };
}

class MechanicSignUpCorporateUpdate {
  MechanicSignUpCorporateUpdate({
    required this.message,
  });

  String message;

  factory MechanicSignUpCorporateUpdate.fromJson(Map<String, dynamic> json) => MechanicSignUpCorporateUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
