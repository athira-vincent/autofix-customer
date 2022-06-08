// To parse this JSON data, do
//
//     final mechanicDetailsMdl = mechanicDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicDetailsMdl mechanicDetailsMdlFromJson(String str) => MechanicDetailsMdl.fromJson(json.decode(str));

String mechanicDetailsMdlToJson(MechanicDetailsMdl data) => json.encode(data.toJson());

class MechanicDetailsMdl {
  MechanicDetailsMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory MechanicDetailsMdl.fromJson(Map<String, dynamic> json) => MechanicDetailsMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
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
  dynamic otpCode;
  int isProfile;
  int otpVerified;
  List<Mechanic>? mechanic;
  List<MechanicStatus>? mechanicStatus;
  List<MechanicService>? mechanicService;
  String totalAmount;
  String distance;
  String duration;
  int reviewCount;
  List<MechanicReviewsDatum>? mechanicReviewsData;
  var mechanicReview;

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
    otpCode: json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
    mechanic: json["mechanic"] == null ? null : List<Mechanic>.from(json["mechanic"].map((x) => Mechanic.fromJson(x))),
    mechanicStatus: json["mechanicStatus"] == null ? null : List<MechanicStatus>.from(json["mechanicStatus"].map((x) => MechanicStatus.fromJson(x))),
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
    "otpCode": otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x.toJson())),
    "mechanicStatus": mechanicStatus == null ? null : List<dynamic>.from(mechanicStatus!.map((x) => x.toJson())),
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
    required this.address,
    required this.profilePic,
    required this.yearExp,
    required this.noMech,
    required this.status,
  });

  String id;
  String address;
  String profilePic;
  int yearExp;
  dynamic noMech;
  int status;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    address: json["address"] == null ? null : json["address"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    yearExp: json["yearExp"] == null ? null : json["yearExp"],
    noMech: json["noMech"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "address": address == null ? null : address,
    "profilePic": profilePic == null ? null : profilePic,
    "yearExp": yearExp == null ? null : yearExp,
    "noMech": noMech,
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
    required this.bookings,
    required this.orderId,
    required this.status,
  });

  String id;
  int transType;
  double rating;
  String feedback;
  int bookingId;
  Bookings? bookings;
  dynamic orderId;
  int status;

  factory MechanicReviewsDatum.fromJson(Map<String, dynamic> json) => MechanicReviewsDatum(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    feedback: json["feedback"] == null ? null : json["feedback"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    bookings: json["bookings"] == null ? null : Bookings.fromJson(json["bookings"]),
    orderId: json["orderId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "rating": rating == null ? null : rating,
    "feedback": feedback == null ? null : feedback,
    "bookingId": bookingId == null ? null : bookingId,
    "bookings": bookings == null ? null : bookings?.toJson(),
    "orderId": orderId,
    "status": status == null ? null : status,
  };
}

class Bookings {
  Bookings({
    required this.customer,
  });

  BookingsCustomer? customer;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    customer: json["customer"] == null ? null : BookingsCustomer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "customer": customer == null ? null : customer?.toJson(),
  };
}

class BookingsCustomer {
  BookingsCustomer({
    required this.fcmToken,
    required this.firstName,
    required this.phoneNo,
    required this.lastName,
    required this.customer,
  });

  String fcmToken;
  String firstName;
  String phoneNo;
  String lastName;
  List<CustomerElement>? customer;

  factory BookingsCustomer.fromJson(Map<String, dynamic> json) => BookingsCustomer(
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    customer: json["customer"] == null ? null : List<CustomerElement>.from(json["customer"].map((x) => CustomerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fcmToken": fcmToken == null ? null : fcmToken,
    "firstName": firstName == null ? null : firstName,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "lastName": lastName == null ? null : lastName,
    "customer": customer == null ? null : List<dynamic>.from(customer!.map((x) => x.toJson())),
  };
}

class CustomerElement {
  CustomerElement({
    required this.profilePic,
  });

  String profilePic;

  factory CustomerElement.fromJson(Map<String, dynamic> json) => CustomerElement(
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic == null ? null : profilePic,
  };
}

class MechanicService {
  MechanicService({
    required this.id,
    required this.fee,
    required this.service,
    required this.status,
    required this.userId,
  });

  String id;
  String fee;
  Service? service;
  int status;
  int userId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "service": service == null ? null : service?.toJson(),
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.icon,
    required this.minPrice,
    required this.maxPrice,
    required this.categoryId,
    required this.status,
  });

  String id;
  String serviceName;
  dynamic description;
  String icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"],
    icon: json["icon"] == null ? null : json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "description": description,
    "icon": icon == null ? null : icon,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "categoryId": categoryId == null ? null : categoryId,
    "status": status == null ? null : status,
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
