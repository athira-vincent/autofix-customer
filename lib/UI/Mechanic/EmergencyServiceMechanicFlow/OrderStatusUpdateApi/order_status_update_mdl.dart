// To parse this JSON data, do
//
//     final mechanicOrderStatusUpdateMdl = mechanicOrderStatusUpdateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicOrderStatusUpdateMdl mechanicOrderStatusUpdateMdlFromJson(String str) => MechanicOrderStatusUpdateMdl.fromJson(json.decode(str));

String mechanicOrderStatusUpdateMdlToJson(MechanicOrderStatusUpdateMdl data) => json.encode(data.toJson());

class MechanicOrderStatusUpdateMdl {
  MechanicOrderStatusUpdateMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicOrderStatusUpdateMdl.fromJson(Map<String, dynamic> json) => MechanicOrderStatusUpdateMdl(
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
    required this.mechanicStatusUpdate,
  });

  MechanicStatusUpdate? mechanicStatusUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicStatusUpdate: json["mechanic_status_update"] == null ? null : MechanicStatusUpdate.fromJson(json["mechanic_status_update"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_status_update": mechanicStatusUpdate == null ? null : mechanicStatusUpdate!.toJson(),
  };
}

class MechanicStatusUpdate {
  MechanicStatusUpdate({
    required this.msg,
    required this.bookingData,
  });

  Msg? msg;
  BookingData? bookingData;

  factory MechanicStatusUpdate.fromJson(Map<String, dynamic> json) => MechanicStatusUpdate(
    msg: json["msg"] == null ? null : Msg.fromJson(json["msg"]),
    bookingData: json["bookingData"] == null ? null : BookingData.fromJson(json["bookingData"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg == null ? null : msg!.toJson(),
    "bookingData": bookingData == null ? null : bookingData!.toJson(),
  };
}

class BookingData {
  BookingData({
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
    required this.mechanic,
    required this.customer,
    required this.vehicle,
    required this.bookService,
  });

  int id;
  String bookingCode;
  int reqType;
  int bookStatus;
  int totalPrice;
  int tax;
  int commission;
  int serviceCharge;
  dynamic totalTime;
  String serviceTime;
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
  dynamic regularType;
  Mechanic? mechanic;
  Customer? customer;
  dynamic vehicle;
  dynamic bookService;

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"],
    commission: json["commission"] == null ? null : json["commission"],
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
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
    regularType: json["regularType"],
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    vehicle: json["vehicle"],
    bookService: json["bookService"],
  );

  Map<String, dynamic> toJson() => {
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
    "regularType": regularType,
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
    "vehicle": vehicle,
    "bookService": bookService,
  };
}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
  });

  int id;
  String firstName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
  };
}

class Mechanic {
  Mechanic({
    required this.id,
    required this.firstName,
    required this.phoneNo,
    required this.emailId,
  });

  int id;
  String firstName;
  String phoneNo;
  String emailId;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    emailId: json["emailId"] == null ? null : json["emailId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "emailId": emailId == null ? null : emailId,
  };
}

class Msg {
  Msg({
    required this.message,
  });

  String message;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
