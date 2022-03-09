// To parse this JSON data, do
//
//     final corporateMechCompleteProfileMdl = corporateMechCompleteProfileMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CorporateMechCompleteProfileMdl corporateMechCompleteProfileMdlFromJson(String str) => CorporateMechCompleteProfileMdl.fromJson(json.decode(str));

String corporateMechCompleteProfileMdlToJson(CorporateMechCompleteProfileMdl data) => json.encode(data.toJson());

class CorporateMechCompleteProfileMdl {
  CorporateMechCompleteProfileMdl({
    required this.data,
    required this.status,
    required this.message,
  });

  Data? data;
  String? status;
  String? message;

  factory CorporateMechCompleteProfileMdl.fromJson(Map<String, dynamic> json) => CorporateMechCompleteProfileMdl(
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
    required this.mechanicWorkSelectionCorporate,
  });

  MechanicWorkSelectionCorporate? mechanicWorkSelectionCorporate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicWorkSelectionCorporate: json["mechanic_work_selection_Corporate"] == null ? null : MechanicWorkSelectionCorporate.fromJson(json["mechanic_work_selection_Corporate"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_work_selection_Corporate": mechanicWorkSelectionCorporate == null ? null : mechanicWorkSelectionCorporate!.toJson(),
  };
}

class MechanicWorkSelectionCorporate {
  MechanicWorkSelectionCorporate({
    required this.id,
    required this.serviceType,
    required this.apprenticeCert,
    required this.address,
    required this.identificationCert,
    required this.noMechanics,
    required this.rcNumber,
    required this.yearExistence,
    required this.status,
    required this.userId,
  });

  String id;
  String serviceType;
  dynamic apprenticeCert;
  String address;
  dynamic identificationCert;
  String noMechanics;
  String rcNumber;
  String yearExistence;
  int status;
  int userId;

  factory MechanicWorkSelectionCorporate.fromJson(Map<String, dynamic> json) => MechanicWorkSelectionCorporate(
    id: json["id"] == null ? null : json["id"],
    serviceType: json["service_type"] == null ? null : json["service_type"],
    apprenticeCert: json["apprentice_cert"],
    address: json["address"] == null ? null : json["address"],
    identificationCert: json["identification_cert"],
    noMechanics: json["no_mechanics"] == null ? null : json["no_mechanics"],
    rcNumber: json["rc_number"] == null ? null : json["rc_number"],
    yearExistence: json["year_existence"] == null ? null : json["year_existence"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "service_type": serviceType == null ? null : serviceType,
    "apprentice_cert": apprenticeCert,
    "address": address == null ? null : address,
    "identification_cert": identificationCert,
    "no_mechanics": noMechanics == null ? null : noMechanics,
    "rc_number": rcNumber == null ? null : rcNumber,
    "year_existence": yearExistence == null ? null : yearExistence,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
