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
    required this.workType,
    required this.brands,
    required this.apprenticeCert,
    required this.profilePic,
    required this.address,
    required this.identificationCert,
    required this.numMech,
    required this.rcNumber,
    required this.yearExist,
    required this.status,
    required this.userId,
  });

  String id;
  String workType;
  String brands;
  String apprenticeCert;
  String profilePic;
  String address;
  String identificationCert;
  String numMech;
  String rcNumber;
  String yearExist;
  int status;
  int userId;

  factory MechanicWorkSelectionIndividual.fromJson(Map<String, dynamic> json) => MechanicWorkSelectionIndividual(
    id: json["id"] == null ? null : json["id"],
    workType: json["workType"] == null ? null : json["workType"],
    brands: json["brands"] == null ? null : json["brands"],
    apprenticeCert: json["apprentice_cert"] == null ? null : json["apprentice_cert"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    address: json["address"] == null ? null : json["address"],
    identificationCert: json["identification_cert"] == null ? null : json["identification_cert"],
    numMech: json["numMech"] == null ? null : json["numMech"],
    rcNumber: json["rcNumber"] == null ? null : json["rcNumber"],
    yearExist: json["yearExist"] == null ? null : json["yearExist"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "workType": workType == null ? null : workType,
    "brands": brands == null ? null : brands,
    "apprentice_cert": apprenticeCert == null ? null : apprenticeCert,
    "profilePic": profilePic == null ? null : profilePic,
    "address": address == null ? null : address,
    "identification_cert": identificationCert == null ? null : identificationCert,
    "numMech": numMech == null ? null : numMech,
    "rcNumber": rcNumber == null ? null : rcNumber,
    "yearExist": yearExist == null ? null : yearExist,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
