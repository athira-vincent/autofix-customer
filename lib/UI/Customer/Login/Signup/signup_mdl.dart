class SignupMdl {
  String? status;
  String? message;
  Data? data;

  SignupMdl({required this.status, required this.message, this.data});

  SignupMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  CustomerSignUp? customerSignUp;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    customerSignUp = json['customersSignUp'] != null
        ? new CustomerSignUp.fromJson(json['customersSignUp'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.customerSignUp != null) {
      data['customersSignUp'] = this.customerSignUp!.toJson();
    }
    return data;
  }
}

class CustomerSignUp {
  String? token;
  Customer? customer;
  int? isProfileCompleted;

  CustomerSignUp.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isProfileCompleted = json['isProfileCompleted'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['token'] = this.token;
    data['isProfileCompleted'] = this.isProfileCompleted;

    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? address;
  String? emailId;
  String? phoneNo;
  String? profilePic;
  int? isProfileCompleted;
  int? status;
  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    profilePic = json['profilePic'];
    isProfileCompleted = json['isProfileCompleted'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['emailId'] = this.emailId;
    data['phoneNo'] = this.phoneNo;
    data['status'] = this.status;
    data['profilePic'] = this.profilePic;
    data['isProfileCompleted'] = this.isProfileCompleted;
    return data;
  }
}
