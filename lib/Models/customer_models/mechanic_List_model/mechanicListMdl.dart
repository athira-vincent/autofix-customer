
import 'dart:convert';

MechanicListMdl mechanicListMdlFromJson(String str) => MechanicListMdl.fromJson(json.decode(str));

String mechanicListMdlToJson(MechanicListMdl data) => json.encode(data.toJson());

class MechanicListMdl {
  MechanicListMdl({
   required this.status,
   required this.message,
   required this.data,
  });

  String status;
  String message;
  Data? data;

  factory MechanicListMdl.fromJson(Map<String, dynamic> json) => MechanicListMdl(
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
   required this.mechanicList,
  });

  MechanicList? mechanicList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicList: json["mechanicList"] == null ? null : MechanicList.fromJson(json["mechanicList"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicList": mechanicList == null ? null : mechanicList?.toJson(),
  };
}

class MechanicList {
  MechanicList({
   required this.totalItems,
   required this.data,
   required this.totalPages,
   required this.currentPage,
  });

  int totalItems;
  List<Datum>? data;
  int totalPages;
  int currentPage;

  factory MechanicList.fromJson(Map<String, dynamic> json) => MechanicList(
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems == null ? null : totalItems,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalPages": totalPages == null ? null : totalPages,
    "currentPage": currentPage == null ? null : currentPage,
  };
}

