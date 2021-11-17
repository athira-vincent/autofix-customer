// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/signup_mdl.dart';


class MechanicSignupApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicSignupMdl> getSignUpRequest(String firstName, String userName,
      String email, String state, String password, String phone) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicSignUp(
        firstName, userName, email, state, password, phone);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicSignupMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicSignupMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          MechanicSignupMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
