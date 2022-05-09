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
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicMyWalletMdl.fromJson(Map<String, dynamic> json) => MechanicMyWalletMdl(
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
    required this.sum,
    required this.bookingData,
  });

  int jobCount;
  int sum;
  List<BookingDatum>? bookingData;

  factory MyWallet.fromJson(Map<String, dynamic> json) => MyWallet(
    jobCount: json["jobCount"] == null ? null : json["jobCount"],
    sum: json["sum"] == null ? null : json["sum"],
    bookingData: json["bookingData"] == null ? null : List<BookingDatum>.from(json["bookingData"].map((x) => BookingDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "jobCount": jobCount == null ? null : jobCount,
    "sum": sum == null ? null : sum,
    "bookingData": bookingData == null ? null : List<dynamic>.from(bookingData!.map((x) => x.toJson())),
  };
}

class BookingDatum {
  BookingDatum({
    required this.id,
    required this.bookingCode,
    required this.mechanic,
  });

  int id;
  String bookingCode;
  Mechanic? mechanic;

  factory BookingDatum.fromJson(Map<String, dynamic> json) => BookingDatum(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bookingCode": bookingCode == null ? null : bookingCode,
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
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
