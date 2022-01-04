import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_authorization_mdl.dart';

class GenerateAuthorizationApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<GenerateAutorizationMdl> getGenerateAuthorizationRequest(
      String userId, int type) async {
    Map<String, dynamic> _resp = await _queryProvider.getToken(userId, type);
    print("HHHHHHHHHHHH minnu $_resp");
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            GenerateAutorizationMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return GenerateAutorizationMdl.fromJson(data);
      }
    } else {
      final errorMsg = GenerateAutorizationMdl(
          status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
