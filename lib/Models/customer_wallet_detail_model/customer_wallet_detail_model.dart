// To parse this JSON data, do
//
//     final customerWalletDetailModel = customerWalletDetailModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerWalletDetailModel customerWalletDetailModelFromMap(String str) => CustomerWalletDetailModel.fromMap(json.decode(str));

String customerWalletDetailModelToMap(CustomerWalletDetailModel data) => json.encode(data.toMap());

class CustomerWalletDetailModel {
  CustomerWalletDetailModel({
    required this.data,
  });

  Data? data;

  factory CustomerWalletDetailModel.fromMap(Map<String, dynamic> json) => CustomerWalletDetailModel(
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    required this.walletDetails,
  });

  WalletDetails walletDetails;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    walletDetails: WalletDetails.fromMap(json["walletDetails"]),
  );

  Map<String, dynamic> toMap() => {
    "walletDetails": walletDetails.toMap(),
  };
}

class WalletDetails {
  WalletDetails({
    required this.id,
    required this.type,
    required this.amount,
    required this.balance,
    required this.recordDate,
    required this.reference,
    required this.paymentMode,
    required this.status,
    required this.customerId,
    required this.customer,
  });

  int id;
  int type;
  int amount;
  int balance;
  DateTime recordDate;
  String reference;
  int paymentMode;
  int status;
  int customerId;
  Customer customer;

  factory WalletDetails.fromMap(Map<String, dynamic> json) => WalletDetails(
    id: json["id"],
    type: json["type"],
    amount: json["amount"],
    balance: json["balance"],
    recordDate: DateTime.parse(json["recordDate"]),
    reference: json["reference"],
    paymentMode: json["paymentMode"],
    status: json["status"],
    customerId: json["customerId"],
    customer: Customer.fromMap(json["customer"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "amount": amount,
    "balance": balance,
    "recordDate": recordDate.toIso8601String(),
    "reference": reference,
    "paymentMode": paymentMode,
    "status": status,
    "customerId": customerId,
    "customer": customer.toMap(),
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

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    id: json["id"],
    userCode: json["userCode"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    phoneNo: json["phoneNo"],
    status: json["status"],
    userTypeId: json["userTypeId"],
    jwtToken: json["jwtToken"],
    fcmToken: json["fcmToken"],
    otpCode: json["otpCode"],
    isProfile: json["isProfile"],
    otpVerified: json["otpVerified"],
    customer: json["customer"],
    mechanic: json["mechanic"],
    vendor: json["vendor"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userCode": userCode,
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "phoneNo": phoneNo,
    "status": status,
    "userTypeId": userTypeId,
    "jwtToken": jwtToken,
    "fcmToken": fcmToken,
    "otpCode": otpCode,
    "isProfile": isProfile,
    "otpVerified": otpVerified,
    "customer": customer,
    "mechanic": mechanic,
    "vendor": vendor,
  };
}
