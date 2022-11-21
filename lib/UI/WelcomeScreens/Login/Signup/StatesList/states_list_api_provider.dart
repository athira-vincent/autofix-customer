import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/CityList/city_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StatesList/states_list_mdl.dart';

class StatesListApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<StatesListMdl> postStatesListRequest(
      token,id)async {
    Map<String, dynamic> _resp = await _queryProvider.postStatesListRequest(
        token,id);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = StatesListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return StatesListMdl.fromJson(data);
      }
    } else {
      final errorMsg = StatesListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
