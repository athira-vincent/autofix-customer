import 'package:auto_fix/Repository/repository.dart';
<<<<<<< HEAD:lib/UI/SideBar/ChangePassword/change_password_bloc.dart
import 'package:auto_fix/UI/SideBar/ChangePassword/change_password_mdl.dart';
=======
import 'package:auto_fix/UI/Customer/Home/ChangePassword/change_password_mdl.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Home/ChangePassword/change_password_bloc.dart
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
