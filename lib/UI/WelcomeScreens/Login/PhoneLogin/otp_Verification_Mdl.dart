// To parse this JSON data, do
//
//     final otpVerificationMdl = otpVerificationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OtpVerificationMdl otpVerificationMdlFromJson(String str) => OtpVerificationMdl.fromJson(json.decode(str));

String otpVerificationMdlToJson(OtpVerificationMdl data) => json.encode(data.toJson());

class OtpVerificationMdl {
  OtpVerificationMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory OtpVerificationMdl.fromJson(Map<String, dynamic> json) => OtpVerificationMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.otpVerification,
  });

  OtpVerification? otpVerification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otpVerification: json["otp_Verification"] == null ? null : OtpVerification.fromJson(json["otp_Verification"]),
  );

  Map<String, dynamic> toJson() => {
    "otp_Verification": otpVerification == null ? null : otpVerification?.toJson(),
  };
}

class OtpVerification {
  OtpVerification({
    required this.message,
  });

  String message;

  factory OtpVerification.fromJson(Map<String, dynamic> json) => OtpVerification(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
