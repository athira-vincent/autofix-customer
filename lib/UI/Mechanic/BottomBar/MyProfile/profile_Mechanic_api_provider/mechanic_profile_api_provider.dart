import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/MechanicProfileCorporateEditMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/MechanicProfileIndividualEditMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_mdl.dart';

class MechanicProfileApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<MechanicProfileMdl> postMechanicFetchProfileRequest(
      token, userId)async {
    Map<String, dynamic> _resp = await _queryProvider. postMechanicFetchProfileRequest(
      token, userId);
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

  Future<MechanicProfileIndividualEditMdl> postMechanicEditProfileIndividualRequest(
      token, firstName, lastName, state, profilepic, status, year_of_experience,) async
  {
    Map<String, dynamic> _resp = await _queryProvider. postMechanicEditProfileIndividualRequest(
      token, firstName, lastName, state, profilepic,
      status, year_of_experience,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicProfileIndividualEditMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicProfileIndividualEditMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicProfileIndividualEditMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<MechanicProfileCorporateEditMdl> postMechanicEditProfileCorporateRequest(
      token, firstName, lastName, state, profilepic,
      status, year_of_experience, org_Name, org_Type,) async
  {
    Map<String, dynamic> _resp = await _queryProvider. postMechanicEditProfileCorporateRequest(
      token, firstName, lastName, state, profilepic,
      status, year_of_experience, org_Name, org_Type,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicProfileCorporateEditMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicProfileCorporateEditMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicProfileCorporateEditMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

}
