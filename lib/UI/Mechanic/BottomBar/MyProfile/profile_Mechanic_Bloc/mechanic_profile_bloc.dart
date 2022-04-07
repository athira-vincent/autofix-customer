import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicProfileBloc {
  final Repository repository = Repository();

  final postMechanicProfile = PublishSubject<MechanicProfileMdl>();
  Stream<MechanicProfileMdl> get MechanicProfileResponse => postMechanicProfile.stream;

  postMechanicFetchProfileRequest(
    String token,
  ) async {
    MechanicProfileMdl _MechanicProfileMdl = await repository.postMechanicFetchProfileRequest(token);
    postMechanicProfile.sink.add(_MechanicProfileMdl);
  }


  final postMechanicEditIndividualProfile = PublishSubject<MechanicProfileMdl>();
  Stream<MechanicProfileMdl> get MechanicEditIndividualProfileResponse => postMechanicEditIndividualProfile.stream;

  postMechanicEditProfileIndividualRequest(
      String token,
      ) async {
    MechanicProfileMdl _MechanicProfileMdl = await repository.postMechanicEditProfileIndividualRequest(token);
    postMechanicProfile.sink.add(_MechanicProfileMdl);
  }

  dispose() {
    postMechanicProfile.close();
  }


}
