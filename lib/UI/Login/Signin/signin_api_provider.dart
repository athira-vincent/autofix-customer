import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Login/Signin/signin_mdl.dart';

class SigninApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<SigninMdl> getSignInRequest(String userName, String password) async {
    Map<String, dynamic> _resp =
        await _queryProvider.signIn(userName, password);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SigninMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SigninMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          SigninMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
