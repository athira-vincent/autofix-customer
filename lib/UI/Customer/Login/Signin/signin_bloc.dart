import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_mdl.dart';
import 'package:rxdart/rxdart.dart';

class SigninBloc {
  final Repository repository = Repository();
  final postSignIn = PublishSubject<SigninMdl>();
  Stream<SigninMdl> get signInResponse => postSignIn.stream;
  dispose() {
    postSignIn.close();
  }

  postSignInRequest(String userName, String password) async {
    SigninMdl _signInMdl = await repository.getSignIn(userName, password);
    postSignIn.sink.add(_signInMdl);
  }
}
