// To parse this JSON data, do
//
//     final mechanicDetailsMdl = mechanicDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicDetailsMdl mechanicDetailsMdlFromJson(String str) => MechanicDetailsMdl.fromJson(json.decode(str));

String mechanicDetailsMdlToJson(MechanicDetailsMdl data) => json.encode(data.toJson());

class MechanicDetailsMdl {
  MechanicDetailsMdl({
   required this.message,
   required this.status,
   required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicDetailsMdl.fromJson(Map<String, dynamic> json) => MechanicDetailsMdl(
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
   required this.mechanicDetails,
  });

  MechanicDetails? mechanicDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicDetails: json["mechanicDetails"] == null ? null : MechanicDetails.fromJson(json["mechanicDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicDetails": mechanicDetails == null ? null : mechanicDetails?.toJson(),
  };
}

class MechanicDetails {
  MechanicDetails({
   required this.id,
   required this.userCode,
   required this.firstName,
   required this.lastName,
   required this.emailId,
   required this.phoneNo,
   required this.userTypeId,
   required this.status,
   required this.jwtToken,
   required this.fcmToken,
   required this.otpCode,
   required this.isProfile,
   required this.otpVerified,
   required this.mechanic,
   required this.mechanicStatus,
   required this.mechanicService,
   required this.totalAmount,
   required this.distance,
   required this.duration,
   required this.reviewCount,
   required this.mechanicReviewsData,
   required this.mechanicReview,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int userTypeId;
  int status;
  String jwtToken;
  String fcmToken;
  String otpCode;
  int isProfile;
  int otpVerified;
  Mechanic? mechanic;
  MechanicStatus? mechanicStatus;
  List<MechanicService>? mechanicService;
  String totalAmount;
  String distance;
  String duration;
  int reviewCount;
  List<MechanicReviewsDatum>? mechanicReviewsData;
  int mechanicReview;

  factory MechanicDetails.fromJson(Map<String, dynamic> json) => MechanicDetails(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    status: json["status"] == null ? null : json["status"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
    mechanicStatus: json["mechanicStatus"] == null ? null : MechanicStatus.fromJson(json["mechanicStatus"]),
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
    totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
    distance: json["distance"] == null ? null : json["distance"],
    duration: json["duration"] == null ? null : json["duration"],
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
    mechanicReviewsData: json["mechanicReviewsData"] == null ? null : List<MechanicReviewsDatum>.from(json["mechanicReviewsData"].map((x) => MechanicReviewsDatum.fromJson(x))),
    mechanicReview: json["mechanicReview"] == null ? null : json["mechanicReview"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "status": status == null ? null : status,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
    "mechanic": mechanic == null ? null : mechanic?.toJson(),
    "mechanicStatus": mechanicStatus == null ? null : mechanicStatus?.toJson(),
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
    "totalAmount": totalAmount == null ? null : totalAmount,
    "distance": distance == null ? null : distance,
    "duration": duration == null ? null : duration,
    "reviewCount": reviewCount == null ? null : reviewCount,
    "mechanicReviewsData": mechanicReviewsData == null ? null : List<dynamic>.from(mechanicReviewsData!.map((x) => x.toJson())),
    "mechanicReview": mechanicReview == null ? null : mechanicReview,
  };
}

class Mechanic {
  Mechanic({
   required this.id,
   required this.displayName,
   required this.userName,
   required this.password,
   required this.firstName,
   required this.lastName,
   required this.emailId,
   required this.phoneNo,
   required this.address,
   required this.startTime,
   required this.endTime,
   required this.city,
   required this.licenseNo,
   required this.state,
   required this.licenseDate,
   required this.latitude,
   required this.longitude,
   required this.serviceId,
   required this.profilePic,
   required this.licenseProof,
   required this.status,
  });

  String id;
  dynamic displayName;
  dynamic userName;
  dynamic password;
  dynamic firstName;
  dynamic lastName;
  dynamic emailId;
  dynamic phoneNo;
  String address;
  dynamic startTime;
  dynamic endTime;
  dynamic city;
  dynamic licenseNo;
  String state;
  dynamic licenseDate;
  dynamic latitude;
  dynamic longitude;
  dynamic serviceId;
  String profilePic;
  dynamic licenseProof;
  int status;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    displayName: json["displayName"],
    userName: json["userName"],
    password: json["password"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    phoneNo: json["phoneNo"],
    address: json["address"] == null ? null : json["address"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    city: json["city"],
    licenseNo: json["licenseNo"],
    state: json["state"] == null ? null : json["state"],
    licenseDate: json["licenseDate"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    serviceId: json["serviceId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    licenseProof: json["licenseProof"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "displayName": displayName,
    "userName": userName,
    "password": password,
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "phoneNo": phoneNo,
    "address": address == null ? null : address,
    "startTime": startTime,
    "endTime": endTime,
    "city": city,
    "licenseNo": licenseNo,
    "state": state == null ? null : state,
    "licenseDate": licenseDate,
    "latitude": latitude,
    "longitude": longitude,
    "serviceId": serviceId,
    "profilePic": profilePic == null ? null : profilePic,
    "licenseProof": licenseProof,
    "status": status == null ? null : status,
  };
}

class MechanicReviewsDatum {
  MechanicReviewsDatum({
   required this.id,
   required this.transType,
   required this.rating,
   required this.feedback,
   required this.bookingId,
   required this.orderId,
   required this.status,
  });

  String id;
  int transType;
  double rating;
  String feedback;
  int bookingId;
  dynamic orderId;
  int status;

  factory MechanicReviewsDatum.fromJson(Map<String, dynamic> json) => MechanicReviewsDatum(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    feedback: json["feedback"] == null ? null : json["feedback"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    orderId: json["orderId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "rating": rating == null ? null : rating,
    "feedback": feedback == null ? null : feedback,
    "bookingId": bookingId == null ? null : bookingId,
    "orderId": orderId,
    "status": status == null ? null : status,
  };
}

class MechanicService {
  MechanicService({
   required this.id,
   required this.fee,
   required this.status,
   required this.userId,
  });

  String id;
  String fee;
  int status;
  int userId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}

class MechanicStatus {
  MechanicStatus({
   required this.distance,
  });

  dynamic distance;

  factory MechanicStatus.fromJson(Map<String, dynamic> json) => MechanicStatus(
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
  };
}
