// To parse this JSON data, do
//
//     final individualMechCompleteProfileMdl = individualMechCompleteProfileMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

IndividualMechCompleteProfileMdl individualMechCompleteProfileMdlFromJson(String str) => IndividualMechCompleteProfileMdl.fromJson(json.decode(str));

String individualMechCompleteProfileMdlToJson(IndividualMechCompleteProfileMdl data) => json.encode(data.toJson());

class IndividualMechCompleteProfileMdl {
  IndividualMechCompleteProfileMdl({
    required this.data,
    required this.status,
    required this.message,
  });

  Data? data;
  String? status;
  String? message;

  factory IndividualMechCompleteProfileMdl.fromJson(Map<String, dynamic> json) => IndividualMechCompleteProfileMdl(
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
    required this.mechanicWorkSelectionIndividual,
  });

  MechanicWorkSelectionIndividual? mechanicWorkSelectionIndividual;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicWorkSelectionIndividual: json["mechanic_work_selection_Individual"] == null ? null : MechanicWorkSelectionIndividual.fromJson(json["mechanic_work_selection_Individual"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_work_selection_Individual": mechanicWorkSelectionIndividual == null ? null : mechanicWorkSelectionIndividual!.toJson(),
  };
}

class MechanicWorkSelectionIndividual {
  MechanicWorkSelectionIndividual({
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
  dynamic noMechanics;
  dynamic rcNumber;
  dynamic yearExistence;
  int status;
  int userId;

  factory MechanicWorkSelectionIndividual.fromJson(Map<String, dynamic> json) => MechanicWorkSelectionIndividual(
    id: json["id"] == null ? null : json["id"],
    serviceType: json["service_type"] == null ? null : json["service_type"],
    apprenticeCert: json["apprentice_cert"],
    address: json["address"] == null ? null : json["address"],
    identificationCert: json["identification_cert"],
    noMechanics: json["no_mechanics"],
    rcNumber: json["rc_number"],
    yearExistence: json["year_existence"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "service_type": serviceType == null ? null : serviceType,
    "apprentice_cert": apprenticeCert,
    "address": address == null ? null : address,
    "identification_cert": identificationCert,
    "no_mechanics": noMechanics,
    "rc_number": rcNumber,
    "year_existence": yearExistence,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
