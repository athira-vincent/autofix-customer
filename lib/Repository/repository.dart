import 'package:auto_fix/ApiProvider/customer_apiProvider.dart';
import 'package:auto_fix/ApiProvider/mechanic_api_provider.dart';
import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_api_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_athorization_api_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_api_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/ChangePassword/change_password_api_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_edit_profile_api_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_api_provider/mechanic_profile_api_provider.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CategoryList/category_list_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/mechanic_complete_profile_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_api_provider.dart';

import '../UI/Customer/BottomBar/Home/home_Customer_ApiProvier/home_customer_apiProvider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_api_provider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_api_provider.dart';


class Repository {


  final _customerApiProvider = CustomerApiProvider();
  final _mechanicApiProvider = MechanicApiProvider();

  final _signupApiProvider = SignupApiProvider();
  final _homeCustomerApiProvider = HomeCustomerApiProvider();
  final _customerFetchProfileApiProvider = CustomerProfileApiProvider();
  final _mechanicProfileApiProvider = MechanicProfileApiProvider();

  final _customerEditProfileApiProvider = CustomerEditProfileApiProvider();
  final _addCarApiProvider = AddCarApiProvider();
  final _vehicleSpecializationApiProvider = vehicleSpecializationApiProvider();

  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _createPasswordApiProvider = ResetPasswordApiProvider();
  final _changePasswordApiProvider = ChangePasswordApiProvider();
  final _fcmTokenUpdateApiProvider = FcmTokenUpdateApiProvider();
  final _genrateAuthorizationApiProvider = GenerateAuthorizationApiProvider();
  final _completeProfileMechanicApiProvider = MechanicCompleteProfileApiProvider();
  final _serviceListApiProvider = ServiceListApiProvider();
  final _addServiceListApiProvider = AddServicesApiProvider();
  final _addMechanicMyWalletApiProvider = MechanicMyWalletApiProvider();

  final _categoryListApiProvider = CategoryListApiProvider();

  // Add Mechanic Service List
  Future<dynamic> getServiceList(String token, categoryId) =>
      _serviceListApiProvider.getServiceListRequest(token, categoryId);

  // Service List
  Future<dynamic> getAddMechanicServiceList(String token, String serviceList, String timeList,String costList) =>
      _addServiceListApiProvider.getMechanicAddServiceListRequest(token,serviceList, timeList, costList);

  //  Category List
  Future<dynamic> getCategoryList(String token, searchText, count, categoryId) =>
      _categoryListApiProvider.getCategoryListRequest(token,searchText, count, categoryId);

  //  Category List Home Request
  Future<dynamic> getCategoryListHomeRequest(String token,categoryId) =>
      _homeCustomerApiProvider.getCategoryListHomeRequest(token,categoryId);


  // SignUp
  Future<dynamic> signUp( type, firstName, lastName, emailId, phoneNo, password, state,
      fcmToken, userTypeId, userType, profilepic, orgName, orgType,
      ministryName, hod, latitude, longitude, yearExp, shopName,)  =>
      _signupApiProvider.signUp( type, firstName, lastName, emailId, phoneNo, password, state,
        fcmToken, userTypeId, userType, profilepic, orgName, orgType,
        ministryName, hod, latitude, longitude, yearExp, shopName,) ;

  //AddCar Of Customer
  Future<dynamic> postAddCarRequest(
      token, brand, model, engine, year,
      plateNo, lastMaintenance, milege,
      vehiclePic, latitude, longitude,) =>
      _addCarApiProvider.postAddCarRequest(
        token, brand, model, engine, year,
        plateNo, lastMaintenance, milege,
        vehiclePic, latitude, longitude,);

  //Otp Verification
  Future<dynamic> postOtpVerificationRequest(
      token,
      otp,
      userTypeId) =>
      _signupApiProvider.postOtpVerificationRequest(
        token,
        otp,
        userTypeId);

  //Phone Login Otp Verification
  Future<dynamic> postPhoneLoginOtpVerificationRequest(
      token,
      otp,
      userTypeId) =>
      _signupApiProvider.postPhoneLoginOtpVerificationRequest(
          token,
          otp,
          userTypeId);

