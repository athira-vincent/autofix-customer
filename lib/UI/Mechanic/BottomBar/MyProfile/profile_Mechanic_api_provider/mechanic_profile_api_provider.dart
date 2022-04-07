import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_mdl.dart';

class MechanicProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicProfileMdl> postMechanicFetchProfileRequest(
      token)async {
    Map<String, dynamic> _resp = await _queryProvider. postMechanicFetchProfileRequest(
      token,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
