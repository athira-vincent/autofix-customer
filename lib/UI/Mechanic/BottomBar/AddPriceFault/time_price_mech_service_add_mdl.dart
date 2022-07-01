// To parse this JSON data, do
//
//     final timePriceServiceDetailsMdl = timePriceServiceDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TimePriceServiceDetailsMdl timePriceServiceDetailsMdlFromJson(String str) => TimePriceServiceDetailsMdl.fromJson(json.decode(str));

String timePriceServiceDetailsMdlToJson(TimePriceServiceDetailsMdl data) => json.encode(data.toJson());

class TimePriceServiceDetailsMdl {
  TimePriceServiceDetailsMdl({
    required this.data,
  });

  Data? data;

  factory TimePriceServiceDetailsMdl.fromJson(Map<String, dynamic> json) => TimePriceServiceDetailsMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.mechanicServiceAdd,
  });

  MechanicServiceAdd? mechanicServiceAdd;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicServiceAdd: json["mechanic_service_add"] == null ? null : MechanicServiceAdd.fromJson(json["mechanic_service_add"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_service_add": mechanicServiceAdd == null ? null : mechanicServiceAdd!.toJson(),
  };
}

class MechanicServiceAdd {
  MechanicServiceAdd({
    required this.message,
  });

  String message;

  factory MechanicServiceAdd.fromJson(Map<String, dynamic> json) => MechanicServiceAdd(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
