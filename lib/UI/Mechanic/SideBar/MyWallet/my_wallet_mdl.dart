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
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "status": status == null ? null : status,
    "message": message == null ? null : message,
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
    required this.jobCount,
    required this.monthlySum,
    required this.totalPayment,
    required this.bookingData,
    required this.payArr,
  });

  int jobCount;
  int monthlySum;
  double totalPayment;
  List<BookingDatum>? bookingData;
  List<PayArr>? payArr;

  factory MyWallet.fromJson(Map<String, dynamic> json) => MyWallet(
    jobCount: json["jobCount"] == null ? null : json["jobCount"],
    monthlySum: json["monthlySum"] == null ? null : json["monthlySum"],
    totalPayment: json["totalPayment"] == null ? null : json["totalPayment"].toDouble(),
    bookingData: json["bookingData"] == null ? null : List<BookingDatum>.from(json["bookingData"].map((x) => BookingDatum.fromJson(x))),
    payArr: json["payArr"] == null ? null : List<PayArr>.from(json["payArr"].map((x) => PayArr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "jobCount": jobCount == null ? null : jobCount,
    "monthlySum": monthlySum == null ? null : monthlySum,
    "totalPayment": totalPayment == null ? null : totalPayment,
    "bookingData": bookingData == null ? null : List<dynamic>.from(bookingData!.map((x) => x.toJson())),
    "payArr": payArr == null ? null : List<dynamic>.from(payArr!.map((x) => x.toJson())),
  };
}

class BookingDatum {
  BookingDatum({
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
  int serviceCharge;
  dynamic totalTime;
  dynamic serviceTime;
  double latitude;
  double longitude;
  double extend;
  double totalExt;
  String extendTime;
  DateTime? bookedDate;
  String bookedTime;
  int isRated;
  int status;
  dynamic regularType;
  dynamic mechLatitude;
  dynamic mechLongitude;
  dynamic demoMechanicId;
  int customerId;
  int vehicleId;
  dynamic serviceId;
  Mechanic? mechanic;
  Customer? customer;

  factory BookingDatum.fromJson(Map<String, dynamic> json) => BookingDatum(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    commission: json["commission"] == null ? null : json["commission"].toDouble(),
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    extend: json["extend"] == null ? null : json["extend"].toDouble(),
    totalExt: json["totalExt"] == null ? null : json["totalExt"].toDouble(),
    extendTime: json["extendTime"] == null ? null : json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    regularType: json["regularType"],
    mechLatitude: json["mechLatitude"],
    mechLongitude: json["mechLongitude"],
    demoMechanicId: json["demoMechanicId"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    serviceId: json["serviceId"],
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
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
    "serviceTime": serviceTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "extend": extend == null ? null : extend,
    "totalExt": totalExt == null ? null : totalExt,
    "extendTime": extendTime == null ? null : extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate!.toIso8601String(),
    "bookedTime": bookedTime == null ? null : bookedTime,
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "regularType": regularType,
    "mechLatitude": mechLatitude,
    "mechLongitude": mechLongitude,
    "demoMechanicId": demoMechanicId,
    "customerId": customerId == null ? null : customerId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "serviceId": serviceId,
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
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
  });

  int id;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}

class PayArr {
  PayArr({
    required this.id,
    required this.transType,
    required this.amount,
    required this.paymentType,
    required this.transId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingId,
    required this.orderId,
  });

  int id;
  int transType;
  int amount;
  int paymentType;
  String transId;
  int status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int bookingId;
  dynamic orderId;

  factory PayArr.fromJson(Map<String, dynamic> json) => PayArr(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    amount: json["amount"] == null ? null : json["amount"],
    paymentType: json["paymentType"] == null ? null : json["paymentType"],
    transId: json["transId"] == null ? null : json["transId"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    orderId: json["orderId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "amount": amount == null ? null : amount,
    "paymentType": paymentType == null ? null : paymentType,
    "transId": transId == null ? null : transId,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "bookingId": bookingId == null ? null : bookingId,
    "orderId": orderId,
  };
}
