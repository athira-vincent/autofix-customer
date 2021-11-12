import 'package:auto_fix/QueryProvider/query_provider.dart';
<<<<<<< HEAD:lib/UI/SideBar/Profile/EditProfile/edit_profile_api_provider.dart
import 'package:auto_fix/UI/SideBar/Profile/EditProfile/edit_profile_mdl.dart';
=======
import 'package:auto_fix/UI/Customer/Home/Profile/EditProfile/edit_profile_mdl.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Home/Profile/EditProfile/edit_profile_api_provider.dart

class EditProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<EditProfileMdl> getEditProfileRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.editProfile();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            EditProfileMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return EditProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          EditProfileMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
