// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen1/signup_registration_mdl.dart';



class MechanicSignupRegistrationApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicSignupRegistrationMdl> getMechanicSignUpRequest(
      String name,
      String email,
      String phoneNo,
      String address,
      double lat,
      double lng ,
      String walletId,
      String password) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicSignUp(
      name,email,phoneNo,address,lat,lng,walletId, password );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicSignupRegistrationMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicSignupRegistrationMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          MechanicSignupRegistrationMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
