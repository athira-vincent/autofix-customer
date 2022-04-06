import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_edit_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_mdl.dart';

class CustomerEditProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<CustomerEditProfileMdl> postCustEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustEditProfileRequest(
       token, firstName,  lastName,  state, status, imageUrl,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerEditProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerEditProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerEditProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
