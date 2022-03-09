import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_api_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_athorization_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/mechanic_complete_profile_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_api_provider.dart';

import '../UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_api_provider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_api_provider.dart';


class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _addCarApiProvider = AddCarApiProvider();
  final _vehicleSpecializationApiProvider = vehicleSpecializationApiProvider();

  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _fcmTokenUpdateApiProvider = FcmTokenUpdateApiProvider();
  final _genrateAuthorizationApiProvider = GenerateAuthorizationApiProvider();
  final _completeProfileMecIndividualApiProvider = MechanicCompleteProfileApiProvider();


  // Customer Individual SignUp
  Future<dynamic> getSignUpCustomeIndividual(String firstName, String lastName, String email,
      String state, String password, String phone) =>
      _signupApiProvider.getSignUpCustomerIndividualRequest(
          firstName, lastName, email, state, password, phone);

  // Customer Corporate SignUp
  Future<dynamic> getSignUpCustomeCorporate(String firstName, String lastName, String email,
      String state, String password, String phone,String orgName,String orgType,) =>
      _signupApiProvider.getSignUpCustomerCorporateRequest(
          firstName, lastName, email, state, password, phone,orgName,orgType);

  // Customer GovtBodies SignUp
  Future<dynamic> getSignUpCustomeGovtBodies(String firstName, String lastName, String email,
      String state, String password, String phone,String govt_agency,
      String govt_type) =>
      _signupApiProvider.getSignUpCustomerGovtBodiesRequest(
          firstName, lastName, email, state, password, phone,govt_agency,govt_type);


  //  Mechanic Individual SignUp
  Future<dynamic> getSignUpMechanicIndividual(String firstName, String lastName, String email,
      String state, String password, String phone,String latitude, String longitude,
      String year_of_experience,) =>
      _signupApiProvider.getSignUpMechanicIndividualRequest(
          firstName, lastName, email, state, password, phone, latitude,  longitude,
         year_of_experience,);

  //  Mechanic Corporate SignUp
  Future<dynamic> getSignUpMechanicCorporate(String firstName, String lastName, String email,
      String state, String password, String phone,String latitude, String longitude,
      String year_of_experience, orgName, orgType) =>
      _signupApiProvider.getSignUpMechanicCorporateRequest(
        firstName, lastName, email, state, password, phone, latitude,  longitude,
        year_of_experience, orgName, orgType);


  //AddCar Of Customer
  Future<dynamic> postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,) =>
      _addCarApiProvider.postAddCarRequest(
        token,
        year,
        plateNo,
        engineName,
        lastMaintenance,
        milege,
        makeId,
        vehicleModelId,);

  //Otp Verification
  Future<dynamic> postOtpVerificationRequest(
      token,
      otp,) =>
      _signupApiProvider.postOtpVerificationRequest(
        token,
        otp,);

  // Make Brand List
  Future<dynamic> postMakeBrandRequest(
      token,) =>
      _addCarApiProvider.postMakeBrandRequest(
        token,);

  // Model Detail List
  Future<dynamic> postModelDetailRequest(
      token,type) =>
      _addCarApiProvider.postModelDetailRequest(
        token,type);



 /* // Mechanic Individual Complete Profile
  Future<dynamic> getCompleteProfileMechIndividual(String firstName, String phone) =>
      _completeProfileMecIndividualApiProvider.getcompleteProfileMechIndividualRequest(
          firstName, lastName,);

  // Mechanic Corporate Complete Profile
  Future<dynamic> getCompleteProfileMechCorporate(String firstName, String phone) =>
      _completeProfileMecIndividualApiProvider.getcompleteProfileMechCorporateRequest(
        firstName, lastName,);*/

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
