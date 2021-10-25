import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Login/ForgotPassword/forgot_password_mdl.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBloc {
  final Repository repository = Repository();
  final postForgotPassword = PublishSubject<ForgotPasswordMdl>();
  Stream<ForgotPasswordMdl> get forgotPasswordResponse =>
      postForgotPassword.stream;
  dispose() {
    postForgotPassword.close();
  }

  postForgotPasswordRequest(
    String email,
  ) async {
    ForgotPasswordMdl _forgotPasswordMdl =
        await repository.getForgotPassword(email);
    postForgotPassword.sink.add(_forgotPasswordMdl);
  }
}
