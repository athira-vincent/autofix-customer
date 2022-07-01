import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_mdl.dart';


import 'package:rxdart/rxdart.dart';

class ResetPasswordBloc {
  final Repository repository = Repository();
  final postCreatePassword = PublishSubject<ResetPasswordMdl>();
  Stream<ResetPasswordMdl> get createPasswordResponse =>
      postCreatePassword.stream;
  dispose() {
    postCreatePassword.close();
  }

  postCreatePasswordRequest(
    String otp, String newPassword, String confirmPassword
  ) async {
    ResetPasswordMdl _createPasswordMdl = await repository.getCreatePassword(otp,newPassword,confirmPassword);
    postCreatePassword.sink.add(_createPasswordMdl);
  }
}
