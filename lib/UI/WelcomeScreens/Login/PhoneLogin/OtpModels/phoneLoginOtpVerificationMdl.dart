
import 'dart:convert';

PhoneLoginOtpVerificationMdl phoneLoginOtpVerificationMdlFromJson(String str) => PhoneLoginOtpVerificationMdl.fromJson(json.decode(str));

String phoneLoginOtpVerificationMdlToJson(PhoneLoginOtpVerificationMdl data) => json.encode(data.toJson());

class PhoneLoginOtpVerificationMdl {
  PhoneLoginOtpVerificationMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory PhoneLoginOtpVerificationMdl.fromJson(Map<String, dynamic> json) => PhoneLoginOtpVerificationMdl(
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
    required this.signInOtp,
  });

  SignInOtp? signInOtp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    signInOtp: json["signIn_Otp"] == null ? null : SignInOtp.fromJson(json["signIn_Otp"]),
  );

  Map<String, dynamic> toJson() => {
    "signIn_Otp": signInOtp == null ? null : signInOtp?.toJson(),
  };
}

class SignInOtp {
  SignInOtp({
    required this.token,
    required this.user,
  });

  String token;
  User? user;

  factory SignInOtp.fromJson(Map<String, dynamic> json) => SignInOtp(
    token: json["token"] == null ? null : json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "user": user == null ? null : user?.toJson(),
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
  String fcmToken;
  String otpCode;
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
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
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
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
  };
}
