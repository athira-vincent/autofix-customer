import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/SideBar/Profile/ViewProfile/view_profile_mdl.dart';

class ViewProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<ViewProfileMdl> getViewProfileRequest(String id) async {
    Map<String, dynamic> _resp = await _queryProvider.viewProfile(id);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            ViewProfileMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ViewProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          ViewProfileMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
