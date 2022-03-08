import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_api_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_athorization_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_api_provider.dart';

import '../UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_api_provider.dart';


class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _vehicleSpecializationApiProvider = vehicleSpecializationApiProvider();

  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _fcmTokenUpdateApiProvider = FcmTokenUpdateApiProvider();
  final _genrateAuthorizationApiProvider = GenerateAuthorizationApiProvider();


  // Customer Individual SignUp
  Future<dynamic> getSignUpCustomeIndividual(String firstName, String userName, String email,
      String state, String password, String phone) =>
      _signupApiProvider.getSignUpCustomerIndividualRequest(
          firstName, userName, email, state, password, phone);

  // Customer Corporate SignUp
  Future<dynamic> getSignUpCustomeCorporate(String firstName, String userName, String email,
      String state, String password, String phone,String orgName,String orgType,) =>
      _signupApiProvider.getSignUpCustomerCorporateRequest(
          firstName, userName, email, state, password, phone,orgName,orgType);

  // Customer GovtBodies SignUp
  Future<dynamic> getSignUpCustomeGovtBodies(String firstName, String userName, String email,
      String state, String password, String phone,String orgName,String orgType,) =>
      _signupApiProvider.getSignUpCustomerGovtBodiesRequest(
          firstName, userName, email, state, password, phone,orgName,orgType);


  // Get State
  Future<dynamic> getStateList() => _signupApiProvider.getStates();


  // Get vehicleSpecialization
  Future<dynamic> getvehicleSpecializationList() => _vehicleSpecializationApiProvider.getVehicleSpecialization();
  //SignIn
  Future<dynamic> getSignIn(String userName, String password) =>
      _signinApiProvider.getSignInRequest(userName, password);


  //Forgot Password
  Future<dynamic> getForgotPassword(String email) =>
      _forgotPasswordApiProvider.getForgotPasswordRequest(email);

  //FcmTokenUpdate
  Future<dynamic> getcmTokenUpdateRequest(String fcm,String Authtoken) =>
      _fcmTokenUpdateApiProvider.getfcmTokenUpdateRequest(fcm,Authtoken);

  //get Token
  Future<dynamic> getToken(String userId, int type) =>
      _genrateAuthorizationApiProvider.getGenerateAuthorizationRequest(
          userId, type);



}
