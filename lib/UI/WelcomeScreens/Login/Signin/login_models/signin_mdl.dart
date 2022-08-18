// To parse this JSON data, do
//
//     final signinMdl = signinMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SigninMdl signinMdlFromJson(String str) => SigninMdl.fromJson(json.decode(str));

String signinMdlToJson(SigninMdl data) => json.encode(data.toJson());

class SigninMdl {
  SigninMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory SigninMdl.fromJson(Map<String, dynamic> json) => SigninMdl(
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
  Data({
    required this.signIn,
  });

  SignIn? signIn;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    signIn: json["SignIn"] == null ? null : SignIn.fromJson(json["SignIn"]),
  );

  Map<String, dynamic> toJson() => {
    "SignIn": signIn == null ? null : signIn!.toJson(),
  };
}

class SignIn {
  SignIn({
    required this.token,
    required this.user,
    required this.vendor,
    required this.admin,
    required this.generalCustomer,
    required this.genMechanic,
    required this.genVendor,
  });

  String? token;
  User? user;
  dynamic vendor;
  dynamic admin;
  GeneralCustomer? generalCustomer;
  GenMechanic? genMechanic;
  dynamic genVendor;

  factory SignIn.fromJson(Map<String, dynamic> json) => SignIn(
    token: json["token"] == null ? null : json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    vendor: json["vendor"],
    admin: json["admin"],
    generalCustomer: json["generalCustomer"] == null ? null : GeneralCustomer.fromMap(json["generalCustomer"]),
    genMechanic: json["genMechanic"] == null ? null : GenMechanic.fromMap(json["genMechanic"]),
    genVendor: json["genVendor"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "user": user == null ? null : user!.toJson(),
    "vendor": vendor,
    "admin": admin,
    "generalCustomer": generalCustomer == null ? null : generalCustomer!.toMap(),
    "genMechanic": genMechanic == null ? null : genMechanic!.toMap(),
    "genVendor": genVendor,

  };
}

class User {
  User({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.status,
    required this.userTypeId,
    required this.jwtToken,
    required this.fcmToken,
    required this.otpCode,
    required this.isProfile,
    required this.otpVerified,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int status;
  int userTypeId;
  String jwtToken;
  dynamic fcmToken;
  dynamic otpCode;
  int isProfile;
  int otpVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    status: json["status"] == null ? null : json["status"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToken: json["fcmToken"],
    otpCode: json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "status": status == null ? null : status,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToken": fcmToken,
    "otpCode": otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
  };
}

class GenMechanic {
  GenMechanic({
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

  factory GenMechanic.fromMap(Map<String, dynamic> json) => GenMechanic(
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

  Map<String, dynamic> toMap() => {
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

class GeneralCustomer {
  GeneralCustomer({
    required this.id,
    required this.custType,
    required this.orgName,
    required this.orgType,
    required this.userId,
    required this.profilePic,
    required this.state,
    required this.ministryName,
    required this.hod,
    required this.status,
  });

  String id;
  String custType;
  dynamic orgName;
  dynamic orgType;
  int userId;
  String profilePic;
  String state;
  dynamic ministryName;
  dynamic hod;
  int status;

  factory GeneralCustomer.fromMap(Map<String, dynamic> json) => GeneralCustomer(
    id: json["id"] == null ? null : json["id"],
    custType: json["custType"] == null ? null : json["custType"],
    orgName: json["orgName"],
    orgType: json["orgType"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    ministryName: json["ministryName"],
    hod: json["hod"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "custType": custType == null ? null : custType,
    "orgName": orgName,
    "orgType": orgType,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "ministryName": ministryName,
    "hod": hod,
    "status": status == null ? null : status,
  };
}
