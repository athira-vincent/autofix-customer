import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_models/signin_mdl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_models/customerSocialLogin_Mdl.dart';

class SigninBloc {

  final Repository repository = Repository();

  final postSignIn = PublishSubject<SigninMdl>();
  Stream<SigninMdl> get signInResponse => postSignIn.stream;

  postSignInRequest(String userName, String password) async {
    SigninMdl _signInMdl = await repository.getSignIn(userName, password);
    postSignIn.sink.add(_signInMdl);
  }

  final postsocialLogin = PublishSubject<CustomerSocialLoginMdl>();
  Stream<CustomerSocialLoginMdl> get socialLoginResponse => postsocialLogin.stream;

  socialLogin( email,  phoneNumber) async {
    CustomerSocialLoginMdl _socialResp = await repository.socialLogin( email,  phoneNumber);
    postsocialLogin.sink.add(_socialResp);
  }

  void userDefault(String token) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setString(SharedPrefKeys.token, token);
    shdPre.setBool(SharedPrefKeys.isUserLoggedIn, true);
    GqlClient.I.config(token: shdPre.getString(SharedPrefKeys.token).toString());
    print("token===================================${shdPre.getString(SharedPrefKeys.token)}");
  }

  dispose() {
    postSignIn.close();
  }

}
