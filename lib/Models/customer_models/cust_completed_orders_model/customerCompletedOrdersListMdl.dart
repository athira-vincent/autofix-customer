
import 'dart:convert';

CustomerCompletedOrdersListMdl customerCompletedOrdersListMdlFromJson(String str) => CustomerCompletedOrdersListMdl.fromJson(json.decode(str));

String customerCompletedOrdersListMdlToJson(CustomerCompletedOrdersListMdl data) => json.encode(data.toJson());

class CustomerCompletedOrdersListMdl {
  CustomerCompletedOrdersListMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory CustomerCompletedOrdersListMdl.fromJson(Map<String, dynamic> json) => CustomerCompletedOrdersListMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.custCompletedOrders,
  });

  List<CustCompletedOrder>? custCompletedOrders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    custCompletedOrders: json["cust_completed_orders"] == null ? null : List<CustCompletedOrder>.from(json["cust_completed_orders"].map((x) => CustCompletedOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cust_completed_orders": custCompletedOrders == null ? null : List<dynamic>.from(custCompletedOrders!.map((x) => x.toJson())),
  };
}

class CustCompletedOrder {
  CustCompletedOrder({
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
    required this.isRated,
    required this.status,
    required this.customerId,
    required this.mechanicId,
    required this.vehicleId,
    required this.mechanic,
    required this.customer,
    required this.vehicle,
    required this.bookService,
  });

  int id;
  String bookingCode;
  int reqType;
  int bookStatus;
  int totalPrice;
  var tax;
  var commission;
  var serviceCharge;
  dynamic totalTime;
  dynamic serviceTime;
  double latitude;
  double longitude;
  dynamic mechLatitude;
  dynamic mechLongitude;
  dynamic extend;
  dynamic totalExt;
  dynamic extendTime;
  DateTime? bookedDate;
  int isRated;
  int status;
  int customerId;
  int mechanicId;
  int vehicleId;
  Customer? mechanic;
  Customer? customer;
  Vehicle? vehicle;
  List<BookService>? bookService;

  factory CustCompletedOrder.fromJson(Map<String, dynamic> json) => CustCompletedOrder(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"],
    commission: json["commission"] == null ? null : json["commission"],
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    mechLatitude: json["mechLatitude"],
    mechLongitude: json["mechLongitude"],
    extend: json["extend"],
    totalExt: json["totalExt"],
    extendTime: json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"] == null ? null : json["mechanicId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    mechanic: json["mechanic"] == null ? null : Customer.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    bookService: json["bookService"] == null ? null : List<BookService>.from(json["bookService"].map((x) => BookService.fromJson(x))),
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
    "serviceTime": serviceTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "mechLatitude": mechLatitude,
    "mechLongitude": mechLongitude,
    "extend": extend,
    "totalExt": totalExt,
    "extendTime": extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate?.toIso8601String(),
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId == null ? null : mechanicId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "mechanic": mechanic == null ? null : mechanic?.toJson(),
    "customer": customer == null ? null : customer?.toJson(),
    "vehicle": vehicle == null ? null : vehicle?.toJson(),
    "bookService": bookService == null ? null : List<dynamic>.from(bookService!.map((x) => x.toJson())),
  };
}

class BookService {
  BookService({
    required this.id,
    required this.mechanicId,
    required this.customerId,
    required this.status,
    required this.serviceId,
    required this.service,
    required this.bookMechanicId,
  });

  String id;
  dynamic mechanicId;
  dynamic customerId;
  int status;
  int serviceId;
  Service? service;
  dynamic bookMechanicId;

  factory BookService.fromJson(Map<String, dynamic> json) => BookService(
    id: json["id"] == null ? null : json["id"],
    mechanicId: json["mechanicId"],
    customerId: json["customerId"],
    status: json["status"] == null ? null : json["status"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    bookMechanicId: json["bookMechanicId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "mechanicId": mechanicId,
    "customerId": customerId,
    "status": status == null ? null : status,
    "serviceId": serviceId == null ? null : serviceId,
    "service": service == null ? null : service?.toJson(),
    "bookMechanicId": bookMechanicId,
  };
}

class Service {
  Service({
    required this.serviceName,
    required this.serviceCode,
    required this.description,
    required this.id,
    required this.minPrice,
    required this.maxPrice,
    required this.icon,
    required this.categoryId,
  });

  String serviceName;
  String serviceCode;
  dynamic description;
  String id;
  String minPrice;
  String maxPrice;
  String icon;
  int categoryId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    serviceCode: json["serviceCode"] == null ? null : json["serviceCode"],
    description: json["description"],
    id: json["id"] == null ? null : json["id"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    icon: json["icon"] == null ? null : json["icon"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "serviceName": serviceName == null ? null : serviceName,
    "serviceCode": serviceCode == null ? null : serviceCode,
    "description": description,
    "id": id == null ? null : id,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "icon": icon == null ? null : icon,
    "categoryId": categoryId == null ? null : categoryId,
  };
}

class Customer {
  Customer({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.status,
    required this.userTypeId,
    required this.jwtToken,
    required this.fcmToken,
    required this.otpCode,
    required this.isProfile,
    required this.otpVerified,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int status;
  int userTypeId;
  String jwtToken;
  String fcmToken;
  String otpCode;
  int isProfile;
  int otpVerified;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    status: json["status"] == null ? null : json["status"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "status": status == null ? null : status,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
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
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
