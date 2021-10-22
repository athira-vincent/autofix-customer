import 'package:auto_fix/UI/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/Login/Signup/signup_api_provider.dart';

class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  //SignUp
  Future<dynamic> getSignUp(String firstName, String userName, String email,
          String state, String password) =>
      _signupApiProvider.getSignUpRequest(
          firstName, userName, email, state, password);
  //SignIn
  Future<dynamic> getSignIn(String userName, String password) =>
      _signinApiProvider.getSignInRequest(userName, password);
  //Forgot Password
  Future<dynamic> getForgotPassword(String email) =>
      _forgotPasswordApiProvider.getForgotPasswordRequest(email);
}
