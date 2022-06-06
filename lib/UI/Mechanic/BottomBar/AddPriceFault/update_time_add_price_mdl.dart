import 'package:meta/meta.dart';
import 'dart:convert';

UpdateAddPriceFaultMdl updateAddPriceFaultMdlFromJson(String str) => UpdateAddPriceFaultMdl.fromJson(json.decode(str));

String updateAddPriceFaultMdlToJson(UpdateAddPriceFaultMdl data) => json.encode(data.toJson());

class UpdateAddPriceFaultMdl {
  UpdateAddPriceFaultMdl({
    required this.data,
  });

  Data? data;

  factory UpdateAddPriceFaultMdl.fromJson(Map<String, dynamic> json) => UpdateAddPriceFaultMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.updateTimeFees,
  });

  UpdateTimeFees? updateTimeFees;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    updateTimeFees: json["updateTimeFees"] == null ? null : UpdateTimeFees.fromJson(json["updateTimeFees"]),
  );

  Map<String, dynamic> toJson() => {
    "updateTimeFees": updateTimeFees == null ? null : updateTimeFees!.toJson(),
  };
}

class UpdateTimeFees {
  UpdateTimeFees({
    required this.message,
  });

  String message;

  factory UpdateTimeFees.fromJson(Map<String, dynamic> json) => UpdateTimeFees(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}
