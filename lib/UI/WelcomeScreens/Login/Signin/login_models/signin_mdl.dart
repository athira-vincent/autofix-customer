// To parse this JSON data, do
//
//     final signinMdl = signinMdlFromJson(jsonString);

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
    required this.customer,
    required this.mechanic,
    required this.vendor,
    required this.generalCustomer,
    required this.genMechanic,
    required this.genVendor,
    required this.isProfileCompleted,
  });

  String? token;
  Customer? customer;
  dynamic mechanic;
  dynamic vendor;
  GeneralCustomer? generalCustomer;
  dynamic genMechanic;
  dynamic genVendor;
  int? isProfileCompleted;

  factory SignIn.fromJson(Map<String, dynamic> json) => SignIn(
    token: json["token"] == null ? null : json["token"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    mechanic: json["mechanic"],
    vendor: json["vendor"],
    generalCustomer: json["generalCustomer"] == null ? null : GeneralCustomer.fromJson(json["generalCustomer"]),
    genMechanic: json["genMechanic"],
    genVendor: json["genVendor"],
    isProfileCompleted: json["isProfileCompleted"] == null ? null : json["isProfileCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "customer": customer == null ? null : customer!.toJson(),
    "mechanic": mechanic,
    "vendor": vendor,
    "generalCustomer": generalCustomer == null ? null : generalCustomer!.toJson(),
    "genMechanic": genMechanic,
    "genVendor": genVendor,
    "isProfileCompleted": isProfileCompleted == null ? null : isProfileCompleted,
  };
}

class Customer {
  Customer({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.accountType,
    required this.status,
    required this.jwtToken,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int accountType;
  int status;
  String jwtToken;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    status: json["status"] == null ? null : json["status"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "accountType": accountType == null ? null : accountType,
    "status": status == null ? null : status,
    "jwtToken": jwtToken == null ? null : jwtToken,
  };
}

class GeneralCustomer {
  GeneralCustomer({
    required this.id,
    required this.orgName,
    required this.orgType,
    required this.userId,
    required this.profilePic,
    required this.state,
    required this.resetToken,
    required this.isProfileCompleted,
    required this.govtType,
    required this.govtAgency,
    required this.ministryName,
    required this.headOfDept,
    required this.status,
  });

  String id;
  dynamic orgName;
  dynamic orgType;
  int userId;
  String profilePic;
  String state;
  String resetToken;
  int isProfileCompleted;
  dynamic govtType;
  dynamic govtAgency;
  dynamic ministryName;
  dynamic headOfDept;
  int status;

  factory GeneralCustomer.fromJson(Map<String, dynamic> json) => GeneralCustomer(
    id: json["id"] == null ? null : json["id"],
    orgName: json["org_name"],
    orgType: json["org_type"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    resetToken: json["resetToken"] == null ? null : json["resetToken"],
    isProfileCompleted: json["isProfileCompleted"] == null ? null : json["isProfileCompleted"],
    govtType: json["govt_type"],
    govtAgency: json["govt_agency"],
    ministryName: json["ministry_name"],
    headOfDept: json["head_of_dept"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "org_name": orgName,
    "org_type": orgType,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "resetToken": resetToken == null ? null : resetToken,
    "isProfileCompleted": isProfileCompleted == null ? null : isProfileCompleted,
    "govt_type": govtType,
    "govt_agency": govtAgency,
    "ministry_name": ministryName,
    "head_of_dept": headOfDept,
    "status": status == null ? null : status,
  };
}
