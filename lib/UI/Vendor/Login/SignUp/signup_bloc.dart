import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Vendor/Login/SignUp/signup_mdl.dart';
import 'package:rxdart/rxdart.dart';

class VendorSignupBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<VendorSignupMdl>();
  Stream<VendorSignupMdl> get signUpResponse => postSignUp.stream;
  dispose() {
    postSignUp.close();
  }

  postSignUpRequest(String firstName, String userName, String email,
      String state, String password, String phone) async {
    VendorSignupMdl _signUpMdl = await repository.getSignUp(
        firstName, userName, email, state, password, phone);
    postSignUp.sink.add(_signUpMdl);
  }
}
