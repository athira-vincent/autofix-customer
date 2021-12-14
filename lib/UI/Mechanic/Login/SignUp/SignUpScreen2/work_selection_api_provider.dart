// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/work_selection_mdl.dart';


class MechanicWorkSelectionApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicWorkSelectionMdl> getMechanicWorkSelectionRequest(
      String yearOfExperience,
      bool isEmergencyEnabled,
      String serviceIdList
      ) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicSignUpWorkSelection(
      yearOfExperience, isEmergencyEnabled, serviceIdList
       );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicWorkSelectionMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicWorkSelectionMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          MechanicWorkSelectionMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
