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
    required this.status,
    required this.message,
  });

  String status;
  String message;
  Data? data;

  factory CustomerWalletDetailModel.fromMap(Map<String, dynamic> json) => CustomerWalletDetailModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: Data.fromMap(json["data"]) == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data!.toMap() == null ? null : data!.toMap(),
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
    "walletDetails": walletDetails.toMap() == null ? null : walletDetails.toMap(),
  };
}

class WalletDetails {
  WalletDetails({
    required this.walletData,
    required this.totalBalance,
  });

  WalletData? walletData;
  int totalBalance;

  factory WalletDetails.fromMap(Map<String, dynamic> json) => WalletDetails(
    walletData: json["walletData"] == null ? null : WalletData.fromMap(json["walletData"]),
    totalBalance: json["totalBalance"] == null ? null : json["totalBalance"],
  );

  Map<String, dynamic> toMap() => {
    "walletData": walletData == null ? null : walletData!.toMap(),
    "totalBalance": totalBalance == null ? null : totalBalance,
  };
}

class WalletData {
  WalletData({
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
  DateTime? recordDate;
  dynamic reference;
  int paymentMode;
  int status;
  int customerId;
  Customer? customer;

  factory WalletData.fromMap(Map<String, dynamic> json) => WalletData(
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    amount: json["amount"] == null ? null : json["amount"],
    balance: json["balance"] == null ? null : json["balance"],
    recordDate: json["recordDate"] == null ? null : DateTime.parse(json["recordDate"]),
    reference: json["reference"],
    paymentMode: json["paymentMode"] == null ? null : json["paymentMode"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    customer: json["customer"] == null ? null : Customer.fromMap(json["customer"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "amount": amount == null ? null : amount,
    "balance": balance == null ? null : balance,
    "recordDate": recordDate == null ? null : recordDate!.toIso8601String(),
    "reference": reference,
    "paymentMode": paymentMode == null ? null : paymentMode,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "customer": customer == null ? null : customer!.toMap(),
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

  Map<String, dynamic> toMap() => {
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

