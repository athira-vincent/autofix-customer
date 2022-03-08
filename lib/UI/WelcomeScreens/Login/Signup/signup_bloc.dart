import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';

import 'package:rxdart/rxdart.dart';

class SignupBloc {

  final Repository repository = Repository();



  /// --------------- Mechanic SignUp Starts -------------------- ///


  final postSignUpMechanic = PublishSubject<MechanicSignUpMdl>();
  Stream<MechanicSignUpMdl> get signUpMechanicResponse => postSignUpMechanic.stream;

  postSignUpMechanicIndividualRequest(String username, String email,
      String state, String password, String phone,String latitude, String longitude,
      String year_of_experience,) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    MechanicSignUpMdl _signUpMdl = await repository.getSignUpMechanicIndividual(
        firstName, lastName, email, state, password, phone, latitude,  longitude,
       year_of_experience,);
    postSignUpMechanic.sink.add(_signUpMdl);
  }

  postSignUpMechanicCorporateRequest(String username, String email,
      String state, String password, String phone,String latitude, String longitude,
      String year_of_experience,String orgName,String orgType,) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    MechanicSignUpMdl _signUpMdl = await repository.getSignUpMechanicCorporate(
      firstName, lastName, email, state, password, phone, latitude,  longitude,
      year_of_experience, orgName, orgType,);
    postSignUpMechanic.sink.add(_signUpMdl);
  }


  /// --------------- Mechanic SignUp ends -------------------- ///




  /// --------------- Customer SignUp Starts -------------------- ///


  final postSignUpCustomer = PublishSubject<CustomersSignUpIndividualMdl>();
  Stream<CustomersSignUpIndividualMdl> get signUpCustomerResponse => postSignUpCustomer.stream;

  postSignUpCustomerIndividualRequest(String username, String email,
      String state, String password, String phone) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    CustomersSignUpIndividualMdl _signUpMdl = await repository.getSignUpCustomeIndividual(
        firstName, lastName, email, state, password, phone);
    postSignUpCustomer.sink.add(_signUpMdl);
  }

  postSignUpCustomerCorporateRequest(String username,  String email,
      String state, String password, String phone,String orgName,String orgType,) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    CustomersSignUpIndividualMdl _signUpMdl = await repository.getSignUpCustomeCorporate(
        firstName, lastName, email, state, password, phone,orgName,orgType);
    postSignUpCustomer.sink.add(_signUpMdl);
  }


  postSignUpCustomerGovtBodiesRequest(String username,  String email,
      String state, String password, String phone,String govt_agency,
      String govt_type) async {
    String fullName = username;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    CustomersSignUpIndividualMdl _signUpMdl = await repository.getSignUpCustomeGovtBodies(
        firstName, lastName, email, state, password, phone,govt_agency,govt_type);
    postSignUpCustomer.sink.add(_signUpMdl);
  }


  /// --------------- Customer SignUp ends -------------------- ///


  final statesCode = PublishSubject<List<StateDetails>>();
  Stream<List<StateDetails>> get countryDialcodeResponse => statesCode.stream;

  List<StateDetails> _statesDataList = [];

  dialStatesListRequest() async {
    dynamic _state = await repository.getStateList();
    _statesDataList.clear();
    _statesDataList.addAll(_state.stateData);
    statesCode.sink.add(_state.stateData);
  }

  void searchStates(String searchText) {
    List<StateDetails> _searchList = [];
    _searchList.clear();
    if (searchText != '' || searchText != ' ') {
      _statesDataList.forEach((element) {
        if (element.name!.toLowerCase().startsWith(searchText.toLowerCase())) {
          _searchList.add(element);
        }
      });

      statesCode.sink.add(_searchList);
    } else {
      statesCode.sink.add(_statesDataList);
    }
  }


  dispose() {
    statesCode.close();
    postSignUpCustomer.close();
  }
}
