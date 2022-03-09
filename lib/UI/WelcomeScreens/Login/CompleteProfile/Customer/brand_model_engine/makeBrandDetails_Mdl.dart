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

  String? message;
  String? status;
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
    required this.makeDetails,
  });

  List<MakeDetail>? makeDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    makeDetails: json["makeDetails"] == null ? null : List<MakeDetail>.from(json["makeDetails"].map((x) => MakeDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "makeDetails": makeDetails == null ? null : List<dynamic>.from(makeDetails!.map((x) => x.toJson())),
  };
}

class MakeDetail {
  MakeDetail({
    required this.id,
    required this.makeName,
    required this.status,
  });

  String id;
  String makeName;
  int status;

  factory MakeDetail.fromJson(Map<String, dynamic> json) => MakeDetail(
    id: json["id"] == null ? null : json["id"],
    makeName: json["makeName"] == null ? null : json["makeName"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "makeName": makeName == null ? null : makeName,
    "status": status == null ? null : status,
  };
}
