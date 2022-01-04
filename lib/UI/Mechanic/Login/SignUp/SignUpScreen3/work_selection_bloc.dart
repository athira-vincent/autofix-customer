import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/work_selection_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicWorkSelectionBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<MechanicWorkSelectionMdl>();
  Stream<MechanicWorkSelectionMdl> get signUpResponse => postSignUp.stream;
  dispose() {
    postSignUp.close();
  }

  postSignUpWorkSelectionRequest(
      int isEmergencyEnabled,
      String serviceIdList,
      String serviceFeeList,
      String startTime,
      String endTime) async {
    MechanicWorkSelectionMdl _signUpMdl = await repository.getMechanicSignUpWorkSelection(
        isEmergencyEnabled, serviceIdList, serviceFeeList, startTime,endTime
    );
    postSignUp.sink.add(_signUpMdl);
  }
}
