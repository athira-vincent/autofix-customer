import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_mdl.dart';

class MechanicMyJobReviewApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<MechanicMyJobReviewMdl> postMechanicMyJobReviewRequest(
      token,mechanicId)async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicMyJobReviewRequest(
      token,mechanicId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicMyJobReviewMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicMyJobReviewMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicMyJobReviewMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



}
