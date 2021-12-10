import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/work_selection_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicWorkSelectionBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<MechanicWorkSelectionMdl>();
  Stream<MechanicWorkSelectionMdl> get signUpResponse => postSignUp.stream;
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
    MechanicWorkSelectionMdl _signUpMdl = await repository.getMechanicSignUp(name,
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
