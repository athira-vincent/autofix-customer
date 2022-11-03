import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/error_strings.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/work_selection_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';

import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../../../../../main.dart';

class OtpVerificationScreen extends StatefulWidget {

  final String userType;
  final String userCategory;
  final String phoneNumber;
  final String otpNumber;
  final String userTypeId;
  final String fromPage;


  OtpVerificationScreen({
    required this.userType,
    required this.userCategory,
    required this.phoneNumber,
    required this.otpNumber,
    required this.userTypeId,
    required this.fromPage});

  @override
  State<StatefulWidget> createState() {
    return _OtpVerificationScreenState();
  }
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  TextEditingController _phoneNoController = TextEditingController();
  final SignupBloc _signupBloc = SignupBloc();
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
  String userTypeId = "", phoneNumberEmail = "";

  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = new TextEditingController(text: "");
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color:CustColors.whiteBlueish,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  String authToken="";


  @override
  void initState() {
    super.initState();
    userTypeId = widget.userTypeId;
    phoneNumberEmail = widget.phoneNumber;
    getSharedPrefData();
    _phoneNoController.addListener(onFocusChange);
    //textEditingController.text = widget.otpNumber;
    _listenOtpVerificationResponse();

    _getSignatureCode();
    _startListeningSms();
  }

  _listenOtpVerificationResponse() {
    _signupBloc.postOtpVerification.listen((value) {
      if (value.status == "error") {

        setState(() {
          _isLoading = false;
        });
        if(value.message == ErrorStrings.error_no_network){
          SnackBarWidget().setMaterialSnackBar(ErrorStrings.error_no_network, _scaffoldKey);
        }
        else if(value.message.toString().split(":").last.trim() == ErrorStrings.error_202){
          SnackBarWidget().setMaterialSnackBar(AppLocalizations.of(context)!.error_202, _scaffoldKey);
        }
        else if(value.message.toString().split(":").last.trim() == ErrorStrings.error_211){
          SnackBarWidget().setMaterialSnackBar(AppLocalizations.of(context)!.error_211, _scaffoldKey);
        }else{
          SnackBarWidget().setMaterialSnackBar(
              "${value.message.toString().split(":").last}", _scaffoldKey);
        }

      } else {

        if(value.data!.otpVerification!.verified == 1){
          if(widget.fromPage=="3")
          {
            _isLoading = true;
            if(textEditingController.text == widget.otpNumber){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResetPasswordScreen(
                          otpNumber: textEditingController.text.toString(),
                        )),
              );
            }
            else{
              _isLoading = false;
              SnackBarWidget().setMaterialSnackBar( "Otp Verification failed", _scaffoldKey);
            }
          }
          else{
            _signupBloc.postPhoneLoginOtpVerificationRequest(textEditingController.text.toString(), userTypeId );
          }

        }else{
          SnackBarWidget().setMaterialSnackBar(
              "Verification failed. Try again. ", _scaffoldKey);
          ///------------- msg to send otp again --------------
        }
      }
    });

    _signupBloc.postResendOtp.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          SnackBarWidget().setMaterialSnackBar(
              "${value.message.toString().split(":").last}", _scaffoldKey);
        });
      } else {
        userTypeId = value.data!.resendOtp!.userTypeId.toString();
        phoneNumberEmail = value.data!.resendOtp!.phoneNo.toString();
        //_getSignatureCode();
        //_startListeningSms();
      }
    });

    _signupBloc.postPhoneLoginOtpVerification.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          SnackBarWidget().setMaterialSnackBar(
              "${value.message.toString().split(":").last}", _scaffoldKey);
        });
      } else {
        /// ------------ call to update local storage  ---------
        _signupBloc.userDefault(
          value.data!.signInOtp!.token,
          value.data!.signInOtp!.user!.userTypeId.toString() == "1"
              ? TextStrings.user_customer
              : TextStrings.user_mechanic,//user type
          value.data!.signInOtp!.user!.firstName.toString(),
          value.data!.signInOtp!.user!.id.toString(),
          value.data!.signInOtp!.user!.userCode.toString(),
          value.data!.signInOtp!.user!.phoneNo.toString(),
          value.data!.signInOtp!.user!.otpCode.toString(),
          value.data!.signInOtp!.user!.userTypeId.toString()
            );

        if(widget.fromPage=="2")
        {
          _isLoading = true;
          if(textEditingController.text == widget.otpNumber){
            print(widget.userTypeId.toString() + '>>>>>>>>>>>>>>>>widget.userTypeId');
            if(value.data!.signInOtp!.user!.isProfile.toString() == "1" ) {
              if(widget.userTypeId.toString() == "1")
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  CustomerMainLandingScreen()));
              }
              else{
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MechanicHomeScreen()));
              }
            }else{
              if(widget.userTypeId.toString() == "1")
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCarScreen(userCategory: "0",
                          userType: "0",fromPage: "1",)));
              }
              else{
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkSelectionScreen(
                          userCategory: value.data!.signInOtp!.genMechanic!.mechType.toString() == "1"
                              ? TextStrings.user_category_individual
                              : TextStrings.user_category_corporate,
                          userType: "0",)));
              }
            }
          }
          else
          {
            _isLoading = false;
            SnackBarWidget().setMaterialSnackBar( "Otp Verification failed", _scaffoldKey);
          }
        }
        else{
          _isLoading=true;
          print(textEditingController.text);
          print(authToken.toString());
          _isLoading = false;
          if( widget.fromPage == "3")
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ResetPasswordScreen(
                        otpNumber: value.data!.signInOtp!.user!.otpCode.toString(),
                      )),
            );
          }
          else if( widget.fromPage == "2")
          {
            print(widget.userTypeId.toString() + '>>>>>>>>>>>>>>>>widget.userTypeId');

            if(widget.userTypeId.toString() == "1")
            {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  CustomerMainLandingScreen()));
            }
            else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MechanicHomeScreen()));
            }

          }
          else if( widget.userType == TextStrings.user_customer)
          {
            _signupBloc.setProfileStatus(2);
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      AddCarScreen(userCategory:widget.userCategory ,userType: widget.userType,fromPage: "1",)),
            );
          }
          else if(widget.userType == TextStrings.user_mechanic && widget.userCategory == TextStrings.user_category_corporate)
          {
            _signupBloc.setProfileStatus(2);
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      WorkSelectionScreen(userCategory:widget.userCategory ,userType: widget.userType,)),
            );
          }
          else if(widget.userType == TextStrings.user_mechanic && widget.userCategory == TextStrings.user_category_individual)
          {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      WorkSelectionScreen(userCategory:widget.userCategory ,userType: widget.userType,)),
            );
          }
          else if( widget.userType == '1')
          {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      LoginScreen()),
            );
          }
          else
          {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      LoginScreen()),
            );
          }
          //_signupBloc.postOtpVerificationRequest(authToken.toString(),widget.otpNumber,'${widget.userTypeId}');

        }
      }
    });
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();

      print('userFamilyId'+authToken.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNoFocusNode.removeListener(onFocusChange);
    _phoneNoController.dispose();
    _forgotPasswordBloc.dispose();
    SmsVerification.stopListening();
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
                          widget.fromPage == "3"
                              ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SvgPicture.asset('assets/image/phoneLogin/EmailBgImage.svg',height: MediaQuery.of(context).size.height *0.23,),
                          )
                              : Padding(
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
                                      AppLocalizations.of(context)!.text_enter_code,    //'Enter your code',
                                      style: Styles.textHeadLogin,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 10),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.centerLeft,
                                    //color: Colors.red,
                                    child: Text(
                                      //AppLocalizations.of(context)!.text_otp_screen_desc,
                                      "Please enter the verification code sent to your mail id. ",
                                      /*"Enter your code number to verify your phone \n"
                                      "Enter the 4 digit code .",*/
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      style: Styles.textLabelSubTitle12,
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: _setValue(0.5), right: _setValue(0.5)),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: _setValue(15.5)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                                                child: Text(
                                                  AppLocalizations.of(context)!.text_otp_title,     //'4 digit Code',
                                                  style: Styles.textLabelTitle,
                                                ),
                                              ),
                                              Container(
                                                padding:  EdgeInsets.only(top: _setValue(15.5), bottom: _setValue(0.5)),
                                                child: TextFieldPin(
                                                    textController: textEditingController,
                                                    autoFocus: false,
                                                    codeLength: _otpCodeLength,
                                                    alignment: MainAxisAlignment.center,
                                                    defaultBoxSize: 50.0,
                                                    margin: 10,
                                                    selectedBoxSize: 50.0,
                                                    textStyle: TextStyle(fontSize: 16),
                                                    defaultDecoration: _pinPutDecoration,
                                                    selectedDecoration: _pinPutDecoration,
                                                    onChange: (code) {
                                                      _onOtpCallBack(code,false);
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                                          margin: EdgeInsets.only(top: 10.8),
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
                                                setState(() {
                                                  print(widget.fromPage.toString() + '>>>>>>>>>>>>>>>>widget.fromPage');
                                                  _onSubmitOtp();
                                                });
                                              },
                                              child: Container(
                                                height: 45,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context)!.text_btn_verify,     // 'Verify',
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
                                                  text: AppLocalizations.of(context)!.text_dont_receive_code,  //"Didn’t receive code? ",
                                                  style: Styles.textLabelSubTitle,
                                                ),
                                                TextSpan(
                                                    text: AppLocalizations.of(context)!.text_try_again,   //'Try again',
                                                    style: Styles.textLabelTitle_10,
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        _onClickRetry();
                                                      }),
                                              ],
                                            ),
                                          ),
                                        ),
                                        /*Container(
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
                                        ),*/
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

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print(">>>signature $signature");
  }

  /// listen sms
  _startListeningSms()  {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoading = !_isLoading;
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    /// ------------------ api for retry -----
    _signupBloc.postResendOtpRequest("", widget.phoneNumber);
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoading = true;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoading = false;
        _isLoadingButton = false;
      }else{
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    _signupBloc.postOtpVerificationRequest(
        textEditingController.text.toString(),
        userTypeId
    );
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoading = false;
        _isLoadingButton = false;
        _enableButton = false;
      });
      /// ----------------- api call for verify otp

      // _scaffoldKey.currentState?.showSnackBar(
      //     SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }

}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
