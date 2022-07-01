// To parse this JSON data, do
//
//     final firestoreLocationMdl = firestoreLocationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FirestoreLocationMdl firestoreLocationMdlFromJson(String str) => FirestoreLocationMdl.fromJson(json.decode(str));

String firestoreLocationMdlToJson(FirestoreLocationMdl data) => json.encode(data.toJson());

class FirestoreLocationMdl {
  FirestoreLocationMdl({
    required this.latitude,
    required this.longitude,
  });

  String latitude;
  String longitude;

  factory FirestoreLocationMdl.fromJson(Map<String, dynamic> json) => FirestoreLocationMdl(
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}
