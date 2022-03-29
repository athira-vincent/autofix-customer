import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_mdl.dart';

class ForgotPasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<ForgotPasswordMdl> getForgotPasswordRequest(String email) async {
    Map<String, dynamic> _resp = await _queryProvider.forgotPassword(email);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            ForgotPasswordMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ForgotPasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          ForgotPasswordMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
