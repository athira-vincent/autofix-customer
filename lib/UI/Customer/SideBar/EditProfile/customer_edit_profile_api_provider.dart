import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_corporate_edit_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_government_edit_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_individual_edit_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_mdl.dart';

class CustomerEditProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();

  // Customer - individual
  Future<CustomerIndividualEditProfileMdl> postCustIndividualEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustIndividualEditProfileRequest(
       token, firstName,  lastName,  state, status, imageUrl,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerIndividualEditProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerIndividualEditProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerIndividualEditProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  // Customer - corporate
  Future<CustomerCorporateEditProfileMdl> postCustCorporateEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, orgName, orgType)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustCorporateEditProfileRequest(
      token, firstName,  lastName,  state, status, imageUrl, orgName, orgType);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerCorporateEditProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerCorporateEditProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerCorporateEditProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  // Customer - government
  Future<CustomerGovernmentEditProfileMdl> postCustGovernmentEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, ministryName)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustGovernmentEditProfileRequest(
      token, firstName,  lastName,  state, status, imageUrl, ministryName);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerGovernmentEditProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerGovernmentEditProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerGovernmentEditProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
