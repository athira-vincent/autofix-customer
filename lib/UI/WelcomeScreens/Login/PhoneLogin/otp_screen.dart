import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../main.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OtpVerificationScreenState();
  }
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  TextEditingController _phoneNoController = TextEditingController();
  FocusNode _phoneNoFocusNode = FocusNode();
  TextStyle _labelStylePhoneNo = TextStyle();

  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode ="";

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
    _phoneNoController.addListener(onFocusChange);
    _getForgotPwd();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNoFocusNode.removeListener(onFocusChange);
    _phoneNoController.dispose();
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
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Reset Enabled.\nCheck Your mail",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
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
      _labelStylePhoneNo = _phoneNoFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

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
                            child: SvgPicture.asset('assets/image/phoneLogin/otp_login_bg.svg',height: MediaQuery.of(context).size.height *0.23,),
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
                                  Container(
                                    child: Text(
                                      'Enter your code',
                                      style: Styles.textHeadLogin,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 10),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.centerLeft,
                                    //color: Colors.red,
                                    child: Text(
                                      "Enter your code number to verify your phone "
                                      "Enter the 4 digit code .",
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      style: Styles.textLabelSubTitle12,
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
                                              Text('4 digit Code',
                                                style: Styles.textLabelTitle,
                                              ),
                                              Container(
                                                child:  PinFieldAutoFill(
                                                  decoration: UnderlineDecoration(
                                                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                                                    colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                                                  ),
                                                  codeLength: 4,
                                                  onCodeSubmitted: (code) {},
                                                  onCodeChanged: (code) {
                                                    print(code);
                                                    if (code?.length == 6) {
                                                      FocusScope.of(context).requestFocus(FocusNode());
                                                    }
                                                  },
                                                ),
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

                                              },
                                              child: Container(
                                                height: 45,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Send',
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
                                                  text: "Didn’t receive code? ",
                                                  style: Styles.textLabelSubTitle,
                                                ),
                                                TextSpan(
                                                    text: 'Try again',
                                                    style: Styles.textLabelTitle_10,
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {

                                                      }),
                                              ],
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
                                                  text: "Code via call? ",
                                                    style: Styles.textLabelTitle_10,
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {

                                                  }
                                                ),
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
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _listOPT()
  async {
    await SmsAutoFill().listenForCode;
  }

}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

