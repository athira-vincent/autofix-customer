import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceStatusUpdate/service_status_update_mdl.dart';

class ServiceStatusUpdateApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<ServiceStatusUpdateMdl> postRegularServiceStatusUpdate(
      token,  bookingId, bookStatus)async {
    Map<String, dynamic> _resp = await _queryProvider.postRegularServiceStatusUpdateRequest(
        token,  bookingId, bookStatus);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ServiceStatusUpdateMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ServiceStatusUpdateMdl.fromJson(data);
      }
    } else {
      final errorMsg = ServiceStatusUpdateMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

}
