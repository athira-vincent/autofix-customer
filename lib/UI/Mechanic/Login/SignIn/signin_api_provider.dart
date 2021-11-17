import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignIn/signin_mdl.dart';


class MechanicSigninApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicSigninMdl> getSignInRequest(String userName, String password) async {
    Map<String, dynamic> _resp =
        await _queryProvider.signIn(userName, password);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicSigninMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicSigninMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          MechanicSigninMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
