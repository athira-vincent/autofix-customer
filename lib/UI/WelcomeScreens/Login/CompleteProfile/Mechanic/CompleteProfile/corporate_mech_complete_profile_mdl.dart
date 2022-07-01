
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
  dynamic apprenticeCert;
  String profilePic;
  String address;
  dynamic identificationCert;
  String numMech;
  String rcNumber;
  String yearExist;
  int status;
  int userId;

  factory MechanicWorkSelectionCorporate.fromJson(Map<String, dynamic> json) => MechanicWorkSelectionCorporate(
    id: json["id"] == null ? null : json["id"],
    workType: json["workType"] == null ? null : json["workType"],
    brands: json["brands"] == null ? null : json["brands"],
    apprenticeCert: json["apprentice_cert"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    address: json["address"] == null ? null : json["address"],
    identificationCert: json["identification_cert"],
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
    "apprentice_cert": apprenticeCert,
    "profilePic": profilePic == null ? null : profilePic,
    "address": address == null ? null : address,
    "identification_cert": identificationCert,
    "numMech": numMech == null ? null : numMech,
    "rcNumber": rcNumber == null ? null : rcNumber,
    "yearExist": yearExist == null ? null : yearExist,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
