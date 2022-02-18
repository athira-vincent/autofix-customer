import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_api_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_athorization_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_api_provider.dart';


class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _fcmTokenUpdateApiProvider = FcmTokenUpdateApiProvider();
  final _genrateAuthorizationApiProvider = GenerateAuthorizationApiProvider();



  // Customer SignUpScreen1
  Future<dynamic> getSignUp(String firstName, String userName, String email,
          String state, String password, String phone) =>
      _signupApiProvider.getSignUpRequest(
          firstName, userName, email, state, password, phone);
  // Get State
  Future<dynamic> getStateList() => _signupApiProvider.getStates();
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
