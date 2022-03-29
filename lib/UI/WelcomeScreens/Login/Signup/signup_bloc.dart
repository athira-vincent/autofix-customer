import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersCorporateSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersGovernmentSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersIndividualSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicCorporateSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicIndividualSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/states_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/signUp_Mdl.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../PhoneLogin/otp_Verification_Mdl.dart';

class SignupBloc {

  final Repository repository = Repository();

  /// --------------- Save Tocken -------------------- ///

  void userDefault(String token) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setString(SharedPrefKeys.token, token);
    GqlClient.I.config(token: '${shdPre.getString(SharedPrefKeys.token)}');
    print("token===================================${shdPre.getString(SharedPrefKeys.token)}");
  }


  /// ---------------  SignUp Starts -------------------- ///


  final postSignUp = PublishSubject<SignUpMdl>();
  Stream<SignUpMdl> get signUpResponse => postSignUp.stream;

  signUp(type, username, emailId, phoneNo, password, state, userTypeId,
      accountType, profilepic, org_name, org_type, govt_type, govt_agency, ministry_name,
      head_of_dept, latitude, longitude, year_of_experience, shop_name) async {
    String fullName = username.toString();
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName= fullName.substring(names[0].length);
    print(firstName);
    print(lastName);
    SignUpMdl _signUpMdl = await repository.signUp(type, firstName, lastName, emailId, phoneNo, password, state, userTypeId,
        accountType, profilepic, org_name, org_type, govt_type, govt_agency, ministry_name,
        head_of_dept, latitude, longitude, year_of_experience, shop_name) ;
    postSignUp.sink.add(_signUpMdl);
  }



  /// --------------- Otp Verification Starts -------------------- ///


  final postOtpVerification = PublishSubject<OtpVerificationMdl>();
  Stream<OtpVerificationMdl> get otpVerificationResponse => postOtpVerification.stream;


  postOtpVerificationRequest(
      token,
      otp,
      userTypeId
      ) async {
    OtpVerificationMdl vehicleCreateMdl = await repository.postOtpVerificationRequest(
      token,
      otp,
      userTypeId);
    postOtpVerification.sink.add(vehicleCreateMdl);
  }


  /// --------------- State Selection -------------------- ///


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
    postSignUp.close();
  }
}
