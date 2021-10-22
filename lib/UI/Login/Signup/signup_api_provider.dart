// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Login/Signup/signup_mdl.dart';

class SignupApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<SignupMdl> getSignUpRequest(String firstName, String userName,
      String email, String state, String password) async {
    Map<String, dynamic> _resp = await _queryProvider.signUp(
        firstName, userName, email, state, password);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SignupMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SignupMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          SignupMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
