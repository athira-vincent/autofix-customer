// To parse this JSON data, do
//
//     final sparePartsModel = sparePartsModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SparePartsModel sparePartsModelFromMap(String str) => SparePartsModel.fromMap(json.decode(str));

String sparePartsModelToMap(SparePartsModel data) => json.encode(data.toMap());

class SparePartsModel {
  SparePartsModel({
    required this.data,
  });

  Data data;

  factory SparePartsModel.fromMap(Map<String, dynamic> json) => SparePartsModel(
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data.toMap(),
  };
}

class Data {
  Data({
    required this.modelDetails,
  });

  List<ModelDetail> modelDetails;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    modelDetails: List<ModelDetail>.from(json["modelDetails"].map((x) => ModelDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "modelDetails": List<dynamic>.from(modelDetails.map((x) => x.toMap())),
  };
}

class ModelDetail {
  ModelDetail({
    required this.id,
    required this.modelName,
    required this.engineName,
    required this.years,
    required this.brandName,
    required this.modelIcon,
    required this.status,
  });

  String id;
  String modelName;
  String engineName;
  String years;
  String brandName;
  String modelIcon;
  int status;

  factory ModelDetail.fromMap(Map<String, dynamic> json) => ModelDetail(
    id: json["id"],
    modelName: json["modelName"],
    engineName: json["engineName"],
    years: json["years"],
    brandName: json["brandName"],
    modelIcon: json["modelIcon"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "modelName": modelName,
    "engineName": engineName,
    "years": years,
    "brandName": brandName,
    "modelIcon": modelIcon,
    "status": status,
  };
}
