import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/PhoneLogin/otp_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../main.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhoneLoginScreenState();
  }
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {

  TextEditingController _phoneNoController = TextEditingController();
  FocusNode _phoneNoFocusNode = FocusNode();
  TextStyle _labelStylePhoneNo = TextStyle();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SigninBloc _signinBloc = SigninBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    _phoneNoController.addListener(onFocusChange);
    _listenApis();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNoFocusNode.removeListener(onFocusChange);
    _phoneNoController.dispose();
  }

  _listenApis() {
    _signinBloc.phoneLoginResponse.listen((value) async {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          if(value.message.contains(TextStrings.error_txt_account_not_exist) ){
            // String msg = value.message.split(":").last.toString();
            SnackBarWidget().setMaterialSnackBar("Account doesn't exist",_scaffoldKey);
          }
          else{
            SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
          }
        });
      } else {
        setState(() {
          _isLoading = false;
          _signinBloc.userDefaultData(value.data!.signInPhoneNo!.jwtToken.toString(),
              value.data!.signInPhoneNo!.userTypeId.toString(),
              "",           //----- profile image url should b updated
              value.data!.signInPhoneNo!.firstName.toString(),
              value.data!.signInPhoneNo!.id.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpVerificationScreen(
                      userType: "0",
                      userCategory: "0",
                      phoneNumber: "${_phoneNoController.text}",
                      otpNumber: "${value.data?.signInPhoneNo?.otp}",
                      userTypeId: "${value.data?.signInPhoneNo?.userTypeId}",
                      fromPage: "2",
                    ),
            ),
          );
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
                                        AppLocalizations.of(context)!.text_phone,   //'Phone Number',
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
                                      //"Enter your phone number ,you will receive a 4 digit code for  phone number varification. Select your country code before enter your Number."
                                      AppLocalizations.of(context)!.text_phone_screen_desc,
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
                                              Text(
                                                AppLocalizations.of(context)!.text_phone,   //'Phone Number',
                                                style: Styles.textLabelTitle,
                                              ),
                                              Row(
                                                children: [
                                                  Center(
                                                    child: CountryCodePicker(

                                                      onChanged: _onCountryChange,
                                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                      initialSelection: 'IT',
                                                      favorite: ['+234','FR'],
                                                      // optional. Shows only country name and flag
                                                      showCountryOnly: false,
                                                      // optional. Shows only country name and flag when popup is closed.
                                                      showOnlyCountryWhenClosed: false,
                                                      // optional. aligns the flag and the Text left
                                                      alignLeft: false,

                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      textAlignVertical: TextAlignVertical.center,
                                                      maxLines: 1,
                                                      style: Styles.textLabelSubTitle,
                                                      focusNode: _phoneNoFocusNode,
                                                      keyboardType: TextInputType.phone,
                                                      validator: InputValidator(
                                                          ch: AppLocalizations.of(context)!.text_phone,   //"Phone number"
                                                      ).phoneNumChecking,
                                                      controller: _phoneNoController,
                                                      //cursorColor: CustColors.whiteBlueish,
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        hintText: AppLocalizations.of(context)!.text_hint_phone,  //'Enter your phone Number',
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
                                                  ),
                                                ],
                                              ),
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
                                                    CustColors.light_navy),
                                              ),
                                            ),
                                          )
                                              : Container(

                                            child: MaterialButton(
                                              onPressed: () {
                                                print("${_phoneNoController.text}");
                                                setState(() {

                                                if (_formKey.currentState!.validate()) {
                                                  print("_formKey.currentState!.validate()");
                                                  _isLoading=true;
                                                  _signinBloc.phoneLogin("${_phoneNoController.text}");
                                                }else {
                                                  print("_formKey.currentState!.validate() - else");
                                                  setState(() => _autoValidate = AutovalidateMode.always);
                                                }

                                                });
                                              },
                                              child: Container(
                                                height: 45,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      //'Send',
                                                      AppLocalizations.of(context)!.text_btn_send,
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
                                                  text: AppLocalizations.of(context)!.text_back_to,  // "Back to ",
                                                  style: Styles.textLabelSubTitle,
                                                ),
                                                TextSpan(
                                                    text: AppLocalizations.of(context)!.text_sign_up,  //'SignUp',
                                                    style: Styles.textLabelTitle_10,
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SignupScreen( userType: '1', userCategory: '1',)),
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
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    print("New Country selected: " + countryCode.toString());
  }

}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

