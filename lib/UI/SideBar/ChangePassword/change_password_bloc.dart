import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SideBar/ChangePassword/change_password_mdl.dart';
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
    String password,
  ) async {
    ChangePasswordMdl _changePasswordMdl =
        await repository.getChangePassword(password);
    postChangePassword.sink.add(_changePasswordMdl);
  }
}
