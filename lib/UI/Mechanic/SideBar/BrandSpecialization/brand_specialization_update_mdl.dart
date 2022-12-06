// To parse this JSON data, do
//
//     final updateBrandSpecializationMdl = updateBrandSpecializationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateBrandSpecializationMdl updateBrandSpecializationMdlFromJson(String str) => UpdateBrandSpecializationMdl.fromJson(json.decode(str));

String updateBrandSpecializationMdlToJson(UpdateBrandSpecializationMdl data) => json.encode(data.toJson());

class UpdateBrandSpecializationMdl {
  UpdateBrandSpecializationMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  UpdateBrandSpecializationMdlData? data;
  String status;
  String message;

  factory UpdateBrandSpecializationMdl.fromJson(Map<String, dynamic> json) => UpdateBrandSpecializationMdl(
    data: json["data"] == null ? null : UpdateBrandSpecializationMdlData.fromJson(json["data"]),
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class UpdateBrandSpecializationMdlData {
  UpdateBrandSpecializationMdlData({
    required this.mechBrandUpdate,
  });

  MechBrandUpdate? mechBrandUpdate;

  factory UpdateBrandSpecializationMdlData.fromJson(Map<String, dynamic> json) => UpdateBrandSpecializationMdlData(
    mechBrandUpdate: json["mechBrandUpdate"] == null ? null : MechBrandUpdate.fromJson(json["mechBrandUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "mechBrandUpdate": mechBrandUpdate == null ? null : mechBrandUpdate!.toJson(),
  };
}

class MechBrandUpdate {
  MechBrandUpdate({
    required this.message,
    required this.data,
  });

  dynamic message;
  MechBrandUpdateData? data;

  factory MechBrandUpdate.fromJson(Map<String, dynamic> json) => MechBrandUpdate(
    message: json["message"],
    data: json["data"] == null ? null : MechBrandUpdateData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? null : data!.toJson(),
  };
}

class MechBrandUpdateData {
  MechBrandUpdateData({
    required this.id,
    required this.orgName,
    required this.orgType,
    required this.yearExp,
    required this.mechType,
    required this.workType,
    required this.numMech,
    required this.rcNumber,
    required this.address,
    required this.apprenticeCert,
    required this.identificationCert,
    required this.yearExist,
    required this.rate,
    required this.reviewCount,
    required this.adminApprove,
    required this.userId,
    required this.profilePic,
    required this.state,
    required this.status,
    required this.brands,
  });

  String id;
  dynamic orgName;
  dynamic orgType;
  String yearExp;
  String mechType;
  String workType;
  dynamic numMech;
  dynamic rcNumber;
  String address;
  String apprenticeCert;
  String identificationCert;
  dynamic yearExist;
  double rate;
  int reviewCount;
  int adminApprove;
  int userId;
  String profilePic;
  String state;
  int status;
  String brands;

  factory MechBrandUpdateData.fromJson(Map<String, dynamic> json) => MechBrandUpdateData(
    id: json["id"] == null ? null : json["id"],
    orgName: json["orgName"],
    orgType: json["orgType"],
    yearExp: json["yearExp"] == null ? null : json["yearExp"],
    mechType: json["mechType"] == null ? null : json["mechType"],
    workType: json["workType"] == null ? null : json["workType"],
    numMech: json["numMech"],
    rcNumber: json["rcNumber"],
    address: json["address"] == null ? null : json["address"],
    apprenticeCert: json["apprentice_cert"] == null ? null : json["apprentice_cert"],
    identificationCert: json["identification_cert"] == null ? null : json["identification_cert"],
    yearExist: json["yearExist"],
    rate: json["rate"] == null ? null : json["rate"].toDouble(),
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
    adminApprove: json["adminApprove"] == null ? null : json["adminApprove"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    status: json["status"] == null ? null : json["status"],
    brands: json["brands"] == null ? null : json["brands"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "orgName": orgName,
    "orgType": orgType,
    "yearExp": yearExp == null ? null : yearExp,
    "mechType": mechType == null ? null : mechType,
    "workType": workType == null ? null : workType,
    "numMech": numMech,
    "rcNumber": rcNumber,
    "address": address == null ? null : address,
    "apprentice_cert": apprenticeCert == null ? null : apprenticeCert,
    "identification_cert": identificationCert == null ? null : identificationCert,
    "yearExist": yearExist,
    "rate": rate == null ? null : rate,
    "reviewCount": reviewCount == null ? null : reviewCount,
    "adminApprove": adminApprove == null ? null : adminApprove,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "status": status == null ? null : status,
    "brands": brands == null ? null : brands,
  };
}
