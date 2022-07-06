// To parse this JSON data, do
//
//     final mechanicMyJobReviewMdl = mechanicMyJobReviewMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicMyJobReviewMdl mechanicMyJobReviewMdlFromJson(String str) => MechanicMyJobReviewMdl.fromJson(json.decode(str));

String mechanicMyJobReviewMdlToJson(MechanicMyJobReviewMdl data) => json.encode(data.toJson());

class MechanicMyJobReviewMdl {
  MechanicMyJobReviewMdl({
    required this.data,
    String? status, message,
  });

  Data? data;

  factory MechanicMyJobReviewMdl.fromJson(Map<String, dynamic> json) => MechanicMyJobReviewMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.mechanicReviewList,
  });

  MechanicReviewList? mechanicReviewList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicReviewList: json["mechanicReviewList"] == null ? null : MechanicReviewList.fromJson(json["mechanicReviewList"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicReviewList": mechanicReviewList == null ? null : mechanicReviewList!.toJson(),
  };
}

class MechanicReviewList {
  MechanicReviewList({
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
    required this.bookingsCount,
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
  dynamic mechanicStatus;
  dynamic mechanicService;
  dynamic totalAmount;
  dynamic distance;
  dynamic duration;
  dynamic reviewCount;
  List<MechanicReviewsDatum>? mechanicReviewsData;
  dynamic mechanicReview;
  int bookingsCount;

  factory MechanicReviewList.fromJson(Map<String, dynamic> json) => MechanicReviewList(
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
    mechanicStatus: json["mechanicStatus"],
    mechanicService: json["mechanicService"],
    totalAmount: json["totalAmount"],
    distance: json["distance"],
    duration: json["duration"],
    reviewCount: json["reviewCount"],
    mechanicReviewsData: json["mechanicReviewsData"] == null ? null : List<MechanicReviewsDatum>.from(json["mechanicReviewsData"].map((x) => MechanicReviewsDatum.fromJson(x))),
    mechanicReview: json["mechanicReview"],
    bookingsCount: json["bookingsCount"] == null ? null : json["bookingsCount"],
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
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
    "mechanicStatus": mechanicStatus,
    "mechanicService": mechanicService,
    "totalAmount": totalAmount,
    "distance": distance,
    "duration": duration,
    "reviewCount": reviewCount,
    "mechanicReviewsData": mechanicReviewsData == null ? null : List<dynamic>.from(mechanicReviewsData!.map((x) => x.toJson())),
    "mechanicReview": mechanicReview,
    "bookingsCount": bookingsCount == null ? null : bookingsCount,
  };
}

class Mechanic {
  Mechanic({
    required this.id,
    required this.usersId,
    required this.yearExp,
    required this.profilePic,
    required this.mechType,
    required this.workType,
    required this.noMech,
    required this.state,
    required this.rcNumber,
    required this.brands,
    required this.address,
    required this.certificate1,
    required this.certificate2,
    required this.status,
    required this.rate,
    required this.reviewCount,
  });

  String id;
  dynamic usersId;
  int yearExp;
  String profilePic;
  String mechType;
  String workType;
  dynamic noMech;
  String state;
  String rcNumber;
  String brands;
  String address;
  dynamic certificate1;
  dynamic certificate2;
  int status;
  double rate;
  int reviewCount;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    usersId: json["usersId"],
    yearExp: json["yearExp"] == null ? null : json["yearExp"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    mechType: json["mechType"] == null ? null : json["mechType"],
    workType: json["workType"] == null ? null : json["workType"],
    noMech: json["noMech"],
    state: json["state"] == null ? null : json["state"],
    rcNumber: json["rcNumber"] == null ? null : json["rcNumber"],
    brands: json["brands"] == null ? null : json["brands"],
    address: json["address"] == null ? null : json["address"],
    certificate1: json["certificate1"],
    certificate2: json["certificate2"],
    status: json["status"] == null ? null : json["status"],
    rate: json["rate"] == null ? null : json["rate"].toDouble(),
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "usersId": usersId,
    "yearExp": yearExp == null ? null : yearExp,
    "profilePic": profilePic == null ? null : profilePic,
    "mechType": mechType == null ? null : mechType,
    "workType": workType == null ? null : workType,
    "noMech": noMech,
    "state": state == null ? null : state,
    "rcNumber": rcNumber == null ? null : rcNumber,
    "brands": brands == null ? null : brands,
    "address": address == null ? null : address,
    "certificate1": certificate1,
    "certificate2": certificate2,
    "status": status == null ? null : status,
    "rate": rate == null ? null : rate,
    "reviewCount": reviewCount == null ? null : reviewCount,
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
    required this.order,
    required this.bookings,
    required this.productData,
  });

  String id;
  int transType;
  double rating;
  String feedback;
  int bookingId;
  int orderId;
  int status;
  dynamic order;
  Bookings? bookings;
  dynamic productData;

  factory MechanicReviewsDatum.fromJson(Map<String, dynamic> json) => MechanicReviewsDatum(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    feedback: json["feedback"] == null ? null : json["feedback"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    orderId: json["orderId"] == null ? null : json["orderId"],
    status: json["status"] == null ? null : json["status"],
    order: json["order"],
    bookings: json["bookings"] == null ? null : Bookings.fromJson(json["bookings"]),
    productData: json["productData"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "rating": rating == null ? null : rating,
    "feedback": feedback == null ? null : feedback,
    "bookingId": bookingId == null ? null : bookingId,
    "orderId": orderId == null ? null : orderId,
    "status": status == null ? null : status,
    "order": order,
    "bookings": bookings == null ? null : bookings!.toJson(),
    "productData": productData,
  };
}

class Bookings {
  Bookings({
    required this.id,
    required this.customer,
    required this.bookService,
  });

  int id;
  BookingsCustomer? customer;
  List<BookService>? bookService;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    id: json["id"] == null ? null : json["id"],
    customer: json["customer"] == null ? null : BookingsCustomer.fromJson(json["customer"]),
    bookService: json["bookService"] == null ? null : List<BookService>.from(json["bookService"].map((x) => BookService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "customer": customer == null ? null : customer!.toJson(),
    "bookService": bookService == null ? null : List<dynamic>.from(bookService!.map((x) => x.toJson())),
  };
}

class BookService {
  BookService({
    required this.service,
  });

  Service? service;

  factory BookService.fromJson(Map<String, dynamic> json) => BookService(
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "service": service == null ? null : service!.toJson(),
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
  });

  String id;
  String serviceName;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
  };
}


class BookingsCustomer {
  BookingsCustomer({
    required this.id,
    required this.firstName,
    required this.customer,
  });

  int id;
  String firstName;
  List<CustomerElement>? customer;

  factory BookingsCustomer.fromJson(Map<String, dynamic> json) => BookingsCustomer(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    customer: json["customer"] == null ? null : List<CustomerElement>.from(json["customer"].map((x) => CustomerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
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




