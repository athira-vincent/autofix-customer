// To parse this JSON data, do
//
//     final customersSignUpIndividualMdl = customersSignUpIndividualMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomersSignUpIndividualMdl customersSignUpIndividualMdlFromJson(String str) => CustomersSignUpIndividualMdl.fromJson(json.decode(str));

String customersSignUpIndividualMdlToJson(CustomersSignUpIndividualMdl data) => json.encode(data.toJson());

class CustomersSignUpIndividualMdl {
  CustomersSignUpIndividualMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory CustomersSignUpIndividualMdl.fromJson(Map<String, dynamic> json) => CustomersSignUpIndividualMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] ,
    status:  json["status"] ,
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.customersSignUpIndividual,
  });

  CustomersSignUpIndividual? customersSignUpIndividual;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customersSignUpIndividual: json["customersSignUp_Individual"] == null ? null : CustomersSignUpIndividual.fromJson(json["customersSignUp_Individual"]),
  );

  Map<String, dynamic> toJson() => {
    "customersSignUp_Individual": customersSignUpIndividual == null ? null : customersSignUpIndividual?.toJson(),
  };
}

class CustomersSignUpIndividual {
  CustomersSignUpIndividual({
    required this.token,
    required this.customer,
    required this.isProfileCompleted,
  });

  String token;
  Customer? customer;
  int isProfileCompleted;

  factory CustomersSignUpIndividual.fromJson(Map<String, dynamic> json) => CustomersSignUpIndividual(
    token: json["token"] == null ? null : json["token"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    isProfileCompleted: json["isProfile_Completed"] == null ? null : json["isProfile_Completed"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "customer": customer == null ? null : customer?.toJson(),
    "isProfile_Completed": isProfileCompleted == null ? null : isProfileCompleted,
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
    required this.state,
    required this.userType,
    required this.accountType,
    required this.profilePic,
    required this.isProfileCompleted,
    required this.status,
  });

  String id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  String state;
  int userType;
  int accountType;
  dynamic profilePic;
  int isProfileCompleted;
  int status;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    state: json["state"] == null ? null : json["state"],
    userType: json["userType"] == null ? null : json["userType"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    profilePic: json["profilePic"],
    isProfileCompleted: json["isProfile_Completed"] == null ? null : json["isProfile_Completed"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "state": state == null ? null : state,
    "userType": userType == null ? null : userType,
    "accountType": accountType == null ? null : accountType,
    "profilePic": profilePic,
    "isProfile_Completed": isProfileCompleted == null ? null : isProfileCompleted,
    "status": status == null ? null : status,
  };
}
