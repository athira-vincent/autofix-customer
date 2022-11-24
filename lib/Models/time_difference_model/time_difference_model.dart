// To parse this JSON data, do
//
//     final timeDifferenceModel = timeDifferenceModelFromMap(jsonString);

import 'dart:convert';

TimeDifferenceModel timeDifferenceModelFromMap(String str) =>
    TimeDifferenceModel.fromMap(json.decode(str));

String timeDifferenceModelToMap(TimeDifferenceModel data) =>
    json.encode(data.toMap());

class TimeDifferenceModel {
  TimeDifferenceModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data? data;
  String message;
  String status;

  factory TimeDifferenceModel.fromMap(Map<String, dynamic> json) =>
      TimeDifferenceModel(
        message: json["message"] ?? null,
        status: json["status"] ?? null,
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
        "data": data!.toMap(),
      };
}

class Data {
  Data({
    required this.timeDifference,
  });

  TimeDifference timeDifference;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        timeDifference: TimeDifference.fromMap(json["timeDifference"]),
      );

  Map<String, dynamic> toMap() => {
        "timeDifference": timeDifference.toMap(),
      };
}

class TimeDifference {
  TimeDifference({
    required this.remTime,
  });

  String remTime;

  factory TimeDifference.fromMap(Map<String, dynamic> json) => TimeDifference(
        remTime: json["remTime"],
      );

  Map<String, dynamic> toMap() => {
        "remTime": remTime,
      };
}
