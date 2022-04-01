import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_mdl.dart';

class ResetPasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<ResetPasswordMdl> getCreatePasswordRequest(String otp,String newPswd, String confirmPswd) async {
    Map<String, dynamic> _resp = await _queryProvider.createPassword(otp,newPswd,confirmPswd);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ResetPasswordMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ResetPasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg = ResetPasswordMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
