// To parse this JSON data, do
//
//     final phoneLoginOtpVerificationMdl = phoneLoginOtpVerificationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PhoneLoginOtpVerificationMdl phoneLoginOtpVerificationMdlFromJson(String str) => PhoneLoginOtpVerificationMdl.fromJson(json.decode(str));

String phoneLoginOtpVerificationMdlToJson(PhoneLoginOtpVerificationMdl data) => json.encode(data.toJson());

class PhoneLoginOtpVerificationMdl {
  PhoneLoginOtpVerificationMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  Data? data;
  String message;
  String status;

  factory PhoneLoginOtpVerificationMdl.fromJson(Map<String, dynamic> json) => PhoneLoginOtpVerificationMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.signInOtp,
  });

  SignInOtp? signInOtp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    signInOtp: json["signIn_Otp"] == null ? null : SignInOtp.fromJson(json["signIn_Otp"]),
  );

  Map<String, dynamic> toJson() => {
    "signIn_Otp": signInOtp == null ? null : signInOtp!.toJson(),
  };
}

class SignInOtp {
  SignInOtp({
    required this.token,
    required this.user,
    required this.genCustomer,
    required this.genMechanic,
    required this.genVendor,
  });

  String token;
  User? user;
  GenCustomer? genCustomer;
  GenMechanic? genMechanic;
  dynamic genVendor;

  factory SignInOtp.fromJson(Map<String, dynamic> json) => SignInOtp(
    token: json["token"] == null ? null : json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    genCustomer: json["genCustomer"] == null ? null : GenCustomer.fromJson(json["genCustomer"]),
    genMechanic: json["genMechanic"] == null ? null : GenMechanic.fromJson(json["genMechanic"]),
    genVendor: json["genVendor"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "user": user == null ? null : user!.toJson(),
    "genCustomer": genCustomer == null ? null : genCustomer!.toJson(),
    "genMechanic": genMechanic == null ? null : genMechanic!.toJson(),
    "genVendor": genVendor,
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
  dynamic workType;
  dynamic numMech;
  dynamic rcNumber;
  dynamic address;
  dynamic apprenticeCert;
  dynamic identificationCert;
  dynamic yearExist;
  int rate;
  int reviewCount;
  int adminApprove;
  int userId;
  String profilePic;
  String state;
  int status;
  dynamic brands;

  factory GenMechanic.fromJson(Map<String, dynamic> json) => GenMechanic(
    id: json["id"] == null ? null : json["id"],
    orgName: json["orgName"],
    orgType: json["orgType"],
    yearExp: json["yearExp"] == null ? null : json["yearExp"],
    mechType: json["mechType"] == null ? null : json["mechType"],
    workType: json["workType"],
    numMech: json["numMech"],
    rcNumber: json["rcNumber"],
    address: json["address"],
    apprenticeCert: json["apprentice_cert"],
    identificationCert: json["identification_cert"],
    yearExist: json["yearExist"],
    rate: json["rate"] == null ? null : json["rate"],
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
    adminApprove: json["adminApprove"] == null ? null : json["adminApprove"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    status: json["status"] == null ? null : json["status"],
    brands: json["brands"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "orgName": orgName,
    "orgType": orgType,
    "yearExp": yearExp == null ? null : yearExp,
    "mechType": mechType == null ? null : mechType,
    "workType": workType,
    "numMech": numMech,
    "rcNumber": rcNumber,
    "address": address,
    "apprentice_cert": apprenticeCert,
    "identification_cert": identificationCert,
    "yearExist": yearExist,
    "rate": rate == null ? null : rate,
    "reviewCount": reviewCount == null ? null : reviewCount,
    "adminApprove": adminApprove == null ? null : adminApprove,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "status": status == null ? null : status,
    "brands": brands,
  };
}

class GenCustomer {
  GenCustomer({
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

  factory GenCustomer.fromJson(Map<String, dynamic> json) => GenCustomer(
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

  Map<String, dynamic> toJson() => {
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
    required this.customer,
    required this.mechanic,
    required this.vendor,
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
  String fcmToken;
  String otpCode;
  int isProfile;
  int otpVerified;
  dynamic customer;
  dynamic mechanic;
  dynamic vendor;

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
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
    customer: json["customer"],
    mechanic: json["mechanic"],
    vendor: json["vendor"],
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
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
    "customer": customer,
    "mechanic": mechanic,
    "vendor": vendor,
  };
}
