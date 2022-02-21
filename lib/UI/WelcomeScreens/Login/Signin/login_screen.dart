import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../main.dart';


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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SigninBloc _signinBloc = SigninBloc();

  FcmTokenUpdateBloc _fcmTokenUpdateBloc = FcmTokenUpdateBloc();

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

  @override
  void initState() {
    super.initState();
    _setUserType();
    _passwordVisible = false;
    _getSignInRes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                                    InkWell(
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
                                      child: Container(
                                        child: Text(
                                          AppLocalizations.of(context)!.login,
                                          style: Styles.textHeadLogin,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Email',
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _userNameFocusNode,
                                                  keyboardType: TextInputType.text,
                                                  validator:
                                                  InputValidator(ch: "Your emailid").emptyChecking,
                                                  controller: _userNameController,
                                                  cursorColor: CustColors.whiteBlueish,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: 'Your emailid',
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
                                                Text('Password',
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  obscureText: !_passwordVisible!,
                                                  validator:
                                                  InputValidator(ch: "Password").emptyChecking,
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
                                                    hintText: 'Password',
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
                                                          'Forgot password?',
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
                                                    _signinBloc.postSignInRequest(
                                                        _userNameController.text,
                                                        _passwordController.text);
                                                    setState(() {
                                                      _isLoading = true;
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
                                                        'Login',
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
                                                    text: "Don't have account?  ",
                                                    style: Styles.textLabelSubTitle,
                                                  ),
                                                  TextSpan(
                                                      text: 'Sign Up',
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
                                              'Or login with',
                                              style: Styles.textLabelSubTitleAzure,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 20, bottom: 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                                                  child: SvgPicture.asset('assets/image/login/login_gmail.svg',height: 30,width: 30,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                                                  child: SvgPicture.asset('assets/image/login/login_fb.svg',height: 30,width: 30,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                  child: SvgPicture.asset('assets/image/login/login_phone.svg',height: 30,width: 30,),
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

  _setUserType() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setString(SharedPrefKeys.userType, TextStrings.user_customer);
  }

  Future<void> setFcmToken(String Authtoken) async {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("Instance ID: +++++++++ +++++ +++++ minnu " + token.toString());

      _fcmTokenUpdateBloc.postFcmTokenUpdateRequest(token!,Authtoken);
    });



  }


  _getSignInRes() async {
    _signinBloc.postSignIn.listen((value) async {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        _signinBloc.userDefault(value.data!.customerSignIn!.token.toString());
        setFcmToken(value.data!.customerSignIn!.token.toString());
        SharedPreferences shdPre = await SharedPreferences.getInstance();
        print(
            "check username ${value.data!.customerSignIn!.customer!.firstName.toString()}");
        shdPre.setString(
            SharedPrefKeys.userName,
            value.data!.customerSignIn!.customer!.firstName.toString() +
                " " +
                value.data!.customerSignIn!.customer!.lastName.toString());
        shdPre.setString(SharedPrefKeys.userEmail,
            value.data!.customerSignIn!.customer!.emailId.toString());
        shdPre.setString(SharedPrefKeys.userProfilePic,
            value.data!.customerSignIn!.customer!.profilePic.toString());
        shdPre.setInt(SharedPrefKeys.isDefaultVehicleAvailable,
            value.data!.customerSignIn!.customer!.isProfileCompleted!);
        shdPre.setInt(SharedPrefKeys.userID,
            int.parse(value.data!.customerSignIn!.customer!.id!));
        setState(() {
          _isLoading = false;
          //toastMsg.toastMsg(msg: "Successfully Signed In");
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //   content: Text("Successfully Signed In",
          //       style: TextStyle(
          //           fontFamily: 'Roboto_Regular',
          //           fontWeight: FontWeight.w600,
          //           fontSize: 14)),
          //   duration: Duration(seconds: 2),
          //   backgroundColor: CustColors.peaGreen,
          // ));

         /* if (value.data!.customerSignIn!.customer!.isProfileCompleted! == 2) {
            setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            FocusScope.of(context).unfocus();
          } else {
            //setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()));
          }*/
        });
      }
    });
  }

  void setIsSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isUserLoggedIn, true);
  }



  Future<bool?> isDefaultVehicleAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? _isDefaultVehicleAvailable =
    prefs.getBool(SharedPrefKeys.isUserLoggedIn);
    // prefs.setBool(SharedPrefKeys.isWalked, true);
    return _isDefaultVehicleAvailable;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
