class TopBrandsMdl {
  late String status;
  late String message;
  late Data? data;

  TopBrandsMdl({required this.status, required this.message, this.data});

  TopBrandsMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  //SignUp signUp;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    // signUp =
    //     json['agentSignUp'] != null ? new SignUp.fromJson(json['agentSignUp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (this.signUp != null) {
    //   data['agentSignUp'] = this.signUp.toJson();
    // }
    return data;
  }
}
