import 'package:meta/meta.dart';
import 'dart:convert';

AddPriceFaultMdl addPriceFaultMdlFromJson(String str) => AddPriceFaultMdl.fromJson(json.decode(str));

String addPriceFaultMdlToJson(AddPriceFaultMdl data) => json.encode(data.toJson());

class AddPriceFaultMdl {
  AddPriceFaultMdl({
    required this.data,
  });

  Data? data;

  factory AddPriceFaultMdl.fromJson(Map<String, dynamic> json) => AddPriceFaultMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.mechanicDetails,
  });

  MechanicDetails? mechanicDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicDetails: json["mechanic_Details"] == null ? null : MechanicDetails.fromJson(json["mechanic_Details"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_Details": mechanicDetails == null ? null : mechanicDetails!.toJson(),
  };
}

class MechanicDetails {
  MechanicDetails({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.userTypeId,
    required this.accountType,
    required this.jwtToken,
    required this.status,
    required this.mechanic,
    required this.mechanicService,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int userTypeId;
  dynamic accountType;
  String jwtToken;
  int status;
  List<Mechanic>? mechanic;
  List<MechanicService>? mechanicService;

  factory MechanicDetails.fromJson(Map<String, dynamic> json) => MechanicDetails(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    accountType: json["accountType"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    status: json["status"] == null ? null : json["status"],
    mechanic: json["mechanic"] == null ? null : List<Mechanic>.from(json["mechanic"].map((x) => Mechanic.fromJson(x))),
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "accountType": accountType,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "status": status == null ? null : status,
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x.toJson())),
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
  };
}

class Mechanic {
  Mechanic({
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
  int rate;
  int reviewCount;
  int userId;
  String profilePic;
  String state;
  int status;
  String brands;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
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
    rate: json["rate"] == null ? null : json["rate"],
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
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
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "status": status == null ? null : status,
    "brands": brands == null ? null : brands,
  };
}

class MechanicService {
  MechanicService({
    required this.service,
    required this.id,
    required this.fee,
    required this.time,
    required this.status,
    required this.userId,
    required this.serviceId,
  });

  Service? service;
  String id;
  String fee;
  String time;
  int status;
  int userId;
  int serviceId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    time: json["time"] == null ? null : json["time"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
  );

  Map<String, dynamic> toJson() => {
    "service": service == null ? null : service!.toJson(),
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "time": time == null ? null : time,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
    "serviceId": serviceId == null ? null : serviceId,
  };
}

class Service {
  Service({
    required this.serviceName,
  });

  String serviceName;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
  );

  Map<String, dynamic> toJson() => {
    "serviceName": serviceName == null ? null : serviceName,
  };
}
