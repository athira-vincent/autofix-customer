import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/expertise_selection_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicExpertiseSelectionBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<MechanicExpertiseSelectionMdl>();
  Stream<MechanicExpertiseSelectionMdl> get signUpResponse => postSignUp.stream;
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
    MechanicExpertiseSelectionMdl _signUpMdl = await repository.getMechanicSignUp(name,
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
