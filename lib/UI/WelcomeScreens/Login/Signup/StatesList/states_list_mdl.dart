// To parse this JSON data, do
//
//     final statesListMdl = statesListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StatesListMdl statesListMdlFromJson(String str) => StatesListMdl.fromJson(json.decode(str));

String statesListMdlToJson(StatesListMdl data) => json.encode(data.toJson());

class StatesListMdl {
  StatesListMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory StatesListMdl.fromJson(Map<String, dynamic> json) => StatesListMdl(
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
    required this.statesList,
  });

  List<StatesList>? statesList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    statesList: json["statesList"] == null ? null : List<StatesList>.from(json["statesList"].map((x) => StatesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statesList": statesList == null ? null : List<dynamic>.from(statesList!.map((x) => x.toJson())),
  };
}

class StatesList {
  StatesList({
    required this.slug,
    required this.pk,
    required this.countryCode,
    required this.name,
    required this.code,
  });

  String slug;
  String pk;
  String countryCode;
  String name;
  String code;

  factory StatesList.fromJson(Map<String, dynamic> json) => StatesList(
    slug: json["slug"] == null ? null : json["slug"],
    pk: json["pk"] == null ? null : json["pk"],
    countryCode: json["countryCode"] == null ? null : json["countryCode"],
    name: json["name"] == null ? null : json["name"],
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug == null ? null : slug,
    "pk": pk == null ? null : pk,
    "countryCode": countryCode == null ? null : countryCode,
    "name": name == null ? null : name,
    "code": code == null ? null : code,
  };
}

