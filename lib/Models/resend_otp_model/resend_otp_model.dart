// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResendOtpModel resendOtpModelFromJson(String str) => ResendOtpModel.fromJson(json.decode(str));

String resendOtpModelToJson(ResendOtpModel data) => json.encode(data.toJson());

class ResendOtpModel {
  ResendOtpModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data? data;
  String message;
  String status;

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
    message: json["message"] ?? null,
    status: json["status"] ?? null,
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.resendOtp,
  });

  ResendOtp? resendOtp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resendOtp: json["resendOtp"] == null ? null : ResendOtp.fromJson(json["resendOtp"]),
  );

  Map<String, dynamic> toJson() => {
    "resendOtp": resendOtp == null ? null : resendOtp!.toJson(),
  };
}

class ResendOtp {
  ResendOtp({
    required this.otpCode,
    required this.userId,
    required this.userTypeId,
    required this.phoneNo,
  });

  String otpCode;
  int userId;
  int userTypeId;
  String phoneNo;

  factory ResendOtp.fromJson(Map<String, dynamic> json) => ResendOtp(
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    userId: json["userId"] == null ? null : json["userId"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "otpCode": otpCode == null ? null : otpCode,
    "userId": userId == null ? null : userId,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "phoneNo": phoneNo == null ? null : phoneNo,
  };
}
