// To parse this JSON data, do
//
//     final cityListMdl = cityListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CityListMdl cityListMdlFromJson(String str) => CityListMdl.fromJson(json.decode(str));

String cityListMdlToJson(CityListMdl data) => json.encode(data.toJson());

class CityListMdl {
  CityListMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory CityListMdl.fromJson(Map<String, dynamic> json) => CityListMdl(
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
    required this.citiesList,
  });

  List<CitiesList>? citiesList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    citiesList: json["citiesList"] == null ? null : List<CitiesList>.from(json["citiesList"].map((x) => CitiesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "citiesList": citiesList == null ? null : List<dynamic>.from(citiesList!.map((x) => x.toJson())),
  };
}

class CitiesList {
  CitiesList({
    required this.cityName,
    required this.suburbName,
    required this.postcode,
  });

  String cityName;
  dynamic suburbName;
  String postcode;

  factory CitiesList.fromJson(Map<String, dynamic> json) => CitiesList(
    cityName: json["cityName"] == null ? null : json["cityName"],
    suburbName: json["suburbName"],
    postcode: json["postcode"] == null ? null : json["postcode"],
  );

  Map<String, dynamic> toJson() => {
    "cityName": cityName == null ? null : cityName,
    "suburbName": suburbName,
    "postcode": postcode == null ? null : postcode,
  };
}
