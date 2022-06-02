// To parse this JSON data, do
//
//     final mechanicMyJobReviewMdl = mechanicMyJobReviewMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicMyJobReviewMdl mechanicMyJobReviewMdlFromJson(String str) => MechanicMyJobReviewMdl.fromJson(json.decode(str));

String mechanicMyJobReviewMdlToJson(MechanicMyJobReviewMdl data) => json.encode(data.toJson());

class MechanicMyJobReviewMdl {
  MechanicMyJobReviewMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory MechanicMyJobReviewMdl.fromJson(Map<String, dynamic> json) => MechanicMyJobReviewMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
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

class MechanicReviewsDatum {
  MechanicReviewsDatum({
    required this.id,
    required this.transType,
    required this.rating,
    required this.feedback,
    required this.bookingId,
    required this.orderId,
    required this.status,
    required this.bookings,
  });

  String id;
  int transType;
  double rating;
  String feedback;
  int bookingId;
  int orderId;
  int status;
  Bookings? bookings;

  factory MechanicReviewsDatum.fromJson(Map<String, dynamic> json) => MechanicReviewsDatum(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    feedback: json["feedback"] == null ? null : json["feedback"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    orderId: json["orderId"] == null ? null : json["orderId"],
    status: json["status"] == null ? null : json["status"],
    bookings: json["bookings"] == null ? null : Bookings.fromJson(json["bookings"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "rating": rating == null ? null : rating,
    "feedback": feedback == null ? null : feedback,
    "bookingId": bookingId == null ? null : bookingId,
    "orderId": orderId == null ? null : orderId,
    "status": status == null ? null : status,
    "bookings": bookings == null ? null : bookings!.toJson(),
  };
}

class Bookings {
  Bookings({
    required this.bookService,
    required this.id,
    required this.customer,
  });

  List<BookService>? bookService;
  int id;
  BookingsCustomer? customer;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    bookService: json["bookService"] == null ? null : List<BookService>.from(json["bookService"].map((x) => BookService.fromJson(x))),
    id: json["id"] == null ? null : json["id"],
    customer: json["customer"] == null ? null : BookingsCustomer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "bookService": bookService == null ? null : List<dynamic>.from(bookService!.map((x) => x.toJson())),
    "id": id == null ? null : id,
    "customer": customer == null ? null : customer!.toJson(),
  };
}

class BookService {
  BookService({
    required this.id,
    required this.service,
  });

  String id;
  Service? service;

  factory BookService.fromJson(Map<String, dynamic> json) => BookService(
    id: json["id"] == null ? null : json["id"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "service": service == null ? null : service!.toJson(),
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
  });

  String id;
  String? serviceName;

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
    required this.userCode,
    required this.firstName,
    required this.customer,
  });

  int id;
  String userCode;
  String firstName;
  List<CustomerElement>? customer;

