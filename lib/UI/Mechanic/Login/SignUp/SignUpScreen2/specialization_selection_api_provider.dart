// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/specialization_selection_mdl.dart';


class MechanicSpecializationSelectionApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicSpecializationSelectionMdl> getMechanicExpertizeSelectionRequest(
      String token,
      String yearOfExperience,
      String brandIdList,
      String modelIdList,
      String jobType ) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicSignUpExpertizeSelection(
        token,
      yearOfExperience, brandIdList,modelIdList,jobType
       );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicSpecializationSelectionMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicSpecializationSelectionMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          MechanicSpecializationSelectionMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
