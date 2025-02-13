// To parse this JSON data, do
//
//     final modelDetailsMdl = modelDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelDetailsMdl modelDetailsMdlFromJson(String str) => ModelDetailsMdl.fromJson(json.decode(str));

String modelDetailsMdlToJson(ModelDetailsMdl data) => json.encode(data.toJson());

class ModelDetailsMdl {
  ModelDetailsMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory ModelDetailsMdl.fromJson(Map<String, dynamic> json) => ModelDetailsMdl(
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
    required this.modelDetails,
  });

  List<ModelDetail>? modelDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    modelDetails: json["modelDetails"] == null ? null : List<ModelDetail>.from(json["modelDetails"].map((x) => ModelDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "modelDetails": modelDetails == null ? null : List<dynamic>.from(modelDetails!.map((x) => x.toJson())),
  };
}

class ModelDetail {
  ModelDetail({
    required this.id,
    required this.modelName,
    required this.engineName,
    required this.years,
    required this.brandName,
    required this.status,
  });

  String id;
  String modelName;
  String engineName;
  String years;
  String brandName;
  int status;

  factory ModelDetail.fromJson(Map<String, dynamic> json) => ModelDetail(
    id: json["id"] == null ? null : json["id"],
    modelName: json["modelName"] == null ? null : json["modelName"],
    engineName: json["engineName"] == null ? null : json["engineName"],
    years: json["years"] == null ? null : json["years"],
    brandName: json["brandName"] == null ? null : json["brandName"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "modelName": modelName == null ? null : modelName,
    "engineName": engineName == null ? null : engineName,
    "years": years == null ? null : years,
    "brandName": brandName == null ? null : brandName,
    "status": status == null ? null : status,
  };
}