  factory BookingsCustomer.fromJson(Map<String, dynamic> json) => BookingsCustomer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    customer: json["customer"] == null ? null : List<CustomerElement>.from(json["customer"].map((x) => CustomerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
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









// // To parse this JSON data, do
// //
// //     final mechanicMyJobReviewMdl = mechanicMyJobReviewMdlFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// MechanicMyJobReviewMdl mechanicMyJobReviewMdlFromJson(String str) => MechanicMyJobReviewMdl.fromJson(json.decode(str));
//
// String mechanicMyJobReviewMdlToJson(MechanicMyJobReviewMdl data) => json.encode(data.toJson());
//
// class MechanicMyJobReviewMdl {
//   MechanicMyJobReviewMdl({
//     required this.data,
//     required this.message,
//     required this.status,
//   });
//
//   String? message;
//   String status;
//   Data? data;
//
//   factory MechanicMyJobReviewMdl.fromJson(Map<String, dynamic> json) => MechanicMyJobReviewMdl(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     message: json["message"] == null ? null : json["message"],
//     status: json["status"] == null ? null : json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? null : data!.toJson(),
//     "message": message == null ? null : message,
//     "status": status == null ? null : status,
//   };
// }
//
// class Data {
//   Data({
//     required this.mechanicReviewList,
//   });
//
//   MechanicReviewList? mechanicReviewList;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     mechanicReviewList: json["mechanicReviewList"] == null ? null : MechanicReviewList.fromJson(json["mechanicReviewList"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "mechanicReviewList": mechanicReviewList == null ? null : mechanicReviewList!.toJson(),
//   };
// }
//
// class MechanicReviewList {
//   MechanicReviewList({
//     required this.id,
//     required this.userCode,
//     required this.firstName,
//     required this.lastName,
//     required this.emailId,
//     required this.phoneNo,
//     required this.userTypeId,
//     required this.status,
//     required this.jwtToken,
//     required this.fcmToken,
//     required this.otpCode,
//     required this.isProfile,
//     required this.otpVerified,
//     required this.mechanic,
//     required this.mechanicStatus,
//     required this.mechanicService,
//     required this.totalAmount,
//     required this.distance,
//     required this.duration,
//     required this.reviewCount,
//     required this.mechanicReviewsData,
//     required this.mechanicReview,
//     required this.bookingsCount,
//   });
//
//   int id;
//   String userCode;
//   String firstName;
//   String lastName;
//   String emailId;
//   String phoneNo;
//   int userTypeId;
//   int status;
//   String jwtToken;
//   String fcmToken;
//   String otpCode;
//   int isProfile;
//   int otpVerified;
//   Mechanic? mechanic;
//   dynamic mechanicStatus;
//   dynamic mechanicService;
//   dynamic totalAmount;
//   dynamic distance;
//   dynamic duration;
//   dynamic reviewCount;
//   List<MechanicReviewsDatum>? mechanicReviewsData;
//   dynamic mechanicReview;
//   int bookingsCount;
//
//   factory MechanicReviewList.fromJson(Map<String, dynamic> json) => MechanicReviewList(
//     id: json["id"] == null ? null : json["id"],
//     userCode: json["userCode"] == null ? null : json["userCode"],
//     firstName: json["firstName"] == null ? null : json["firstName"],
//     lastName: json["lastName"] == null ? null : json["lastName"],
//     emailId: json["emailId"] == null ? null : json["emailId"],
//     phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
//     userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
//     status: json["status"] == null ? null : json["status"],
//     jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
//     fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
//     otpCode: json["otpCode"] == null ? null : json["otpCode"],
//     isProfile: json["isProfile"] == null ? null : json["isProfile"],
//     otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
//     mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
//     mechanicStatus: json["mechanicStatus"],
//     mechanicService: json["mechanicService"],
//     totalAmount: json["totalAmount"],
//     distance: json["distance"],
//     duration: json["duration"],
//     reviewCount: json["reviewCount"],
//     mechanicReviewsData: json["mechanicReviewsData"] == null ? null : List<MechanicReviewsDatum>.from(json["mechanicReviewsData"].map((x) => MechanicReviewsDatum.fromJson(x))),
//     mechanicReview: json["mechanicReview"],
//     bookingsCount: json["bookingsCount"] == null ? null : json["bookingsCount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "userCode": userCode == null ? null : userCode,
//     "firstName": firstName == null ? null : firstName,
//     "lastName": lastName == null ? null : lastName,
//     "emailId": emailId == null ? null : emailId,
//     "phoneNo": phoneNo == null ? null : phoneNo,
//     "userTypeId": userTypeId == null ? null : userTypeId,
//     "status": status == null ? null : status,
//     "jwtToken": jwtToken == null ? null : jwtToken,
//     "fcmToken": fcmToken == null ? null : fcmToken,
//     "otpCode": otpCode == null ? null : otpCode,
//     "isProfile": isProfile == null ? null : isProfile,
//     "otpVerified": otpVerified == null ? null : otpVerified,
//     "mechanic": mechanic == null ? null : mechanic!.toJson(),
//     "mechanicStatus": mechanicStatus,
//     "mechanicService": mechanicService,
//     "totalAmount": totalAmount,
//     "distance": distance,
//     "duration": duration,
//     "reviewCount": reviewCount,
//     "mechanicReviewsData": mechanicReviewsData == null ? null : List<dynamic>.from(mechanicReviewsData!.map((x) => x.toJson())),
//     "mechanicReview": mechanicReview,
//     "bookingsCount": bookingsCount == null ? null : bookingsCount,
//   };
// }
//
// class Mechanic {
//   Mechanic({
//     required this.id,
//     required this.displayName,
//     required this.userName,
//     required this.password,
//     required this.firstName,
//     required this.lastName,
//     required this.emailId,
//     required this.phoneNo,
//     required this.address,
//     required this.startTime,
//     required this.endTime,
//     required this.city,
//     required this.licenseNo,
//     required this.state,
//     required this.licenseDate,
//     required this.latitude,
//     required this.longitude,
//     required this.serviceId,
//     required this.profilePic,
//     required this.licenseProof,
//     required this.status,
//     required this.rate,
//     required this.reviewCount,
//   });
//
//   String id;
//   dynamic displayName;
//   dynamic userName;
//   dynamic password;
//   dynamic firstName;
//   dynamic lastName;
//   dynamic emailId;
//   dynamic phoneNo;
//   String address;
//   dynamic startTime;
//   dynamic endTime;
//   dynamic city;
//   dynamic licenseNo;
//   String state;
//   dynamic licenseDate;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic serviceId;
//   String profilePic;
//   dynamic licenseProof;
//   int status;
//   double rate;
//   int reviewCount;
//
//   factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
//     id: json["id"] == null ? null : json["id"],
//     displayName: json["displayName"],
//     userName: json["userName"],
//     password: json["password"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     emailId: json["emailId"],
//     phoneNo: json["phoneNo"],
//     address: json["address"] == null ? null : json["address"],
//     startTime: json["startTime"],
//     endTime: json["endTime"],
//     city: json["city"],
//     licenseNo: json["licenseNo"],
//     state: json["state"] == null ? null : json["state"],
//     licenseDate: json["licenseDate"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     serviceId: json["serviceId"],
//     profilePic: json["profilePic"] == null ? null : json["profilePic"],
//     licenseProof: json["licenseProof"],
//     status: json["status"] == null ? null : json["status"],
//     rate: json["rate"] == null ? null : json["rate"].toDouble(),
//     reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "displayName": displayName,
//     "userName": userName,
//     "password": password,
//     "firstName": firstName,
//     "lastName": lastName,
//     "emailId": emailId,
//     "phoneNo": phoneNo,
//     "address": address == null ? null : address,
//     "startTime": startTime,
//     "endTime": endTime,
//     "city": city,
//     "licenseNo": licenseNo,
//     "state": state == null ? null : state,
//     "licenseDate": licenseDate,
//     "latitude": latitude,
//     "longitude": longitude,
//     "serviceId": serviceId,
//     "profilePic": profilePic == null ? null : profilePic,
//     "licenseProof": licenseProof,
//     "status": status == null ? null : status,
//     "rate": rate == null ? null : rate,
//     "reviewCount": reviewCount == null ? null : reviewCount,
//   };
// }
//
// class MechanicReviewsDatum {
//   MechanicReviewsDatum({
//     required this.id,
//     required this.transType,
//     required this.rating,
//     required this.feedback,
//     required this.bookingId,
//     required this.orderId,
//     required this.status,
//     required this.order,
//     required this.bookings,
//     required this.productData,
//   });
//
//   String id;
//   int transType;
//   double rating;
//   String feedback;
//   int bookingId;
//   int orderId;
//   int status;
//   dynamic order;
//   dynamic bookings;
//   dynamic productData;
//
//   factory MechanicReviewsDatum.fromJson(Map<String, dynamic> json) => MechanicReviewsDatum(
//     id: json["id"] == null ? null : json["id"],
//     transType: json["transType"] == null ? null : json["transType"],
//     rating: json["rating"] == null ? null : json["rating"].toDouble(),
//     feedback: json["feedback"] == null ? null : json["feedback"],
//     bookingId: json["bookingId"] == null ? null : json["bookingId"],
//     orderId: json["orderId"] == null ? null : json["orderId"],
//     status: json["status"] == null ? null : json["status"],
//     order: json["order"],
//     bookings: json["bookings"],
//     productData: json["productData"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "transType": transType == null ? null : transType,
//     "rating": rating == null ? null : rating,
//     "feedback": feedback == null ? null : feedback,
//     "bookingId": bookingId == null ? null : bookingId,
//     "orderId": orderId == null ? null : orderId,
//     "status": status == null ? null : status,
//     "order": order,
//     "bookings": bookings,
//     "productData": productData,
//   };
// }
