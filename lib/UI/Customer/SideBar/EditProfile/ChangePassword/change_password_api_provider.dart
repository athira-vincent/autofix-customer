import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/ChangePassword/change_password_mdl.dart';


class ChangePasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<ChangePasswordMdl> getCreatePasswordRequest(String otp,String newPswd, String confirmPswd) async {
    Map<String, dynamic> _resp = await _queryProvider.createPassword(otp,newPswd,confirmPswd);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ChangePasswordMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ChangePasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg = ChangePasswordMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
