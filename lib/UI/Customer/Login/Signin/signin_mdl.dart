class SigninMdl {
  String? status;
  String? message;
  Data? data;

  SigninMdl({required this.status, required this.message, this.data});

  SigninMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  CustomerSignIn? customerSignIn;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    customerSignIn = json['customerSignIn'] != null
        ? new CustomerSignIn.fromJson(json['customerSignIn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.customerSignIn != null) {
      data['customerSignIn'] = this.customerSignIn!.toJson();
    }

    return data;
  }
}

class CustomerSignIn {
  String? token;
  Customer? customer;
  CustomerSignIn.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
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
  int? status;
  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
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
    return data;
  }
}
