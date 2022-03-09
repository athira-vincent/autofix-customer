
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/corporate_mech_complete_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/individual_mech_complete_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicCompleteProfileBloc {
  final Repository repository = Repository();

  /// --------------- Mechanic - Corporate - Complete profile Starts -------------------- ///

  final postCompleteProfileCorporate = PublishSubject<CorporateMechCompleteProfileMdl>();
  Stream<CorporateMechCompleteProfileMdl> get completeProfileCorporateResponse => postCompleteProfileCorporate.stream;

  postCompleteProfileCorporateRequest(String username, ) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    CorporateMechCompleteProfileMdl _completeProfileMdl = await repository.getCompleteProfileMechCorporate(username,"aa");
    postCompleteProfileCorporate.sink.add(_completeProfileMdl);
  }

  /// --------------- Mechanic - Individual - Complete profile Starts -------------------- ///
  final postCompleteProfileIndividual = PublishSubject<IndividualMechCompleteProfileMdl>();
  Stream<IndividualMechCompleteProfileMdl> get completeProfileIndividualResponse => postCompleteProfileIndividual.stream;

  postCompleteProfileIndividualRequest(String username, String email,) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    IndividualMechCompleteProfileMdl _completeProfileMdl = await repository.getCompleteProfileMechIndividual(username,email);
    postCompleteProfileIndividual.sink.add(_completeProfileMdl);
  }



}