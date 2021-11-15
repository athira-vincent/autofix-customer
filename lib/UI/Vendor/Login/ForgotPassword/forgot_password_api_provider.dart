import 'package:auto_fix/QueryProvider/query_provider.dart';

import 'forgot_password_mdl.dart';


class VendorForgotPasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<VendorForgotPasswordMdl> getForgotPasswordRequest(String email) async {
    Map<String, dynamic> _resp = await _queryProvider.forgotPassword(email);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        VendorForgotPasswordMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return VendorForgotPasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      VendorForgotPasswordMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
