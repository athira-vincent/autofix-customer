import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';

import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {

  final String userType;
  final String userCategory;


  SignupScreen({required this.userType,required this.userCategory});

  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _stateFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SignupBloc _signupBloc = SignupBloc();
  bool _isLoading = false;
  List<StateDetails> _countryData = [];
  bool isloading = false;
  String? countryCode;
  double per = .10;
  double perfont = .10;
  double height = 0;
  final ScrollController _scrollController = ScrollController();
  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void initState() {
    super.initState();
    _signupBloc.dialStatesListRequest();
    _populateCountryList();
    _setSignUpVisitFlag();
    // _stateFocusNode.unfocus();
    // _stateFocusNode.canRequestFocus = false;
  }

  _setSignUpVisitFlag() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _shdPre.setBool(SharedPrefKeys.isCustomerSignUp, true);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    _passwordController.dispose();
    _confirmPwdController.dispose();
    _phoneController.dispose();
    _signupBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: CustColors.whiteBlueish,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [

                  IndicatorWidget(isFirst: true,isSecond: true,isThird: true,isFourth: false,),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.40 ,
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
                            child: SvgPicture.asset('assets/image/login/login_bgCar.svg',
                              height: MediaQuery.of(context).size.height * 0.23,),
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
                                          AppLocalizations.of(context)!.text_sign_up,
                                          style: Styles.textHeadLogin,
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
                                                  'Name',
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _userNameFocusNode,
                                                  keyboardType: TextInputType.text,
                                                  validator:
                                                  InputValidator(ch: "Your Name").emptyChecking,
                                                  controller: _userNameController,
                                                  cursorColor: CustColors.whiteBlueish,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: 'Your Name',
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
                                                        'Sign up',
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
                                                    text: "Already have an account ? ",
                                                    style: Styles.textLabelSubTitle,
                                                  ),
                                                  TextSpan(
                                                      text: 'Sign in',
                                                      style: Styles.textLabelTitle_10,
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    LoginScreen()),
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
                              )
                          )

                        ],
                      ),
                    )
                  )

                ],
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }


  void showDialCodeSelector() {
    _signupBloc.searchStates("");
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return BottomSheet(
                onClosing: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      height: 421,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: double.maxFinite,
                              child: Column(children: [
                                Container(
                                  height: _setValue(36.3),
                                  margin: EdgeInsets.only(
                                      left: _setValue(41.3),
                                      right: _setValue(41.3),
                                      top: _setValue(20.3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        _setValue(20),
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        spreadRadius: 0,
                                        blurRadius: 1.5,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: _setValue(23.4)),
                                          alignment: Alignment.center,
                                          height: _setValue(36.3),
                                          child: Center(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              onChanged: (text) {
                                                setState(() {
                                                  _countryData.clear();
                                                  isloading = true;
                                                });
                                                _signupBloc.searchStates(text);
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Corbel_Regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: CustColors.blue),
                                              decoration: InputDecoration(
                                                hintText: "Search Your  State",
                                                border: InputBorder.none,
                                                contentPadding:
                                                    new EdgeInsets.only(
                                                        bottom: 15),
                                                hintStyle: TextStyle(
                                                  color: CustColors.greyText,
                                                  fontSize: 12,
                                                  fontFamily: 'Corbel-Light',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: _setValue(25),
                                            height: _setValue(25),
                                            margin: EdgeInsets.only(
                                                right: _setValue(19)),
                                            decoration: BoxDecoration(
                                              color: CustColors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: _setValue(19)),
                                            child: Image.asset(
                                              'assets/images/search.png',
                                              width: _setValue(10.4),
                                              height: _setValue(10.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 421 - 108,
                                  padding:
                                      EdgeInsets.only(top: _setValue(22.4)),
                                  child: _countryData.length != 0
                                      ? ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: _countryData.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  final dial_Code =
                                                      _countryData[index].name;

                                                  setState(() {
                                                    _stateController.text =
                                                        dial_Code.toString();
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: _setValue(41.3),
                                                    right: _setValue(41.3),
                                                  ),
                                                  child: Text(
                                                    '${_countryData[index].name}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            _setValueFont(12),
                                                        fontFamily:
                                                            'Corbel-Light',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff0b0c0d)),
                                                  ),
                                                ));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    top: _setValue(12.7),
                                                    left: _setValue(41.3),
                                                    right: _setValue(41.3),
                                                    bottom: _setValue(12.9)),
                                                child: Divider(
                                                  height: 0,
                                                ));
                                          },
                                        )
                                      : Center(
                                          child: Text('No Results found.'),
                                        ),
                                ),
                              ])),
                          Center(
                            child: isloading
                                ? CircularProgressIndicator()
                                : Text(''),
                          )
                        ],
                      ),
                    ),
                  );
                });
          });
        });
  }

  _populateCountryList() {
    _signupBloc.statesCode.listen((value) {
      setState(() {
        isloading = false;
        _countryData = value.cast<StateDetails>();
      });
    });
  }
}
