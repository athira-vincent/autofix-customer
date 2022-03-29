import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/CreatePasswordScreen/create_password_mdl.dart';

class CreatePasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<CreatePasswordMdl> getCreatePasswordRequest(String otp,String newPswd, String confirmPswd) async {
    Map<String, dynamic> _resp = await _queryProvider.createPassword(otp,newPswd,confirmPswd);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CreatePasswordMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CreatePasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg = CreatePasswordMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
