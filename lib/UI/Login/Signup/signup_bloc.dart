import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Login/Signup/signup_mdl.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<SignupMdl>();
  Stream<SignupMdl> get signUpResponse => postSignUp.stream;
  dispose() {
    postSignUp.close();
  }

  postSignUpRequest(String firstName, String userName, String email,
      String state, String password) async {
    SignupMdl _signUpMdl =
        await repository.getSignUp(firstName, userName, email, state, password);
    postSignUp.sink.add(_signUpMdl);
  }
}
