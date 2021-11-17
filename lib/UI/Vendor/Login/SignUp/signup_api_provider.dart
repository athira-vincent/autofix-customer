// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Vendor/Login/SignUp/signup_mdl.dart';



class VendorSignupApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<VendorSignupMdl> getSignUpRequest(String firstName, String userName,
      String email, String state, String password, String phone) async {
    Map<String, dynamic> _resp = await _queryProvider.vendorSignUp(
        firstName, userName, email, state, password, phone);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = VendorSignupMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return VendorSignupMdl.fromJson(data);
      }
    } else {
      final errorMsg =
                VendorSignupMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
