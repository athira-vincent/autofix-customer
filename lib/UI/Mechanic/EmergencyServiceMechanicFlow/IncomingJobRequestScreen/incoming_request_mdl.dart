// To parse this JSON data, do
//
//     final mechanicIncomingJobMdl = mechanicIncomingJobMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicIncomingJobMdl mechanicIncomingJobMdlFromJson(String str) => MechanicIncomingJobMdl.fromJson(json.decode(str));

String mechanicIncomingJobMdlToJson(MechanicIncomingJobMdl data) => json.encode(data.toJson());

class MechanicIncomingJobMdl {
  MechanicIncomingJobMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicIncomingJobMdl.fromJson(Map<String, dynamic> json) => MechanicIncomingJobMdl(
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
    required this.acceptRejectRequest,
  });

  AcceptRejectRequest? acceptRejectRequest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    acceptRejectRequest: json["acceptRejectRequest"] == null ? null : AcceptRejectRequest.fromJson(json["acceptRejectRequest"]),
  );

  Map<String, dynamic> toJson() => {
    "acceptRejectRequest": acceptRejectRequest == null ? null : acceptRejectRequest!.toJson(),
  };
}

class AcceptRejectRequest {
  AcceptRejectRequest({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory AcceptRejectRequest.fromJson(Map<String, dynamic> json) => AcceptRejectRequest(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
