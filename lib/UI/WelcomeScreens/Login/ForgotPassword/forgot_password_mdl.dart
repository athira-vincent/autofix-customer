

import 'dart:convert';

ForgotPasswordMdl forgotPasswordMdlFromJson(String str) => ForgotPasswordMdl.fromJson(json.decode(str));

String forgotPasswordMdlToJson(ForgotPasswordMdl data) => json.encode(data.toJson());

class ForgotPasswordMdl {
  ForgotPasswordMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory ForgotPasswordMdl.fromJson(Map<String, dynamic> json) => ForgotPasswordMdl(
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
    required this.forgotPassword,
  });

  ForgotPassword? forgotPassword;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    forgotPassword: json["ForgotPassword"] == null ? null : ForgotPassword.fromJson(json["ForgotPassword"]),
  );

  Map<String, dynamic> toJson() => {
    "ForgotPassword": forgotPassword == null ? null : forgotPassword!.toJson(),
  };
}

class ForgotPassword {
  ForgotPassword({
    required this.otpCode,
    required this.userId,
    required this.userTypeId,
    required this.phoneNo,
  });

  String otpCode;
  int userId;
  int userTypeId;
  String phoneNo;

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
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
