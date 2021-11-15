import 'package:auto_fix/QueryProvider/query_provider.dart';

import 'forgot_password_mdl.dart';


class MechanicForgotPasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicForgotPasswordMdl> getForgotPasswordRequest(String email) async {
    Map<String, dynamic> _resp = await _queryProvider.forgotPassword(email);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        MechanicForgotPasswordMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicForgotPasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      MechanicForgotPasswordMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
