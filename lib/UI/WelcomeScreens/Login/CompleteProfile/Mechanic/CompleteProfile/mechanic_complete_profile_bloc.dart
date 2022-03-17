
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/corporate_mech_complete_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/individual_mech_complete_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicCompleteProfileBloc {
  final Repository repository = Repository();

  /// --------------- Mechanic - Corporate - Complete profile Starts -------------------- ///

  final postCompleteProfileCorporate = PublishSubject<CorporateMechCompleteProfileMdl>();
  Stream<CorporateMechCompleteProfileMdl> get completeProfileCorporateResponse => postCompleteProfileCorporate.stream;

  postCompleteProfileCorporateRequest(String token, String serviceType, String vehicleList, String address,
      String MechanicNumber, String rcNumber,String existenceYear) async {

   // CorporateMechCompleteProfileMdl _completeProfileMdl = await repository.getCompleteProfileMechCorporateRequest();
    //postCompleteProfileCorporate.sink.add(_completeProfileMdl);
  }

  /// --------------- Mechanic - Individual - Complete profile Starts -------------------- ///
  final postCompleteProfileIndividual = PublishSubject<IndividualMechCompleteProfileMdl>();
  Stream<IndividualMechCompleteProfileMdl> get completeProfileIndividualResponse => postCompleteProfileIndividual.stream;

  postCompleteProfileIndividualRequest(String token,String workSelection,
      String vehicleSpecialization, String address, String apprentice_cert, String identification_cert) async {

    print(workSelection);
    IndividualMechCompleteProfileMdl _completeProfileMdl = await repository.getCompleteProfileMechIndividual(token,workSelection,
        vehicleSpecialization,address, apprentice_cert, identification_cert);
    postCompleteProfileIndividual.sink.add(_completeProfileMdl);
  }



}