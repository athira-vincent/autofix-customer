import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_mdl.dart';

class MechanicProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicProfileMdl> getMechanicDetailsRequest(String id,String serviceId) async {
    Map<String, dynamic> _resp = await _queryProvider.getMechanicDetails(id, serviceId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            MechanicProfileMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicProfileMdl(
          status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
