
class MechanicForgotPasswordMdl {
  String? status;
  String? message;
  Data? data;

  MechanicForgotPasswordMdl({required this.status, required this.message, this.data});

  MechanicForgotPasswordMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  ForgotPassword? forgotPassword;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    forgotPassword = (json['mechanicForgotPassword'] != null ? ForgotPassword.fromJson(json['mechanicForgotPassword']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicForgotPassword'] = this.forgotPassword!.toJson();
    return data;
  }
}
class ForgotPassword {
  String? resetToken;

  ForgotPassword();

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    resetToken = json['resetToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resetToken'] = this.resetToken;
    return data;
  }
}