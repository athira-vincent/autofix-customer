// To parse this JSON data, do
//
//     final mechanicOnlineOfflineMdl = mechanicOnlineOfflineMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicOnlineOfflineMdl mechanicOnlineOfflineMdlFromJson(String str) => MechanicOnlineOfflineMdl.fromJson(json.decode(str));

String mechanicOnlineOfflineMdlToJson(MechanicOnlineOfflineMdl data) => json.encode(data.toJson());

class MechanicOnlineOfflineMdl {
  MechanicOnlineOfflineMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicOnlineOfflineMdl.fromJson(Map<String, dynamic> json) => MechanicOnlineOfflineMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data?.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    required this.mechanicWorkStatusUpdate,
  });

  MechanicWorkStatusUpdate? mechanicWorkStatusUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicWorkStatusUpdate: json["mechanicWorkStatusUpdate"] == null ? null : MechanicWorkStatusUpdate.fromJson(json["mechanicWorkStatusUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicWorkStatusUpdate": mechanicWorkStatusUpdate == null ? null : mechanicWorkStatusUpdate!.toJson(),
  };
}

class MechanicWorkStatusUpdate {
  MechanicWorkStatusUpdate({
    required this.message,
  });

  String message;

  factory MechanicWorkStatusUpdate.fromJson(Map<String, dynamic> json) => MechanicWorkStatusUpdate(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
