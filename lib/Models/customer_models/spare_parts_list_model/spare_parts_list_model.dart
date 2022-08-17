// To parse this JSON data, do
//
//     final sparePartsListModel = sparePartsListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SparePartsListModel sparePartsListModelFromMap(String str) =>
    SparePartsListModel.fromMap(json.decode(str));

String sparePartsListModelToMap(SparePartsListModel data) =>
    json.encode(data.toMap());

class SparePartsListModel {
  SparePartsListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory SparePartsListModel.fromMap(Map<String, dynamic> json) =>
      SparePartsListModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data!.toMap(),
      };
}

class Data {
  Data({
    required this.sparePartsList,
  });

  List<SparePartsList> sparePartsList;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        sparePartsList: List<SparePartsList>.from(
            json["spare_parts_list"].map((x) => SparePartsList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "spare_parts_list":
            List<dynamic>.from(sparePartsList.map((x) => x.toMap())),
      };
}

class SparePartsList {
  SparePartsList({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.price,
    required this.shippingCharge,
    required this.productImage,
    required this.description,
    required this.status,
    required this.vehicleModelId,
    required this.vehicleModel,
  });

  int id;
  String productCode;
  String productName;
  String price;
  String shippingCharge;
  String productImage;
  String description;
  int status;
  int vehicleModelId;

  VehicleModel vehicleModel;

  factory SparePartsList.fromMap(Map<String, dynamic> json) => SparePartsList(
        id: json["id"],
        productCode: json["productCode"],
        productName: json["productName"],
        price: json["price"],
        shippingCharge: json["shippingCharge"],
        productImage: json["productImage"]??"",
        description: json["description"],
        status: json["status"],
        vehicleModelId: json["vehicleModelId"],
        vehicleModel: VehicleModel.fromMap(json["vehicleModel"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productCode": productCode,
        "productName": productName,
        "price": price,
        "shippingCharge": shippingCharge,
        "productImage": productImage,
        "description": description,
        "status": status,
        "vehicleModelId": vehicleModelId,
        "vehicleModel": vehicleModel.toMap(),
      };
}

class VehicleModel {
  VehicleModel({
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

  factory VehicleModel.fromMap(Map<String, dynamic> json) => VehicleModel(
        id: json["id"],
        modelName: json["modelName"],
        engineName: json["engineName"],
        years: json["years"],
        brandName: json["brandName"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "modelName": modelName,
        "engineName": engineName,
        "years": years,
        "brandName": brandName,
        "status": status,
      };
}
