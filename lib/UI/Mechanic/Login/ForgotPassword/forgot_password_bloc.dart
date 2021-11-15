import 'package:auto_fix/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'forgot_password_mdl.dart';

class MechanicForgotPasswordBloc {
  final Repository repository = Repository();
  final postForgotPassword = PublishSubject<MechanicForgotPasswordMdl>();
  Stream<MechanicForgotPasswordMdl> get forgotPasswordResponse =>
      postForgotPassword.stream;
  dispose() {
    postForgotPassword.close();
  }

  postForgotPasswordRequest(
    String email,
  ) async {
    MechanicForgotPasswordMdl _forgotPasswordMdl =
        await repository.getForgotPassword(email);
    postForgotPassword.sink.add(_forgotPasswordMdl);
  }
}
