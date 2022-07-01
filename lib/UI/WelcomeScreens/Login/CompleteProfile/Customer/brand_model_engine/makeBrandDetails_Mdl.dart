// To parse this JSON data, do
//
//     final makeBrandDetailsMdl = makeBrandDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MakeBrandDetailsMdl makeBrandDetailsMdlFromJson(String str) => MakeBrandDetailsMdl.fromJson(json.decode(str));

String makeBrandDetailsMdlToJson(MakeBrandDetailsMdl data) => json.encode(data.toJson());

class MakeBrandDetailsMdl {
  MakeBrandDetailsMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MakeBrandDetailsMdl.fromJson(Map<String, dynamic> json) => MakeBrandDetailsMdl(
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
    required this.brandDetails,
  });

  List<BrandDetail>? brandDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brandDetails: json["brandDetails"] == null ? null : List<BrandDetail>.from(json["brandDetails"].map((x) => BrandDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brandDetails": brandDetails == null ? null : List<dynamic>.from(brandDetails!.map((x) => x.toJson())),
  };
}

class BrandDetail {
  BrandDetail({
    required this.id,
    required this.brandName,
    required this.status,
    required this.brandicon,
  });

  String id;
  String brandName;
  int status;
  dynamic brandicon;

  factory BrandDetail.fromJson(Map<String, dynamic> json) => BrandDetail(
    id: json["id"] == null ? null : json["id"],
    brandName: json["brandName"] == null ? null : json["brandName"],
    status: json["status"] == null ? null : json["status"],
    brandicon: json["brandicon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brandName": brandName == null ? null : brandName,
    "status": status == null ? null : status,
    "brandicon": brandicon,
  };
}
