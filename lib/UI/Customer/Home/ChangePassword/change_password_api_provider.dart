import 'package:auto_fix/QueryProvider/query_provider.dart';
<<<<<<< HEAD:lib/UI/SideBar/ChangePassword/change_password_api_provider.dart
import 'package:auto_fix/UI/SideBar/ChangePassword/change_password_mdl.dart';
=======
import 'package:auto_fix/UI/Customer/Home/ChangePassword/change_password_mdl.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Home/ChangePassword/change_password_api_provider.dart

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
