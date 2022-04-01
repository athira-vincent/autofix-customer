import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/ChangePassword/change_password_mdl.dart';

import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc {
  final Repository repository = Repository();
  final postCreatePassword = PublishSubject<ChangePasswordMdl>();
  Stream<ChangePasswordMdl> get createPasswordResponse =>
      postCreatePassword.stream;
  dispose() {
    postCreatePassword.close();
  }

  postCreatePasswordRequest(
    String otp, String newPassword, String confirmPassword
  ) async {
    ChangePasswordMdl _createPasswordMdl = await repository.getCreatePassword(otp,newPassword,confirmPassword);
    postCreatePassword.sink.add(_createPasswordMdl);
  }
}
