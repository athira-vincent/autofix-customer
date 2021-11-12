import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/SideBar/ChangePassword/change_password_mdl.dart';

class ChangePasswordApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<ChangePasswordMdl> getChangePasswordRequest(String password) async {
    Map<String, dynamic> _resp = await _queryProvider.changePassword(password);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            ChangePasswordMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ChangePasswordMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          ChangePasswordMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
