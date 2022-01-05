import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Home/SideBar/MyProfile/ViewProfile/view_profile_mdl.dart';

class MechanicViewProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicViewProfileMdl> getViewProfileRequest(String id,String token, ) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicViewProfile(id, token, );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        MechanicViewProfileMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicViewProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      MechanicViewProfileMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
