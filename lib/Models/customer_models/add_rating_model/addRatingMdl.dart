
import 'dart:convert';

AddRatingMdl addRatingMdlFromJson(String str) => AddRatingMdl.fromJson(json.decode(str));

String addRatingMdlToJson(AddRatingMdl data) => json.encode(data.toJson());

class AddRatingMdl {
  AddRatingMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory AddRatingMdl.fromJson(Map<String, dynamic> json) => AddRatingMdl(
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
    required this.addRating,
  });

  AddRating? addRating;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    addRating: json["addRating"] == null ? null : AddRating.fromJson(json["addRating"]),
  );

  Map<String, dynamic> toJson() => {
    "addRating": addRating == null ? null : addRating?.toJson(),
  };
}

class AddRating {
  AddRating({
    required this.message,
  });

  String message;

  factory AddRating.fromJson(Map<String, dynamic> json) => AddRating(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
