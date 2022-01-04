import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/specialization_selection_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicSpecializationSelectionBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<MechanicSpecializationSelectionMdl>();
  Stream<MechanicSpecializationSelectionMdl> get signUpResponse => postSignUp.stream;
  dispose() {
    postSignUp.close();
  }

  postSignUpSpecializationSelectionRequest(String token, String yearOfExperience,
      String brandIdList,
      String modelIdList,
      String jobType) async {
    MechanicSpecializationSelectionMdl _signUpMdl = await repository.getMechanicSignUpExpertizeSelection(
      token,
      yearOfExperience,brandIdList,modelIdList,jobType
    );
    postSignUp.sink.add(_signUpMdl);
  }
}
