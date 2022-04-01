import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_api_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_athorization_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/mechanic_complete_profile_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_api_provider.dart';

import '../UI/Customer/BottomBar/Home/HomeCustomer/home_customer_apiProvider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_api_provider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_api_provider.dart';


class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _homeCustomerApiProvider = HomeCustomerApiProvider();
  final _addCarApiProvider = AddCarApiProvider();
  final _vehicleSpecializationApiProvider = vehicleSpecializationApiProvider();

  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _createPasswordApiProvider = ResetPasswordApiProvider();
  final _fcmTokenUpdateApiProvider = FcmTokenUpdateApiProvider();
  final _genrateAuthorizationApiProvider = GenerateAuthorizationApiProvider();
  final _completeProfileMechanicApiProvider = MechanicCompleteProfileApiProvider();
  final _serviceListApiProvider = ServiceListApiProvider();
  final _addServiceListApiProvider = AddServicesApiProvider();


  // Add Mechanic Service List
  Future<dynamic> getServiceList(String token, String type) =>
      _serviceListApiProvider.getServiceListRequest(token,type);

  // Service List
  Future<dynamic> getAddMechanicServiceList(String token, String serviceList, String timeList,String costList) =>
      _addServiceListApiProvider.getMechanicAddServiceListRequest(token,serviceList, timeList, costList);

  // SignUp
  Future<dynamic> signUp(  type, firstName, lastName, emailId, phoneNo, password, state, userTypeId,
      accountType, profilepic, org_name, org_type, govt_type, govt_agency, ministry_name,
      head_of_dept, latitude, longitude, year_of_experience, shop_name)  =>
      _signupApiProvider.signUp(  type, firstName, lastName, emailId, phoneNo, password, state, userTypeId,
          accountType, profilepic, org_name, org_type, govt_type, govt_agency, ministry_name,
          head_of_dept, latitude, longitude, year_of_experience, shop_name) ;



  //AddCar Of Customer
  Future<dynamic> postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,
      vehiclePic) =>
      _addCarApiProvider.postAddCarRequest(
        token,
        year,
        plateNo,
        engineName,
        lastMaintenance,
        milege,
        makeId,
        vehicleModelId,
          vehiclePic);

  //Otp Verification
  Future<dynamic> postOtpVerificationRequest(
      token,
      otp,
      userTypeId) =>
      _signupApiProvider.postOtpVerificationRequest(
        token,
        otp,
        userTypeId);

  //Mechanic Booking Id Request
  Future<dynamic> postMechanicsBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId) =>
      _homeCustomerApiProvider.postMechanicsBookingIDRequest(
          token,
          date,
          time,
          latitude,
          longitude,
          serviceId);

  //Mechanics List Emergency Request
  Future<dynamic> postFindMechanicsListEmergencyRequest(
      token,
      bookMechanicId,
      serviceId,
      serviceType) =>
      _homeCustomerApiProvider.postFindMechanicsListEmergencyRequest(
          token,
          bookMechanicId,
          serviceId,
          serviceType);

  // Search Service Request
  Future<dynamic>  postSearchServiceRequest(
      token,
      search,
      count,
      categoryId)  =>
      _homeCustomerApiProvider. postSearchServiceRequest(
          token,
          search,
          count,
          categoryId) ;


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



  // Mechanic Individual Complete Profile
  Future<dynamic> getCompleteProfileMechIndividual(
      String token,
      String workSelection,
      String vehicleSpecialization,
     String address, String apprentice_cert,
      String identification_cert) =>
      _completeProfileMechanicApiProvider.getCompleteProfileMechIndividualRequest(
         token, workSelection, vehicleSpecialization,address, apprentice_cert, identification_cert );

  // Mechanic Corporate Complete Profile
  Future<dynamic> getCompleteProfileMechCorporate(String token,
      String serviceType,
      String vehicleSpecialization,
      String address,
      String mechanicNumber,
      String rcNumber,
      String existenceYear) =>
      _completeProfileMechanicApiProvider.getCompleteProfileMechCorporateRequest(token,
        serviceType,
        mechanicNumber,
        rcNumber,
        vehicleSpecialization,
        existenceYear,
        address
      );

  // Get State
  Future<dynamic> getStateList() => _signupApiProvider.getStates();


  // Get vehicleSpecialization
  Future<dynamic> getvehicleSpecializationList() => _vehicleSpecializationApiProvider.getVehicleSpecialization();

  //SignIn
  Future<dynamic> getSignIn(String userName, String password) =>
      _signinApiProvider.getSignInRequest(userName, password);

  //socialLogin
  Future<dynamic> socialLogin( email,  phoneNumber) =>
      _signinApiProvider.socialLogin( email,  phoneNumber);

  //Forgot Password
  Future<dynamic> getForgotPassword(String email) =>
      _forgotPasswordApiProvider.getForgotPasswordRequest(email);

  //Reset Password
  Future<dynamic> getCreatePassword(String otp, String newPassword, String confirmPassword) =>
      _createPasswordApiProvider.getCreatePasswordRequest(otp,newPassword,confirmPassword);

/*
  //Change Password
  Future<dynamic> getCreatePassword(String otp, String newPassword, String confirmPassword) =>
      _createPasswordApiProvider.getCreatePasswordRequest(otp,newPassword,confirmPassword);
*/


  //FcmTokenUpdate
  Future<dynamic> getcmTokenUpdateRequest(String fcm,String Authtoken) =>
      _fcmTokenUpdateApiProvider.getfcmTokenUpdateRequest(fcm,Authtoken);

  //get Token
  Future<dynamic> getToken(String userId, int type) =>
      _genrateAuthorizationApiProvider.getGenerateAuthorizationRequest(
          userId, type);



}
