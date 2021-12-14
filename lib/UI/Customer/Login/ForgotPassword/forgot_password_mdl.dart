class ForgotPasswordMdl {
  String? status;
  String? message;
  Data? data;

  ForgotPasswordMdl({required this.status, required this.message, this.data});

  ForgotPasswordMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  //SignUpScreen1 signUp;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    // signUp =
    //     json['agentSignUp'] != null ? new SignUpScreen1.fromJson(json['agentSignUp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (this.signUp != null) {
    //   data['agentSignUp'] = this.signUp.toJson();
    // }
    return data;
  }



}