  //Mechanic Booking Id Request
  Future<dynamic> postMechanicsBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) =>
      _homeCustomerApiProvider.postMechanicsBookingIDRequest(
          token, date, time,
          latitude, longitude,
          serviceId, mechanicId, reqType,
          totalPrice, paymentType, travelTime);

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

  // Mechanic My Wallet
    Future<dynamic> postMechanicFetchMyWalletRequest(
        token,type) =>
        _addMechanicMyWalletApiProvider.postMechanicMyWalletRequest(
            token,type);

  // Mechanic Individual Complete Profile
  Future<dynamic> getCompleteProfileMechIndividual(
      String token,
      String workSelection,
      String vehicleSpecialization,
     String address, String apprentice_cert,
      String identification_cert,
      String photoUrl) =>
      _completeProfileMechanicApiProvider.getCompleteProfileMechIndividualRequest(
         token, workSelection, vehicleSpecialization,address, apprentice_cert, identification_cert,photoUrl );

  // Mechanic Corporate Complete Profile
  Future<dynamic> getCompleteProfileMechCorporate(String token,
      String serviceType,
      String vehicleSpecialization,
      String address,
      String mechanicNumber,
      String rcNumber,
      String existenceYear,
      String photoUrl) =>
      _completeProfileMechanicApiProvider.getCompleteProfileMechCorporateRequest(token,
        serviceType,
        mechanicNumber,
        rcNumber,
        vehicleSpecialization,
        existenceYear,
        address,
        photoUrl
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

  //phoneLogin
  Future<dynamic> phoneLogin( phoneNumber) =>
      _signinApiProvider.phoneLogin( phoneNumber);


  //Forgot Password
  Future<dynamic> getForgotPassword(String email) =>
      _forgotPasswordApiProvider.getForgotPasswordRequest(email);

  //Reset Password
  Future<dynamic> getCreatePassword(String otp, String newPassword, String confirmPassword) =>
      _createPasswordApiProvider.getCreatePasswordRequest(otp,newPassword,confirmPassword);

  //Change Password
  Future<dynamic> getChangePassword(String token, String email, String oldPassword, String newPassword, String confirmPassword) =>
      _changePasswordApiProvider.getChangePasswordRequest(token, email,oldPassword,newPassword,confirmPassword);


  //FcmTokenUpdate
  Future<dynamic> getcmTokenUpdateRequest(String fcm,String Authtoken) =>
      _fcmTokenUpdateApiProvider.getfcmTokenUpdateRequest(fcm,Authtoken);

  //get Token
  Future<dynamic> getToken(String userId, int type) =>
      _genrateAuthorizationApiProvider.getGenerateAuthorizationRequest(
          userId, type);

  // Fetch Profile Customer Request
  Future<dynamic>  postCustFetchProfileRequest(
      token)  =>
      _customerFetchProfileApiProvider.postCustFetchProfileRequest(
          token);

  // Fetch Mechanic Online Offline Request
  Future<dynamic>  postMechanicOnlineOfflineRequest(
      token, String status, String mechanicId)  =>
      _mechanicApiProvider.postMechanicOnlineOfflineRequest(
          token, status, mechanicId);

  // Fetch Mechanic Mechanic Location Update Request
  Future<dynamic>  postMechanicLocationUpdateRequest(
      token,lat,lng)  =>
      _mechanicApiProvider.postMechanicLocationUpdateRequest(
          token,lat,lng);

  // Fetch Mechanic Mechanic Brand Specialization Request
  Future<dynamic>  postMechanicBrandSpecializationRequest(
      token, brandName)  =>
      _mechanicApiProvider.postMechanicBrandSpecializationRequest(
          token, brandName);

  // Fetch Profile Mechanic Request
  Future<dynamic>  postMechanicFetchProfileRequest(token)  =>
      _mechanicProfileApiProvider.postMechanicFetchProfileRequest(token);

  // Edit Profile Mechanic Individual Request
  Future<dynamic>  postMechanicEditProfileIndividualRequest(token, firstName, lastName, state, profilepic, status, year_of_experience,)  =>
      _mechanicProfileApiProvider.postMechanicEditProfileIndividualRequest(token, firstName, lastName, state, profilepic, status, year_of_experience,);

  // Edit Profile Mechanic Corporate Request
  Future<dynamic>  postMechanicEditProfileCorporateRequest(token, firstName, lastName, state, profilepic,
      status, year_of_experience, org_Name, org_Type,)  =>
      _mechanicProfileApiProvider.postMechanicEditProfileCorporateRequest(token, firstName, lastName, state, profilepic,
        status, year_of_experience, org_Name, org_Type,);

  // Update Customer - individual Profile Request
  Future<dynamic>  postCustIndividualEditProfileRequest(

      String token, firstName,  lastName,  state, status, imageUrl)  =>
      _customerEditProfileApiProvider.postCustIndividualEditProfileRequest(
           token, firstName,  lastName,  state, status, imageUrl);

  // Update Customer - corporate Profile Request
  Future<dynamic>  postCustCorporateEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, orgName, orgType)  =>
      _customerEditProfileApiProvider.postCustCorporateEditProfileRequest(
          token, firstName,  lastName,  state, status, imageUrl, orgName, orgType );

  // Update Customer - government Profile Request
  Future<dynamic>  postCustGovernmentEditProfileRequest(
      String token, firstName,  lastName,  state, status, imageUrl, ministryName)  =>
      _customerEditProfileApiProvider.postCustGovernmentEditProfileRequest(
          token, firstName,  lastName,  state, status, imageUrl, ministryName);

  //  Vehicle List Request
  Future<dynamic>  postCustVehicleListRequest(
      token)  =>
      _homeCustomerApiProvider.postCustVehicleListRequest(
          token);


}
