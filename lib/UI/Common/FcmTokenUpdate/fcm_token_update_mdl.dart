
import 'dart:convert';

FcmTokenUpdateMdl fcmTokenUpdateMdlFromJson(String str) => FcmTokenUpdateMdl.fromJson(json.decode(str));

String fcmTokenUpdateMdlToJson(FcmTokenUpdateMdl data) => json.encode(data.toJson());

class FcmTokenUpdateMdl {
  FcmTokenUpdateMdl({
    required this.status,
    required this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory FcmTokenUpdateMdl.fromJson(Map<String, dynamic> json) => FcmTokenUpdateMdl(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    required this.fcmTokenUpdate,
  });

  FcmTokenUpdate fcmTokenUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fcmTokenUpdate: FcmTokenUpdate.fromJson(json["fcm_token_update"]),
  );

  Map<String, dynamic> toJson() => {
    "fcm_token_update": fcmTokenUpdate.toJson(),
  };
}

class FcmTokenUpdate {
  FcmTokenUpdate({
    required this.message,
  });

  String message;

  factory FcmTokenUpdate.fromJson(Map<String, dynamic> json) => FcmTokenUpdate(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
