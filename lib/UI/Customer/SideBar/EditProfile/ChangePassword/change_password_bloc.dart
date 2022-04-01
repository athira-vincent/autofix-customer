import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/ChangePassword/change_password_mdl.dart';

import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc {
  final Repository repository = Repository();
  final postChangePassword = PublishSubject<ChangePasswordMdl>();
  Stream<ChangePasswordMdl> get changePasswordResponse =>
      postChangePassword.stream;
  dispose() {
    postChangePassword.close();
  }

  postChangePasswordRequest(
      String token, String email,String oldPassword, String newPassword, String confirmPassword
  ) async {
    ChangePasswordMdl _changePasswordMdl = await repository.getChangePassword(token,email,oldPassword,newPassword,confirmPassword);
    postChangePassword.sink.add(_changePasswordMdl);
  }
}
