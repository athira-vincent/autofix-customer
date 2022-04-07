import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/Mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/mechanic_profile_mdl.dart';

import 'package:rxdart/rxdart.dart';

class MechanicProfileBloc {
  final Repository repository = Repository();
  final postMechanicProfile = PublishSubject<MechanicProfileMdl>();
  Stream<MechanicProfileMdl> get MechanicProfileResponse =>
      postMechanicProfile.stream;
  dispose() {
    postMechanicProfile.close();
  }

  postMechanicFetchProfileRequest(
    String email,
  ) async {
    MechanicProfileMdl _MechanicProfileMdl = await repository.postMechanicFetchProfileRequest(email);
    postMechanicProfile.sink.add(_MechanicProfileMdl);
  }
}
