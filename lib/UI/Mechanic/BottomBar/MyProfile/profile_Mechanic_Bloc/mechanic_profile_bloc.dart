import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/MechanicProfileCorporateEditMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/MechanicProfileIndividualEditMdl.dart';
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


  final postMechanicEditIndividualProfile = PublishSubject<MechanicProfileIndividualEditMdl>();
  Stream<MechanicProfileIndividualEditMdl> get MechanicEditIndividualProfileResponse => postMechanicEditIndividualProfile.stream;

  postMechanicEditProfileIndividualRequest(
      token, firstName, lastName, state,
      profilepic, status, year_of_experience,)
   async {
     MechanicProfileIndividualEditMdl _MechanicProfileMdl = await repository.postMechanicEditProfileIndividualRequest(
      token, firstName, lastName, state,
      profilepic, status, year_of_experience,);
    postMechanicEditIndividualProfile.sink.add(_MechanicProfileMdl);
  }


  final postMechanicEditCorporateProfile = PublishSubject<MechanicProfileCorporateEditMdl>();
  Stream<MechanicProfileCorporateEditMdl> get postMechanicEditCorporateProfileResponse => postMechanicEditCorporateProfile.stream;

  postMechanicEditProfileCorporateRequest(
      token, firstName, lastName, state, profilepic,
      status, year_of_experience, org_Name, org_Type,)
  async {
    MechanicProfileCorporateEditMdl _MechanicProfileMdl = await repository.postMechanicEditProfileCorporateRequest(
      token, firstName, lastName, state, profilepic,
      status, year_of_experience, org_Name, org_Type,);
    postMechanicEditCorporateProfile.sink.add(_MechanicProfileMdl);
  }

  dispose() {
    postMechanicProfile.close();
    postMechanicEditIndividualProfile.close();
    postMechanicEditCorporateProfile.close();
  }


}
