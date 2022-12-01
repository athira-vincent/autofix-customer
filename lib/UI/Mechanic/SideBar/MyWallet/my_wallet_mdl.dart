// To parse this JSON data, do
//
//     final mechanicMyWalletMdl = mechanicMyWalletMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicMyWalletMdl mechanicMyWalletMdlFromJson(String str) => MechanicMyWalletMdl.fromJson(json.decode(str));

String mechanicMyWalletMdlToJson(MechanicMyWalletMdl data) => json.encode(data.toJson());

class MechanicMyWalletMdl {
  MechanicMyWalletMdl({
    required this.data,
    required this.status,
    required this.message,
  });

  Data? data;
  String status;
  String message;

  factory MechanicMyWalletMdl.fromJson(Map<String, dynamic> json) => MechanicMyWalletMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"] ?? null,
    message: json["message"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  Data({
    required this.myWallet,
  });

  MyWallet? myWallet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    myWallet: json["myWallet"] == null ? null : MyWallet.fromJson(json["myWallet"]),
  );

  Map<String, dynamic> toJson() => {
    "myWallet": myWallet == null ? null : myWallet!.toJson(),
  };
}

class MyWallet {
  MyWallet({
    required this.balance,
    required this.totalAmount,
    required this.todaysPayments,
  });

  dynamic balance;
  dynamic totalAmount;
  List<TodaysPayment>? todaysPayments;

  factory MyWallet.fromJson(Map<String, dynamic> json) => MyWallet(
    balance: json["balance"] == null ? null : json["balance"],
    totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
    todaysPayments: json["todaysPayments"] == null ? null : List<TodaysPayment>.from(json["todaysPayments"].map((x) => TodaysPayment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance == null ? null : balance,
    "totalAmount": totalAmount == null ? null : totalAmount,
    "todaysPayments": todaysPayments == null ? null : List<dynamic>.from(todaysPayments!.map((x) => x.toJson())),
  };
}

class TodaysPayment {
  TodaysPayment({
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
    required this.extend,
    required this.totalExt,
    required this.extendTime,
    required this.bookedDate,
    required this.bookedTime,
    required this.isRated,
    required this.status,
    required this.regularType,
    required this.mechLatitude,
    required this.mechLongitude,
    required this.demoMechanicId,
    required this.customerId,
    required this.vehicleId,
    required this.serviceId,
    required this.mechanic,
    required this.customer,
  });

  int id;
  String bookingCode;
  int reqType;
  int bookStatus;
  String totalPrice;
  double tax;
  double commission;
  double serviceCharge;
  dynamic totalTime;
  String serviceTime;
  double latitude;
  double longitude;
  dynamic extend;
  dynamic totalExt;
  dynamic extendTime;
  DateTime? bookedDate;
  String bookedTime;
  int isRated;
  int status;
  int regularType;
  double mechLatitude;
  double mechLongitude;
  dynamic demoMechanicId;
  int customerId;
  int vehicleId;
  dynamic serviceId;
  Mechanic? mechanic;
  TodaysPaymentCustomer? customer;

  factory TodaysPayment.fromJson(Map<String, dynamic> json) => TodaysPayment(
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
    extend: json["extend"],
    totalExt: json["totalExt"],
    extendTime: json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    regularType: json["regularType"] == null ? null : json["regularType"],
    mechLatitude: json["mechLatitude"] == null ? null : json["mechLatitude"].toDouble(),
    mechLongitude: json["mechLongitude"] == null ? null : json["mechLongitude"].toDouble(),
    demoMechanicId: json["demoMechanicId"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    serviceId: json["serviceId"],
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : TodaysPaymentCustomer.fromJson(json["customer"]),
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
    "extend": extend,
    "totalExt": totalExt,
    "extendTime": extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate!.toIso8601String(),
    "bookedTime": bookedTime == null ? null : bookedTime,
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "regularType": regularType == null ? null : regularType,
    "mechLatitude": mechLatitude == null ? null : mechLatitude,
    "mechLongitude": mechLongitude == null ? null : mechLongitude,
    "demoMechanicId": demoMechanicId,
    "customerId": customerId == null ? null : customerId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "serviceId": serviceId,
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
  };
}

class TodaysPaymentCustomer {
  TodaysPaymentCustomer({
    required this.id,
    required this.firstName,
    required this.customer,
  });

  int id;
  String firstName;
  List<CustomerElement>? customer;

  factory TodaysPaymentCustomer.fromJson(Map<String, dynamic> json) => TodaysPaymentCustomer(
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

class Mechanic {
  Mechanic({
    required this.id,
    required this.firstName,
    required this.mechanic,
  });

  int id;
  String firstName;
  List<CustomerElement>? mechanic;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    mechanic: json["mechanic"] == null ? null : List<CustomerElement>.from(json["mechanic"].map((x) => CustomerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x.toJson())),
  };
}
