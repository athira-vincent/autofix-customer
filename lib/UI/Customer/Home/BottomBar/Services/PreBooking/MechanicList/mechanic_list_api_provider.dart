import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_mdl.dart';

class MechanicListApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<MechanicListMdl> getAllMechanicListRequest(String token,int page, int size,String serviceId) async {
    Map<String, dynamic> _resp = await _queryProvider.getAllMechanicList(token, page, size,serviceId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            MechanicListMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicListMdl.fromJson(data);
      }
    } else {
      final errorMsg =
        MechanicListMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
