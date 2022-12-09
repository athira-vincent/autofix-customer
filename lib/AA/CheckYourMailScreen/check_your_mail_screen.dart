import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckYourMailScreen extends StatefulWidget {
  const CheckYourMailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckYourMailScreenState();
  }
}

class _CheckYourMailScreenState extends State<CheckYourMailScreen> {
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  bool _isLoading = false;

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
    _getForgotPwd();
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.removeListener(onFocusChange);
    _forgotPasswordBloc.dispose();
  }

  _getForgotPwd() {
    _forgotPasswordBloc.postForgotPassword.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      } else {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text(
                "Password Reset Enabled.\nCheck Your mail",
                //AppLocalizations.of(context)!.text_Password_reset_enabled_check_mail,
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void onFocusChange() {
    setState(() {
      _labelStyleEmail = _emailFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                          child: SvgPicture.asset('assets/image/forgotPwd/forgotPwd_bg.svg',height: MediaQuery.of(context).size.height *0.23,),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
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
                                  AppLocalizations.of(context)!.text_check_mail,   //'Check your mail',
                                  style: Styles.textHeadLogin,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 10),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              //color: Colors.red,
                              child: Text(
                                AppLocalizations.of(context)!.text_check_mail_screen_desc,
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                style: Styles.textLabelSubTitle12,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20.8),
                                    child: _isLoading
                                        ? Center(
                                      child: Container(
                                        height: _setValue(28),
                                        width: _setValue(28),
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              CustColors.light_navy),
                                        ),
                                      ),
                                    )
                                        : Container(

                                      child: MaterialButton(
                                        onPressed: () {
                                          /*if (_formKey.currentState!.validate()) {
                                                      _forgotPasswordBloc.postForgotPasswordRequest(
                                                          _emailController.text);

                                                      setState(() {
                                                        _isLoading = true;
                                                      });
                                                    } else {
                                                      setState(() =>
                                                      _autoValidate = AutovalidateMode.always);
                                                    }*/
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPasswordScreen(otpNumber: "1234",)),
                                          );
                                        },
                                        child: Container(
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.text_btn_go_to_mail,     //'Go to email',
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

                                  SizedBox(
                                    height:MediaQuery.of(context).size.height *0.15 ,
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(top: 15.8),
                                    alignment: Alignment.center,
                                    child: RichText(
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: AppLocalizations.of(context)!.text_check_spam,     //"Did not receive the email? Check your spam filter Or ",
                                            style: Styles.textLabelSubTitle,
                                          ),
                                          TextSpan(
                                              text: AppLocalizations.of(context)!.text_try_another,   //'try another email address ',
                                              style: Styles.textLabelTitle_10,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ForgotPasswordScreen()),
                                                  );
                                                }),
                                        ],
                                      ),
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
              ],
            ),
          ),
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

