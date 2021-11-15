import 'package:auto_fix/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'forgot_password_mdl.dart';

class VendorForgotPasswordBloc {
  final Repository repository = Repository();
  final postForgotPassword = PublishSubject<VendorForgotPasswordMdl>();
  Stream<VendorForgotPasswordMdl> get forgotPasswordResponse =>
      postForgotPassword.stream;
  dispose() {
    postForgotPassword.close();
  }

  postForgotPasswordRequest(
    String email,
  ) async {
    VendorForgotPasswordMdl _forgotPasswordMdl =
        await repository.getForgotPassword(email);
    postForgotPassword.sink.add(_forgotPasswordMdl);
  }
}
