import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen1/signup_registration_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicSignupRegistrationBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<MechanicSignupRegistrationMdl>();
  Stream<MechanicSignupRegistrationMdl> get signUpResponse => postSignUp.stream;
  dispose() {
    postSignUp.close();
  }

  postSignUpRequest(String name,
      String email,
      String phoneNo,
      String address,
      double lat,
      double lng ,
      String walletId,
      String password) async {
    MechanicSignupRegistrationMdl _signUpMdl = await repository.getMechanicSignUp(name,
      email,
      phoneNo,
      address,
      lat,
      lng,
      walletId,
      password
    );
    postSignUp.sink.add(_signUpMdl);
  }
}
