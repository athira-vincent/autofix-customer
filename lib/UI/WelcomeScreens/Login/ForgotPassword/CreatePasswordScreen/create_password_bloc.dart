import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/CreatePasswordScreen/create_password_mdl.dart';

import 'package:rxdart/rxdart.dart';

class CreatePasswordBloc {
  final Repository repository = Repository();
  final postCreatePassword = PublishSubject<CreatePasswordMdl>();
  Stream<CreatePasswordMdl> get createPasswordResponse =>
      postCreatePassword.stream;
  dispose() {
    postCreatePassword.close();
  }

  postCreatePasswordRequest(
    String otp, String newPassword, String confirmPassword
  ) async {
    CreatePasswordMdl _createPasswordMdl = await repository.getCreatePassword(otp,newPassword,confirmPassword);
    postCreatePassword.sink.add(_createPasswordMdl);
  }
}
