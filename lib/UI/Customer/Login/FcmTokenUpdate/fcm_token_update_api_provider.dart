import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Login/ForgotPassword/forgot_password_mdl.dart';

import 'fcm_token_update_mdl.dart';

class FcmTokenUpdateApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<FcmTokenUpdateMdl> getfcmTokenUpdateRequest(String fcm,String Authtoken) async {
    Map<String, dynamic> _resp = await _queryProvider.fcmTokenUpdate(fcm,Authtoken);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        FcmTokenUpdateMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        print("+++++++++++++++++++++ minnu$_resp");
        return FcmTokenUpdateMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      FcmTokenUpdateMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}