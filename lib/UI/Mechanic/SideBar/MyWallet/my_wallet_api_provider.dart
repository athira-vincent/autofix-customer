import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/MechanicProfileCorporateEditMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/MechanicProfileIndividualEditMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_mdl.dart';

class MechanicMyWalletApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<MechanicMyWalletMdl> postMechanicMyWalletRequest(
      token,type)async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicMyWalletRequest(
      token,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicMyWalletMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicMyWalletMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicMyWalletMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



}
