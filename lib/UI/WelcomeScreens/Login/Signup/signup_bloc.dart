import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersSignUp_Individual_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';

import 'package:rxdart/rxdart.dart';

class SignupBloc {

  final Repository repository = Repository();


  final postSignUpCustomerIndividual = PublishSubject<CustomersSignUpIndividualMdl>();
  Stream<CustomersSignUpIndividualMdl> get signUpCustomerIndividualResponse => postSignUpCustomerIndividual.stream;



  final statesCode = PublishSubject<List<StateDetails>>();
  Stream<List<StateDetails>> get countryDialcodeResponse => statesCode.stream;

  List<StateDetails> _statesDataList = [];


  postSignUpCustomerIndividualRequest(String firstName, String lastName, String email,
      String state, String password, String phone) async {
    CustomersSignUpIndividualMdl _signUpMdl = await repository.getSignUpCustomeIndividual(
        firstName, lastName, email, state, password, phone);
    postSignUpCustomerIndividual.sink.add(_signUpMdl);
  }

  postSignUpCustomerCorporateRequest(String firstName, String lastName, String email,
      String state, String password, String phone,String orgName,String orgType,) async {
    CustomersSignUpIndividualMdl _signUpMdl = await repository.getSignUpCustomeCorporate(
        firstName, lastName, email, state, password, phone,orgName,orgType);
    postSignUpCustomerIndividual.sink.add(_signUpMdl);
  }


  postSignUpCustomerGovtBodiesRequest(String firstName, String lastName, String email,
      String state, String password, String phone,String govt_agency,
      String govt_type) async {
    CustomersSignUpIndividualMdl _signUpMdl = await repository.getSignUpCustomeGovtBodies(
        firstName, lastName, email, state, password, phone,govt_agency,govt_type);
    postSignUpCustomerIndividual.sink.add(_signUpMdl);
  }



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
    postSignUpCustomerIndividual.close();
  }
}