class Datum {
  Datum({
   required this.id,
   required this.userCode,
   required this.firstName,
   required this.lastName,
   required this.emailId,
   required this.phoneNo,
   required this.userTypeId,
   required this.status,
   required this.jwtToken,
   required this.fcmToken,
   required this.otpCode,
   required this.isProfile,
   required this.otpVerified,
   required this.mechanic,
   required this.mechanicStatus,
   required this.mechanicService,
   required this.totalAmount,
   required this.distance,
   required this.duration,
   required this.reviewCount,
   required this.mechanicReviewsData,
   required this.mechanicReview,
   required this.bookingsCount,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int userTypeId;
  int status;
  String jwtToken;
  String fcmToken;
  String otpCode;
  int isProfile;
  int otpVerified;
  List<Mechanic> mechanic= [];
  List<MechanicStatus> mechanicStatus = [];
  List<MechanicService> mechanicService = [];
  String totalAmount;
  String distance;
  String duration;
  int reviewCount;
  List<MechanicReviewsDatum> mechanicReviewsData = [];
  double mechanicReview;
  dynamic bookingsCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    status: json["status"] == null ? null : json["status"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
    mechanic: json["mechanic"] == null ? [] : List<Mechanic>.from(json["mechanic"].map((x) => Mechanic.fromJson(x))),
    mechanicStatus: json["mechanicStatus"] == null ? [] : List<MechanicStatus>.from(json["mechanicStatus"].map((x) => MechanicStatus.fromJson(x))),
    mechanicService: json["mechanicService"] == null ? [] : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
    totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
    distance: json["distance"] == null ? null : json["distance"],
    duration: json["duration"] == null ? null : json["duration"],
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
    mechanicReviewsData: json["mechanicReviewsData"] == null ? [] : List<MechanicReviewsDatum>.from(json["mechanicReviewsData"].map((x) => MechanicReviewsDatum.fromJson(x))),
    mechanicReview: json["mechanicReview"] == null ? null : json["mechanicReview"].toDouble(),
    bookingsCount: json["bookingsCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "status": status == null ? null : status,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic.map((x) => x.toJson())),
    "mechanicStatus": mechanicStatus == null ? null : List<dynamic>.from(mechanicStatus.map((x) => x.toJson())),
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService.map((x) => x.toJson())),
    "totalAmount": totalAmount == null ? null : totalAmount,
    "distance": distance == null ? null : distance,
    "duration": duration == null ? null : duration,
    "reviewCount": reviewCount == null ? null : reviewCount,
    "mechanicReviewsData": mechanicReviewsData == null ? null : List<dynamic>.from(mechanicReviewsData.map((x) => x.toJson())),
    "mechanicReview": mechanicReview == null ? null : mechanicReview,
    "bookingsCount": bookingsCount,
  };
}

class Mechanic {
  Mechanic({
   required this.id,
   required this.usersId,
   required this.yearExp,
   required this.profilePic,
   required this.mechType,
   required this.workType,
   required this.noMech,
   required this.state,
   required this.rcNumber,
   required this.brands,
   required this.address,
   required this.certificate1,
   required this.certificate2,
   required this.status,
   required this.rate,
   required this.reviewCount,
  });

  String id;
  dynamic usersId;
  String yearExp;
  String profilePic;
  String mechType;
  String workType;
  dynamic noMech;
  String state;
  String rcNumber;
  String brands;
  String address;
  dynamic certificate1;
  dynamic certificate2;
  int status;
  double rate;
  int reviewCount;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    usersId: json["usersId"],
    yearExp: json["yearExp"] == null ? null : json["yearExp"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    mechType: json["mechType"] == null ? null : json["mechType"],
    workType: json["workType"] == null ? null : json["workType"],
    noMech: json["noMech"],
    state: json["state"] == null ? null : json["state"],
    rcNumber: json["rcNumber"] == null ? null : json["rcNumber"],
    brands: json["brands"] == null ? null : json["brands"],
    address: json["address"] == null ? null : json["address"],
    certificate1: json["certificate1"],
    certificate2: json["certificate2"],
    status: json["status"] == null ? null : json["status"],
    rate: json["rate"] == null ? null : json["rate"].toDouble(),
    reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "usersId": usersId,
    "yearExp": yearExp == null ? null : yearExp,
    "profilePic": profilePic == null ? null : profilePic,
    "mechType": mechType == null ? null : mechType,
    "workType": workType == null ? null : workType,
    "noMech": noMech,
    "state": state == null ? null : state,
    "rcNumber": rcNumber == null ? null : rcNumber,
    "brands": brands == null ? null : brands,
    "address": address == null ? null : address,
    "certificate1": certificate1,
    "certificate2": certificate2,
    "status": status == null ? null : status,
    "rate": rate == null ? null : rate,
    "reviewCount": reviewCount == null ? null : reviewCount,
  };
}

class MechanicReviewsDatum {
  MechanicReviewsDatum({
   required this.id,
   required this.transType,
   required this.rating,
   required this.feedback,
   required this.bookingId,
   required this.orderId,
   required this.status,
   required this.order,
   required this.bookings,
   required this.productData,
  });

  String id;
  int transType;
  double rating;
  String feedback;
  int bookingId;
  int orderId;
  int status;
  dynamic order;
  dynamic bookings;
  dynamic productData;

  factory MechanicReviewsDatum.fromJson(Map<String, dynamic> json) => MechanicReviewsDatum(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    feedback: json["feedback"] == null ? null : json["feedback"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    orderId: json["orderId"] == null ? null : json["orderId"],
    status: json["status"] == null ? null : json["status"],
    order: json["order"],
    bookings: json["bookings"],
    productData: json["productData"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "rating": rating == null ? null : rating,
    "feedback": feedback == null ? null : feedback,
    "bookingId": bookingId == null ? null : bookingId,
    "orderId": orderId == null ? null : orderId,
    "status": status == null ? null : status,
    "order": order,
    "bookings": bookings,
    "productData": productData,
  };
}

class MechanicService {
  MechanicService({
   required this.id,
   required this.fee,
    required this.time,
    required this.service,
   required this.status,
   required this.userId,
  });

  String id;
  String fee;
  String time;
  Service? service;
  int status;
  int userId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    time: json["time"] == null ? null : json["time"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "time": time == null ? null : time,
    "service": service == null ? null : service?.toJson(),
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.icon,
    required this.minPrice,
    required this.maxPrice,
    required this.categoryId,
    required this.status,
    required this.regularStatus,
    required this.isChecked,
  });

  String id;
  String serviceName;
  dynamic description;
  String icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;
  int regularStatus = 0;
  bool isChecked = false;


  factory Service.fromJson(Map<String, dynamic> json) => Service(
    regularStatus: json["regularStatus"] == null ? null : json["regularStatus"],
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"],
    icon: json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
    isChecked: json["isChecked"] == null ? false : json["isChecked"],
  );

  Map<String, dynamic> toJson() => {
    "regularStatus": regularStatus == null ? null : regularStatus,
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "description": description,
    "icon": icon,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "categoryId": categoryId == null ? null : categoryId,
    "status": status == null ? null : status,
    "isChecked": isChecked == null ? null : isChecked,
  };
}

class MechanicStatus {
  MechanicStatus({
   required this.distance,
   required this.latitude,
   required this.longitude,
   required this.workStatus,
  });

  dynamic distance;
  String latitude;
  String longitude;
  dynamic workStatus;

  factory MechanicStatus.fromJson(Map<String, dynamic> json) => MechanicStatus(
    distance: json["distance"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    workStatus: json["workStatus"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "workStatus": workStatus,
  };
}
