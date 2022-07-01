
import 'dart:convert';

CustomerAddMoreServiceMdl mechanicIncomingJobMdlFromJson(String str) => CustomerAddMoreServiceMdl.fromJson(json.decode(str));

String mechanicIncomingJobMdlToJson(CustomerAddMoreServiceMdl data) => json.encode(data.toJson());

class CustomerAddMoreServiceMdl {
  CustomerAddMoreServiceMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory CustomerAddMoreServiceMdl.fromJson(Map<String, dynamic> json) => CustomerAddMoreServiceMdl(
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
  Data();



  factory Data.fromJson(Map<String, dynamic> json) => Data(

  );

  Map<String, dynamic> toJson() => {
  };
}

