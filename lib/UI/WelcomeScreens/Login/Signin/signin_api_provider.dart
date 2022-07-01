import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_models/phone_signin_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_models/signin_mdl.dart';

import 'login_models/customerSocialLogin_Mdl.dart';


class SigninApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<SigninMdl> getSignInRequest(String userName, String password) async {
    Map<String, dynamic> _resp =
        await _queryProvider.signIn(userName, password);
    print("getSignInRequest $_resp");
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SigninMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SigninMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          SigninMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustomerSocialLoginMdl> socialLogin( email,  phoneNumber) async {
    Map<String, dynamic> _resp =
    await _queryProvider.socialLogin( email,  phoneNumber);
    print("socialLogin $_resp");
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerSocialLoginMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerSocialLoginMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      CustomerSocialLoginMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }

  Future<PhoneSignInMdl> phoneLogin( phoneNumber) async {
    Map<String, dynamic> _resp =
    await _queryProvider.phoneLogin(  phoneNumber);
    print("socialLogin $_resp");
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = PhoneSignInMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return PhoneSignInMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      PhoneSignInMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

}
