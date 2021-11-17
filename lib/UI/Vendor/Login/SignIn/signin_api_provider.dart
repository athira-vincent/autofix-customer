import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Vendor/Login/SignIn/signin_mdl.dart';


class VendorSigninApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<VendorSigninMdl> getSignInRequest(String userName, String password) async {
    Map<String, dynamic> _resp =
        await _queryProvider.signIn(userName, password);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = VendorSigninMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return VendorSigninMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          VendorSigninMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
