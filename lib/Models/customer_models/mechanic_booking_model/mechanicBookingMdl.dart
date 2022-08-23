
import 'dart:convert';

MechanicBookingMdl mechanicBookingMdlFromJson(String str) => MechanicBookingMdl.fromJson(json.decode(str));

String mechanicBookingMdlToJson(MechanicBookingMdl data) => json.encode(data.toJson());

class MechanicBookingMdl {
  MechanicBookingMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicBookingMdl.fromJson(Map<String, dynamic> json) => MechanicBookingMdl(
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
    required this.mechanicBooking,
  });

  MechanicBooking? mechanicBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicBooking: json["mechanicBooking"] == null ? null : MechanicBooking.fromJson(json["mechanicBooking"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicBooking": mechanicBooking == null ? null : mechanicBooking!.toJson(),
  };
}

class MechanicBooking {
  MechanicBooking({
    required this.id,
    required this.bookingCode,
    required this.reqType,
    required this.bookStatus,
    required this.totalPrice,
    required this.tax,
    required this.commission,
    required this.serviceCharge,
    required this.totalTime,
    required this.serviceTime,
    required this.latitude,
    required this.longitude,
    required this.mechLatitude,
    required this.mechLongitude,
    required this.extend,
    required this.totalExt,
    required this.extendTime,
    required this.bookedDate,
    required this.bookedTime,
    required this.isRated,
    required this.status,
    required this.customerId,
    required this.mechanicId,
    required this.vehicleId,
    required this.regularType,
    required this.mechanic,
    required this.customer,
    required this.vehicle,
    required this.bookService,
  });

  int id;
  String bookingCode;
  int reqType;
  int bookStatus;
  var totalPrice;
  double tax;
  var commission;
  double serviceCharge;
  dynamic totalTime;
  String serviceTime;
  double latitude;
  double longitude;
  double mechLatitude;
  double mechLongitude;
  dynamic extend;
  dynamic totalExt;
  dynamic extendTime;
  DateTime? bookedDate;
  String bookedTime;
  int isRated;
  int status;
  int customerId;
  int mechanicId;
  int vehicleId;
  int regularType;
  dynamic mechanic;
  dynamic customer;
  Vehicle? vehicle;
  dynamic bookService;

  factory MechanicBooking.fromJson(Map<String, dynamic> json) => MechanicBooking(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    commission: json["commission"] == null ? null : json["commission"],
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"].toDouble(),
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"] == null ? null : json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    mechLatitude: json["mechLatitude"] == null ? null : json["mechLatitude"].toDouble(),
    mechLongitude: json["mechLongitude"] == null ? null : json["mechLongitude"].toDouble(),
    extend: json["extend"],
    totalExt: json["totalExt"],
    extendTime: json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"] == null ? null : json["mechanicId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    regularType: json["regularType"] == null ? null : json["regularType"],
    mechanic: json["mechanic"],
    customer: json["customer"],
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    bookService: json["bookService"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bookingCode": bookingCode == null ? null : bookingCode,
    "reqType": reqType == null ? null : reqType,
    "bookStatus": bookStatus == null ? null : bookStatus,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "tax": tax == null ? null : tax,
    "commission": commission == null ? null : commission,
    "serviceCharge": serviceCharge == null ? null : serviceCharge,
    "totalTime": totalTime,
    "serviceTime": serviceTime == null ? null : serviceTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "mechLatitude": mechLatitude == null ? null : mechLatitude,
    "mechLongitude": mechLongitude == null ? null : mechLongitude,
    "extend": extend,
    "totalExt": totalExt,
    "extendTime": extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate!.toIso8601String(),
    "bookedTime": bookedTime == null ? null : bookedTime,
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId == null ? null : mechanicId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "regularType": regularType == null ? null : regularType,
    "mechanic": mechanic,
    "customer": customer,
    "vehicle": vehicle == null ? null : vehicle!.toJson(),
    "bookService": bookService,
  };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.engine,
    required this.year,
    required this.plateNo,
    required this.lastMaintenance,
    required this.milege,
    required this.vehiclePic,
    required this.color,
    required this.latitude,
    required this.longitude,
    required this.defaultVehicle,
    required this.status,
    required this.userId,
  });

  String id;
  String brand;
  String model;
  String engine;
  String year;
  String plateNo;
  String lastMaintenance;
  String milege;
  String vehiclePic;
  dynamic color;
  double latitude;
  double longitude;
  int defaultVehicle;
  int status;
  int userId;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"] == null ? null : json["id"],
    brand: json["brand"] == null ? null : json["brand"],
    model: json["model"] == null ? null : json["model"],
    engine: json["engine"] == null ? null : json["engine"],
    year: json["year"] == null ? null : json["year"],
    plateNo: json["plateNo"] == null ? null : json["plateNo"],
    lastMaintenance: json["lastMaintenance"] == null ? null : json["lastMaintenance"],
    milege: json["milege"] == null ? null : json["milege"],
    vehiclePic: json["vehiclePic"] == null ? null : json["vehiclePic"],
    color: json["color"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    defaultVehicle: json["defaultVehicle"] == null ? null : json["defaultVehicle"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brand": brand == null ? null : brand,
    "model": model == null ? null : model,
    "engine": engine == null ? null : engine,
    "year": year == null ? null : year,
    "plateNo": plateNo == null ? null : plateNo,
    "lastMaintenance": lastMaintenance == null ? null : lastMaintenance,
    "milege": milege == null ? null : milege,
    "vehiclePic": vehiclePic == null ? null : vehiclePic,
    "color": color,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
