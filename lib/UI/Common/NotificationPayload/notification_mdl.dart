// To parse this JSON data, do
//
//     final notificationPayloadMdl = notificationPayloadMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationPayloadMdl notificationPayloadMdlFromJson(String str) => NotificationPayloadMdl.fromJson(json.decode(str));

String notificationPayloadMdlToJson(NotificationPayloadMdl data) => json.encode(data.toJson());

class NotificationPayloadMdl {
  NotificationPayloadMdl({
    required this.clickAction,
    required this.id,
    required this.status,
    required this.screen,
    required this.bookingId,
    required this.serviceName,
    required this.serviceId,
    required this.serviceList,
    required this.carName,
    required this.carPlateNumber,
    required this.carColor,
    required this.customerName,
    required this.customerAddress,
    required this.customerLatitude,
    required this.customerLongitude,
    required this.customerFcmToken,
    required this.mechanicName,
    required this.mechanicID,
    required this.customerID,
    required this.mechanicPhone,
    required this.customerPhone,
    required this.mechanicAddress,
    required this.mechanicLatitude,
    required this.mechanicLongitude,
    required this.mechanicFcmToken,
    required this.mechanicArrivalState,
    required this.mechanicDiagonsisState,
    required this.customerDiagonsisApproval,
    required this.requestFromApp,
    required this.paymentStatus,
    required this.serviceTime,
    required this.serviceCost,
    required this.customerFromPage,
    required this.mechanicFromPage,
    required this.message,
  });

  String clickAction;
  String id;
  String status;
  String screen;
  String bookingId;
  String serviceName;
  String serviceId;
  String serviceList;
  String carName;
  String carPlateNumber;
  String carColor;
  String customerName;
  String serviceTime;
  String serviceCost;
  String customerAddress;
  String customerLatitude;
  String customerLongitude;
  String customerFcmToken;
  String mechanicName;
  String mechanicID;
  String customerID;
  String mechanicPhone;
  String customerPhone;
  String mechanicAddress;
  String mechanicLatitude;
  String mechanicLongitude;
  String mechanicFcmToken;
  String mechanicArrivalState;
  String mechanicDiagonsisState;
  String customerDiagonsisApproval;
  String requestFromApp;
  String paymentStatus;
  String customerFromPage;
  String mechanicFromPage;
  String message;

  factory NotificationPayloadMdl.fromJson(Map<String, dynamic> json) => NotificationPayloadMdl(
    clickAction: json["click_action"] == null ? null : json["click_action"],
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    screen: json["screen"] == null ? null : json["screen"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    serviceList: json["serviceList"] == null ? null : json["serviceList"],
    carName: json["carName"] == null ? null : json["carName"],
    carPlateNumber: json["carPlateNumber"] == null ? null : json["carPlateNumber"],
    carColor: json["carColor"] == null ? null : json["carColor"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    customerAddress: json["customerAddress"] == null ? null : json["customerAddress"],
    customerLatitude: json["customerLatitude"] == null ? null : json["customerLatitude"],
    customerLongitude: json["customerLongitude"] == null ? null : json["customerLongitude"],
    customerFcmToken: json["customerFcmToken"] == null ? null : json["customerFcmToken"],
    mechanicName: json["mechanicName"] == null ? null : json["mechanicName"],
    mechanicID: json["mechanicID"] == null ? null : json["mechanicID"],
    customerID: json["customerID"] == null ? null : json["customerID"],
    mechanicPhone: json["mechanicPhone"] == null ? null : json["mechanicPhone"],
    customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
    mechanicAddress: json["mechanicAddress"] == null ? null : json["mechanicAddress"],
    mechanicLatitude: json["mechanicLatitude"] == null ? null : json["mechanicLatitude"],
    mechanicLongitude: json["mechanicLongitude"] == null ? null : json["mechanicLongitude"],
    mechanicFcmToken: json["mechanicFcmToken"] == null ? null : json["mechanicFcmToken"],
    mechanicArrivalState: json["mechanicArrivalState"] == null ? null : json["mechanicArrivalState"],
    mechanicDiagonsisState: json["mechanicDiagonsisState"] == null ? null : json["mechanicDiagonsisState"],
    customerDiagonsisApproval: json["customerDiagonsisApproval"] == null ? null : json["customerDiagonsisApproval"],
    requestFromApp: json["requestFromApp"] == null ? null : json["requestFromApp"],
    paymentStatus: json["paymentStatus"] == null ? null : json["paymentStatus"],
    serviceTime: json["serviceTime"] == null ? null : json["serviceTime"],
    serviceCost: json["serviceCost"] == null ? null : json["serviceCost"],
    customerFromPage: json["customerFromPage"] == null ? null : json["customerFromPage"],
    mechanicFromPage: json["mechanicFromPage"] == null ? null : json["mechanicFromPage"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "click_action": clickAction == null ? null : clickAction,
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "screen": screen == null ? null : screen,
    "bookingId": bookingId == null ? null : bookingId,
    "serviceName": serviceName == null ? null : serviceName,
    "serviceId": serviceId == null ? null : serviceId,
    "serviceList": serviceList == null ? null : serviceList,
    "carName": carName == null ? null : carName,
    "carPlateNumber": carPlateNumber == null ? null : carPlateNumber,
    "carColor": carColor == null ? null : carColor,
    "customerName": customerName == null ? null : customerName,
    "customerAddress": customerAddress == null ? null : customerAddress,
    "customerLatitude": customerLatitude == null ? null : customerLatitude,
    "customerLongitude": customerLongitude == null ? null : customerLongitude,
    "customerFcmToken": customerFcmToken == null ? null : customerFcmToken,
    "mechanicName": mechanicName == null ? null : mechanicName,
    "mechanicID": mechanicID == null ? null : mechanicID,
    "customerID": customerID == null ? null : customerID,
    "mechanicPhone": mechanicPhone == null ? null : mechanicPhone,
    "customerPhone": customerPhone == null ? null : customerPhone,
    "serviceTime": serviceTime == null ? null : serviceTime,
    "serviceCost": serviceCost == null ? null : serviceCost,
    "mechanicAddress": mechanicAddress == null ? null : mechanicAddress,
    "mechanicLatitude": mechanicLatitude == null ? null : mechanicLatitude,
    "mechanicLongitude": mechanicLongitude == null ? null : mechanicLongitude,
    "mechanicFcmToken": mechanicFcmToken == null ? null : mechanicFcmToken,
    "mechanicArrivalState": mechanicArrivalState == null ? null : mechanicArrivalState,
    "mechanicDiagonsisState": mechanicDiagonsisState == null ? null : mechanicDiagonsisState,
    "customerDiagonsisApproval": customerDiagonsisApproval == null ? null : customerDiagonsisApproval,
    "requestFromApp": requestFromApp == null ? null : requestFromApp,
    "paymentStatus": paymentStatus == null ? null : paymentStatus,
    "customerFromPage": customerFromPage == null ? null : customerFromPage,
    "mechanicFromPage": mechanicFromPage == null ? null : mechanicFromPage,
    "message": message == null ? null : message,
  };
}
