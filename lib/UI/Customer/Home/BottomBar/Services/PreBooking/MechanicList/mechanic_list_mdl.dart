
import 'dart:ffi';

class MechanicListMdl {
  String? status;
  String? message;
  Data? data;

  MechanicListMdl({required this.status, required this.message, this.data});

  MechanicListMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  MechanicList? mechanicList;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicList = (json['mechanicList'] != null ? MechanicList.fromJson(json['mechanicList']) : null)!;

  }

  Map<String, dynamic> toJson() {
    // if (this.signUp != null) {
    //   data['agentSignUp'] = this.signUp.toJson();
    // }
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicList'] = this.mechanicList!.toJson();
    return data;
  }
}

class MechanicList {

  int? totalItems;
  int? totalPages;
  int? currentPage;
  List<MechanicListData>? mechanicListData;

  MechanicList();

  MechanicList.fromJson(Map<String, dynamic> json){
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];

    if(json['data'] != null){
      mechanicListData = <MechanicListData>[];
      json['data'].forEach((v){
        mechanicListData!.add(new MechanicListData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    if (this.mechanicListData != null) {
      data['data'] =
          this.mechanicListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class MechanicListData {

  String? id;
  String? displayName;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? emailId;
  String? phoneNo;
  String? address;
  String? startTime;
  String? endTime;
  String? city;
  String? licenseNo;
  String? state;
  String? licenseDate;
  double? latitude;
  double? longitude;
  int? serviceId;
  String? profilePic;
  String? licenseProof;
  int? status;



  MechanicListData();

  MechanicListData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    displayName = json['displayName'];
    password = json['password'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    address = json['address'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    city = json['city'];
    licenseNo = json['licenseNo'];
    state = json['state'];
    licenseDate = json['licenseDate'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceId = json['serviceId'];
    profilePic = json['profilePic'];
    licenseProof = json['licenseProof'];
    status = json['status'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['phoneNo'] = this.phoneNo;
    data['address'] = this.address;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['city'] = this.city;
    data['licenseNo'] = this.licenseNo;
    data['state'] = this.state;
    data['licenseDate'] = this.licenseDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['serviceId'] = this.serviceId;
    data['profilePic'] = this.profilePic;
    data['licenseProof'] = this.licenseProof;
    data['status'] = this.status;

    return data;
  }
}
