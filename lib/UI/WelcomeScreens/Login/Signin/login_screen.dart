import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/PhoneLogin/phone_login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import '../../../Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SigninBloc _signinBloc = SigninBloc();

  FcmTokenUpdateBloc _fcmTokenUpdateBloc = FcmTokenUpdateBloc();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  bool? _passwordVisible;
  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  bool language_en_ar=true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  bool socialLoginIsLoading = false;
  String facebookButtonClick = "0";

  final facebookLogin = FacebookLogin();
  Map? userProfile;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _getSignInRes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
          backgroundColor: CustColors.whiteBlueish,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              // ignore: avoid_unnecessary_containers
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height *0.40 ,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SvgPicture.asset('assets/image/login/login_bgCar.svg',height: MediaQuery.of(context).size.height *0.23,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CurvedBottomSheetContainer(
                      percentage:0.60,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              autovalidateMode: _autoValidate,
                              key: _formKey,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: _setValue(20.5), right: _setValue(20.5),top: _setValue(17.5), ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   /* InkWell(
                                      onTap: (){
                                        if(language_en_ar==true)
                                        {
                                          MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'ig'));
                                          setState(() {
                                            language_en_ar=false;
                                          });
                                        }
                                        else
                                        {
                                          MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'en'));
                                          setState(() {
                                            language_en_ar=true;
                                          });
                                        }
                                      },
                                      child:*/ Container(
                                        child: Text(
                                          AppLocalizations.of(context)!.login,
                                          style: Styles.textHeadLogin,
                                        ),
                                      ),
                                   // ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.text_email,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _userNameFocusNode,
                                                  keyboardType: TextInputType.text,
                                                  validator:
                                                  InputValidator(
                                                      ch: AppLocalizations.of(context)!.text_hint_email,
                                                  ).emailValidator,
                                                  controller: _userNameController,
                                                  cursorColor: CustColors.light_navy,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: AppLocalizations.of(context)!.text_hint_email,
                                                    border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: CustColors.greyish,
                                                        width: .5,
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: CustColors.greyish,
                                                        width: .5,
                                                      ),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: CustColors.greyish,
                                                        width: .5,
                                                      ),
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(
                                                      vertical: 12.8,
                                                      horizontal: 0.0,
                                                    ),
                                                    hintStyle: Styles.textLabelSubTitle,),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 20.5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_password,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  cursorColor: CustColors.light_navy,
                                                  textAlignVertical: TextAlignVertical.center,
                                                  obscureText: !_passwordVisible!,
                                                  validator:
                                                  InputValidator(ch:
                                                    AppLocalizations.of(context)!.text_password
                                                  ).emptyChecking,
                                                  // validator:
                                                  //     InputValidator(ch: "Password").passwordChecking,
                                                  controller: _passwordController,
                                                  focusNode: _passwordFocusNode,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    suffixIconConstraints: BoxConstraints(
                                                      minWidth: 25,
                                                      minHeight: 25,
                                                    ),
                                                    suffixIcon: Container(
                                                      width: 5,
                                                      height: 10,
                                                      alignment: Alignment.centerRight,
                                                      child: IconButton(
                                                        iconSize: 15,
                                                        padding: EdgeInsets.zero,
                                                        icon: Icon(
                                                          // Based on passwordVisible state choose the icon
                                                          _passwordVisible!
                                                              ? Icons.visibility
                                                              : Icons.visibility_off,
                                                          color: Colors.grey,
                                                        ),
                                                        onPressed: () {
                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                          setState(() {
                                                            _passwordVisible = !_passwordVisible!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    hintText: AppLocalizations.of(context)!.text_password,
                                                    errorMaxLines: 3,
                                                    border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: CustColors.greyish,
                                                        width: .5,
                                                      ),
                                                    ),
                                                    focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: CustColors.greyish,
                                                        width: .5,
                                                      ),
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: CustColors.greyish,
                                                        width: .5,
                                                      ),
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(
                                                      vertical: 12.8,
                                                      horizontal: 0.0,
                                                    ),
                                                    hintStyle: Styles.textLabelSubTitle,),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ForgotPasswordScreen()));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: _setValue(10)),
                                                        child: Text(
                                                          AppLocalizations.of(context)!.text_forgot_password,
                                                          style: Styles.textLabelSubTitle,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 20.8),
                                            child: _isLoading
                                                ? Center(
                                              child: Container(
                                                height: _setValue(28),
                                                width: _setValue(28),
                                                child: CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                      CustColors.peaGreen),
                                                ),
                                              ),
                                            )
                                                : Container(

                                              child: MaterialButton(
                                                onPressed: () {

                                                  if (_formKey.currentState!.validate()) {
                                                    setState(() {
                                                      _isLoading = true;
                                                      _signinBloc.postSignInRequest(_userNameController.text, _passwordController.text);
                                                    });
                                                  } else {
                                                    setState(() => _autoValidate =
                                                        AutovalidateMode.always);
                                                  }
                                                },
                                                child: Container(
                                                  height: 45,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.login,
                                                        textAlign: TextAlign.center,
                                                        style: Styles.textButtonLabelSubTitle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                color: CustColors.materialBlue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        _setValue(13))),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 15.8),
                                            child: RichText(
                                              maxLines: 2,
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: AppLocalizations.of(context)!.text_dont_have_account,
                                                    style: Styles.textLabelSubTitle,
                                                  ),
                                                  TextSpan(
                                                      text: AppLocalizations.of(context)!.text_sign_up,
                                                      style: Styles.textLabelTitle_10,
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UserSelectionScreen()),
                                                          );
                                                        }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 15.8),
                                            child: Text(
                                              AppLocalizations.of(context)!.text_or_login,  //'Or login with',
                                              style: Styles.textLabelSubTitleAzure,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                                                  child: IconButton(
                                                    icon: SvgPicture.asset(
                                                      'assets/image/login/login_gmail.svg',height: 30,width: 30,
                                                      fit: BoxFit.fill,
                                                      allowDrawingOutsideViewBox: true,
                                                    ),
                                                    onPressed: () async {
                                                      print('result');
                                                      await signInWithGoogle().then((result) {
                                                        print(result);
                                                        if (result != null) {
                                                          print("result sucess  $result");
                                                        } else if (result == null) {
                                                          print("result sucess  0");
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                                                  child: IconButton(
                                                    icon: SvgPicture.asset(
                                                      'assets/image/login/login_fb.svg',height: 30,width: 30,
                                                      fit: BoxFit.fill,
                                                      allowDrawingOutsideViewBox: true,
                                                    ),
                                                    onPressed: () async {
                                                      print('result facebook');
                                                      _loginWithFB();


                                                    },
                                                  ),
                                                ),

                                                InkWell(
                                                  onTap: (){

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PhoneLoginScreen()));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                    child: SvgPicture.asset('assets/image/login/login_phone.svg',height: 30,width: 30,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _signinBloc.dispose();
  }


  Future<void> setFcmToken(String Authtoken) async {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("Instance ID: +++++++++ +++++ +++++ minnu " + token.toString());

      _fcmTokenUpdateBloc.postFcmTokenUpdateRequest(token!,Authtoken);
    });
  }

  _getSignInRes() async {
    _signinBloc.signInResponse.listen((value) async {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          if(value.message!.contains(TextStrings.error_txt_account_not_exist) ){
            // String msg = value.message.split(":").last.toString();
            SnackBarWidget().setMaterialSnackBar("Account doesn't exist",_scaffoldKey);
          }
          else{
            SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
          }
          //SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      } else {
        setState(() {
          _isLoading = false;

          if(value.data!.signIn!.user!.userTypeId.toString() == "1"){
            _signinBloc.userDefault(
                value.data!.signIn!.token.toString(),
                TextStrings.user_customer,
                //value.data!.signIn!.user!.firstName.toString() + value.data!.signIn!.user!.lastName.toString(),
                value.data!.signIn!.user!.firstName.toString(),
                value.data!.signIn!.user!.id.toString(),"0"
            );
            setFcmToken(value.data!.signIn!.token.toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerMainLandingScreen()));
          }else {     //if(value.data!.signIn!.user!.userTypeId == "2"
            _signinBloc.userDefault(
                value.data!.signIn!.token.toString(),
                TextStrings.user_mechanic,
                value.data!.signIn!.user!.firstName.toString(),
                value.data!.signIn!.user!.id.toString(),"0"
            );
            setFcmToken(value.data!.signIn!.token.toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicHomeScreen()));
          }
        });
      }
    });

    _signinBloc.socialLoginResponse.listen((value) async {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          socialLoginIsLoading = false;
          SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      } else {
        setState(() {
          _isLoading = false;
          socialLoginIsLoading = false;
          if(value.data!.socialLogin!.user!.userTypeId == "1"){
            _signinBloc.userDefault(
                value.data!.socialLogin!.token.toString(),
                TextStrings.user_customer,
                value.data!.socialLogin!.user!.firstName.toString(),
                value.data!.socialLogin!.user!.id.toString(),"0");
            setFcmToken(value.data!.socialLogin!.token.toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerMainLandingScreen()));
          }else if(value.data!.socialLogin!.user!.userTypeId == "2"){
            _signinBloc.userDefault(
                value.data!.socialLogin!.token.toString(),
                TextStrings.user_mechanic,
                value.data!.socialLogin!.user!.firstName.toString(),
                value.data!.socialLogin!.user!.id.toString(),
                "0"
            );
            setFcmToken(value.data!.socialLogin!.token.toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicHomeScreen()));
          }
        });
      }
    });
  }

  Future<bool?> isDefaultVehicleAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? _isDefaultVehicleAvailable =
    prefs.getBool(SharedPrefKeys.isUserLoggedIn);
    // prefs.setBool(SharedPrefKeys.isWalked, true);
    return _isDefaultVehicleAvailable;
  }

  Future signInWithGoogle() async {
    setState(() {
      socialLoginIsLoading = true;
    });

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    final UserCredential authResult = await auth.signInWithCredential(credential);
    final User? user = authResult.user;
    //final user = authResult.user;
    print("result success  $user");
    setState(() {
      socialLoginIsLoading = false;
    });

    if (user != null) {
      print("result sucess user ${user.uid}");
      setState(() {
        socialLoginIsLoading = true;
        _signinBloc.socialLogin(user.email.toString(), "");
      });
    } else {
      setState(() {
        socialLoginIsLoading = false;
      });

    }
  }

  _loginWithFB() async {
    setState(() {
      socialLoginIsLoading = true;
    });
    print("_loginWithFB entered");

    facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    print("_loginWithFB entered2");
    print(result.status.toString() + "sdgdsgsg minnu");
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        print("$token");
        final graphResponse = await http.get(
            Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result
                .accessToken.token}'));
        final profile = JSON.jsonDecode(graphResponse.body);
        print("LoggedIn");
        print(profile.toString());
        print(profile['email']);
          setState(() {
            userProfile = profile;
            socialLoginIsLoading = true;
            _signinBloc.socialLogin(profile['email'].toString(), "");
          });

        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          facebookButtonClick = "0";
          socialLoginIsLoading = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          facebookButtonClick = "0";
          socialLoginIsLoading = false;
        });
        break;
    }
  }

}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
