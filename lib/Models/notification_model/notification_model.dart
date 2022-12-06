// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationModel notificationModelFromMap(String str) => NotificationModel.fromMap(json.decode(str));

String notificationModelToMap(NotificationModel data) => json.encode(data.toMap());

class NotificationModel {
  NotificationModel({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory NotificationModel.fromMap(Map<String, dynamic> json) => NotificationModel(
    message: json["message"] ?? null,
    status: json["status"] ?? null,
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "status": status,
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    required this.notificationList,
  });

  NotificationList? notificationList;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    notificationList: json["notificationList"] == null ? null : NotificationList.fromMap(json["notificationList"]),
  );

  Map<String, dynamic> toMap() => {
    "notificationList": notificationList == null ? null : notificationList!.toMap(),
  };
}

class NotificationList {
  NotificationList({
    required this.newData,
    required this.previousData,
  });

  dynamic newData;
  List<PreviousDatum>? previousData;

  factory NotificationList.fromMap(Map<String, dynamic> json) => NotificationList(
    newData: json["newData"],
    previousData: json["previousData"] == null ? null : List<PreviousDatum>.from(json["previousData"].map((x) => PreviousDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "newData": newData,
    "previousData": previousData == null ? null : List<dynamic>.from(previousData!.map((x) => x.toMap())),
  };
}

class PreviousDatum {
  PreviousDatum({
    required this.id,
    required this.caption,
    required this.message,
    required this.read,
    required this.trash,
    required this.isViewed,
    required this.status,
    required this.toId,
    required this.bookingId,
    required this.to,
    required this.from,
    required this.booking,
    required this.order,
  });

  String id;
  String caption;
  String? message;
  int read;
  int trash;
  int isViewed;
  int status;
  int toId;
  int bookingId;
  To? to;
  From? from;
  Booking? booking;
  dynamic order;

  factory PreviousDatum.fromMap(Map<String, dynamic> json) => PreviousDatum(
    id: json["id"] == null ? null : json["id"],
    caption: json["caption"] == null ? null : json["caption"],
    message: json["message"] == null ? null : json["message"],
    read: json["read"] == null ? null : json["read"],
    trash: json["trash"] == null ? null : json["trash"],
    isViewed: json["isViewed"] == null ? null : json["isViewed"],
    status: json["status"] == null ? null : json["status"],
    toId: json["toId"] == null ? null : json["toId"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    to: json["to"] == null ? null : To.fromMap(json["to"]),
    from: json["from"] == null ? null : From.fromMap(json["from"]),
    booking: json["booking"] == null ? null : Booking.fromMap(json["booking"]),
    order: json["order"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "caption": caption == null ? null : caption,
    "message": message == null ? null : message,
    "read": read == null ? null : read,
    "trash": trash == null ? null : trash,
    "isViewed": isViewed == null ? null : isViewed,
    "status": status == null ? null : status,
    "toId": toId == null ? null : toId,
    "bookingId": bookingId == null ? null : bookingId,
    "to": to == null ? null : to!.toMap(),
    "from": from == null ? null : from!.toMap(),
    "booking": booking == null ? null : booking!.toMap(),
    "order": order,
  };
}

class Booking {
  Booking({
    required this.id,
    required this.bookingCode,
    required this.reqType,
    required this.bookStatus,
    required this.totalPrice,
    required this.tax,
    required this.commission,
    required this.serviceCharge,
    required this.totalTime,
    required this.serviceTime,
    required this.latitude,
    required this.longitude,
    required this.mechLatitude,
    required this.mechLongitude,
    required this.extend,
    required this.totalExt,
    required this.extendTime,
    required this.bookedDate,
    required this.bookedTime,
    required this.isRated,
    required this.status,
    required this.customerId,
    required this.mechanicId,
    required this.vehicleId,
    required this.regularType,
  });

  int id;
  String bookingCode;
  int reqType;
  int bookStatus;
  int totalPrice;
  double tax;
  double commission;
  double serviceCharge;
  dynamic totalTime;
  dynamic serviceTime;
  double latitude;
  double longitude;
  double mechLatitude;
  double mechLongitude;
  dynamic extend;
  dynamic totalExt;
  dynamic extendTime;
  DateTime? bookedDate;
  String bookedTime;
  int isRated;
  int status;
  int customerId;
  int mechanicId;
  int vehicleId;
  int regularType;

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    commission: json["commission"] == null ? null : json["commission"].toDouble(),
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"].toDouble(),
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"] == null ? null : json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    mechLatitude: json["mechLatitude"] == null ? null : json["mechLatitude"].toDouble(),
    mechLongitude: json["mechLongitude"] == null ? null : json["mechLongitude"].toDouble(),
    extend: json["extend"],
    totalExt: json["totalExt"],
    extendTime: json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"] == null ? null : json["mechanicId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    regularType: json["regularType"] == null ? null : json["regularType"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "bookingCode": bookingCode == null ? null : bookingCode,
    "reqType": reqType == null ? null : reqType,
    "bookStatus": bookStatus == null ? null : bookStatus,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "tax": tax == null ? null : tax,
    "commission": commission == null ? null : commission,
    "serviceCharge": serviceCharge == null ? null : serviceCharge,
    "totalTime": totalTime,
    "serviceTime": serviceTime == null ? null : serviceTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "mechLatitude": mechLatitude == null ? null : mechLatitude,
    "mechLongitude": mechLongitude == null ? null : mechLongitude,
    "extend": extend,
    "totalExt": totalExt,
    "extendTime": extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate!.toIso8601String(),
    "bookedTime": bookedTime == null ? null : bookedTime,
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId == null ? null : mechanicId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "regularType": regularType == null ? null : regularType,
  };
}


class From {
  From({
    required this.firstName,
    required this.fcmToken,
    required this.customer,
    required this.mechanic,
  });

  String firstName;
  String fcmToken;
  List<Customer>? customer;
  List<dynamic>? mechanic;

  factory From.fromMap(Map<String, dynamic> json) => From(
    firstName: json["firstName"] == null ? null : json["firstName"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    customer: json["customer"] == null ? null : List<Customer>.from(json["customer"].map((x) => Customer.fromMap(x))),
    mechanic: json["mechanic"] == null ? null : List<dynamic>.from(json["mechanic"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "firstName": firstName == null ? null : firstName,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "customer": customer == null ? null : List<dynamic>.from(customer!.map((x) => x.toMap())),
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x)),
  };
}

class Customer {
  Customer({
    required this.profilePic,
  });

  String profilePic;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
  );

  Map<String, dynamic> toMap() => {
    "profilePic": profilePic == null ? null : profilePic,
  };
}


class To {
  To({
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
  dynamic otpCode;
  int isProfile;
  int otpVerified;
  List<dynamic>? customer;
  List<Customer>? mechanic;

  factory To.fromMap(Map<String, dynamic> json) => To(
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
    otpCode: json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
    customer: json["customer"] == null ? null : List<dynamic>.from(json["customer"].map((x) => x)),
    mechanic: json["mechanic"] == null ? null : List<Customer>.from(json["mechanic"].map((x) => Customer.fromMap(x))),
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
    "otpCode": otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
    "customer": customer == null ? null : List<dynamic>.from(customer!.map((x) => x)),
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x.toMap())),
  };
}
