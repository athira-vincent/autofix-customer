import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/state_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';

import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
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

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _photoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  TextEditingController _orgTypeController = TextEditingController();
  TextEditingController _ministryGovtController = TextEditingController();
  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _yearOfExperienceController = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _stateFocusNode = FocusNode();
  FocusNode _photoFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPswdFocusNode = FocusNode();
  FocusNode _orgTypeFocusNode = FocusNode();
  FocusNode _ministryGovtFocusNode = FocusNode();
  FocusNode _contactPersonFocusNode = FocusNode();
  FocusNode _yearOfExperienceFocusNode = FocusNode();

  CheckInternet _checkInternet = CheckInternet();

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

  bool? _passwordVisible;
  bool? _confirmPasswordVisible;

  String selectedState = "";
  final picker = ImagePicker();
  File? _images;
  late String errorMsg;

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
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _getSignUpResponse();
    // _stateFocusNode.unfocus();
    // _stateFocusNode.canRequestFocus = false;
  }

  _setSignUpVisitFlag() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _shdPre.setBool(SharedPrefKeys.isCustomerSignUp, true);
  }

  _getSignUpResponse() {
    _signupBloc.postSignUp.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("errrrorr 02");
          _isLoading = false;
          SnackBarWidget().setSnackBar(value.message.toString(), context);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const AddCarScreen()));
        });
      } else {
        setState(()  {
          print("errrrorr 01");
          _isLoading = false;

          //setSignUp1Data(value);
          SnackBarWidget().setSnackBar("Successfully Registered", context);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const AddCarScreen()));
          FocusScope.of(context).unfocus();

        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _stateController.dispose();
    _photoController.dispose();
    _passwordController.dispose();
    _confirmPwdController.dispose();

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
                    height: size.height * 0.223,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, size.height * 0.020, 0, size.height * 0.010),
                            child: Image.asset('assets/image/SignUp/img_sign_up_customer.png',
                              height: size.height * 0.23,),
                          ),
                        ],
                      ),
                    ),
                  ),

                  CurvedBottomSheetContainer(
                    percentage:0.90,
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
                                      padding: EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                                      child: Column(
                                        children: [

                                          widget.userCategory == TextStrings.user_category_government ?
                                          Container() :
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.userCategory == TextStrings.user_category_individual ?
                                                   AppLocalizations.of(context)!.text_name :
                                                  AppLocalizations.of(context)!.text_organization_name,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _nameFocusNode,
                                                  keyboardType: TextInputType.name,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                        RegExp('[a-zA-Z ]')),
                                                  ],
                                                  validator: InputValidator(
                                                    ch : widget.userCategory == TextStrings.user_category_individual ?
                                                          AppLocalizations.of(context)!.text_name :
                                                    AppLocalizations.of(context)!.text_organization_name).nameChecking,
                                                  controller: _nameController,
                                                  cursorColor: CustColors.whiteBlueish,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:  widget.userCategory == TextStrings.user_category_individual ?
                                                              AppLocalizations.of(context)!.text_hint_name :
                                                    AppLocalizations.of(context)!.text_hint_organization_name,
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
                                          ) ,

                                          widget.userCategory == TextStrings.user_category_corporate ?
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_organization_type,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    //_showDialogSelectPhoto();
                                                    print("Type of Organisation");
                                                  },
                                                  child: TextFormField(
                                                    enabled: false,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    maxLines: 1,
                                                    style: Styles.textLabelSubTitle,
                                                    focusNode: _orgTypeFocusNode,
                                                    keyboardType: TextInputType.text,
                                                    //validator: InputValidator(ch: AppLocalizations.of(context)!.text_hint_organization_type).emptyChecking,
                                                    controller: _orgTypeController,
                                                    cursorColor: CustColors.whiteBlueish,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: AppLocalizations.of(context)!.text_hint_organization_type,
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
                                          ) : Container(),

                                          widget.userCategory == TextStrings.user_category_government ?
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_state,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    print("on tap state ");
                                                    //showDialCodeSelector();
                                                    /*String userSelectedState = await Navigator.push(
                                                      context,
                                                        MaterialPageRoute(
                                                        builder: (context) => SelectStateScreen(),
                                                        ),
                                                    );*/
                                                    _awaitReturnValueFromSecondScreen(context);

                                                  },
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    enabled: false,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    maxLines: 1,
                                                    style: Styles.textLabelSubTitle,
                                                    focusNode: _stateFocusNode,
                                                    //keyboardType: TextInputType.phone,
                                                    validator: InputValidator(ch: AppLocalizations.of(context)!.text_state).emptyChecking,
                                                    controller: _stateController,
                                                    cursorColor: CustColors.whiteBlueish,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: AppLocalizations.of(context)!.text_hint_state,
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
                                          ) : Container(),

                                          widget.userCategory == TextStrings.user_category_government ?
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_ministry_govt,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    print("on tap Ministry/Govt. agency ");
                                                    //showDialCodeSelector();
                                                    /*String userSelectedState = await Navigator.push(
                                                      context,
                                                        MaterialPageRoute(
                                                        builder: (context) => SelectStateScreen(),
                                                        ),
                                                    );*/
                                                   // _awaitReturnValueFromSecondScreen(context);

                                                  },
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    enabled: false,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    maxLines: 1,
                                                    style: Styles.textLabelSubTitle,
                                                    focusNode: _ministryGovtFocusNode,
                                                    //keyboardType: TextInputType.phone,
                                                    //validator: InputValidator(ch: " ministry/govt agency").emptyChecking,
                                                    controller: _ministryGovtController,
                                                    cursorColor: CustColors.whiteBlueish,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: AppLocalizations.of(context)!.text_hint_ministry_govt,
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
                                          ) : Container(),

                                          widget.userCategory == TextStrings.user_category_corporate
                                              || widget.userCategory == TextStrings.user_category_government?
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.text_contact_person,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _contactPersonFocusNode,
                                                  keyboardType: TextInputType.name,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(
                                                        RegExp('[a-zA-Z ]')),
                                                  ],
                                                  validator: InputValidator(ch :AppLocalizations.of(context)!.text_contact_person,).nameChecking,
                                                  controller: _contactPersonController,
                                                  cursorColor: CustColors.whiteBlueish,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: AppLocalizations.of(context)!.text_hint_contact_person,
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
                                          ) : Container() ,

                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_phone,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _phoneFocusNode,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(15),
                                                  ],
                                                  validator: InputValidator(ch: AppLocalizations.of(context)!.text_phone,).phoneNumChecking,
                                                  controller: _phoneController,
                                                  cursorColor: CustColors.whiteBlueish,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: AppLocalizations.of(context)!.text_hint_phone,
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
                                                Text(AppLocalizations.of(context)!.text_email,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _emailFocusNode,
                                                  keyboardType: TextInputType.emailAddress,
                                                  validator: InputValidator(ch: AppLocalizations.of(context)!.text_email).emailValidator,
                                                  controller: _emailController,
                                                  cursorColor: CustColors.whiteBlueish,
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

                                          widget.userCategory != TextStrings.user_category_government ?
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_state,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    print("on tap state ");
                                                    //showDialCodeSelector();
                                                    /*String userSelectedState = await Navigator.push(
                                                      context,
                                                        MaterialPageRoute(
                                                        builder: (context) => SelectStateScreen(),
                                                        ),
                                                    );*/
                                                    _awaitReturnValueFromSecondScreen(context);
                                                  },
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    enabled: false,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    maxLines: 1,
                                                    style: Styles.textLabelSubTitle,
                                                    focusNode: _stateFocusNode,
                                                    //keyboardType: TextInputType.phone,
                                                    validator: InputValidator(ch: AppLocalizations.of(context)!.text_state).emptyChecking,
                                                    controller: _stateController,
                                                    cursorColor: CustColors.whiteBlueish,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: AppLocalizations.of(context)!.text_hint_state,
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
                                          ) : Container(),

                                          widget.userType == TextStrings.user_mechanic
                                              && widget.userCategory == TextStrings.user_category_individual ?
                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_experience_year,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  maxLines: 1,
                                                  style: Styles.textLabelSubTitle,
                                                  focusNode: _yearOfExperienceFocusNode,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(3),
                                                  ],
                                                  //validator: InputValidator(ch: AppLocalizations.of(context)!.text_experience_year).phoneNumChecking,
                                                  controller: _yearOfExperienceController,
                                                  cursorColor: CustColors.whiteBlueish,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: AppLocalizations.of(context)!.text_hint_experience_year,
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
                                          ) : Container(),

                                          Container(
                                            margin: EdgeInsets.only(top: _setValue(15.5)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_upload_photo,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    _showDialogSelectPhoto();
                                                    print("on tap photo ");
                                                  },
                                                  child: TextFormField(
                                                    enabled: false,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    maxLines: 1,
                                                    style: Styles.textLabelSubTitle,
                                                    focusNode: _photoFocusNode,
                                                    keyboardType: TextInputType.text,
                                                    //validator: InputValidator(ch: AppLocalizations.of(context)!.text_photo).emptyChecking,
                                                    controller: _photoController,
                                                    cursorColor: CustColors.whiteBlueish,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: AppLocalizations.of(context)!.text_hint_upload_photo,
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
                                                  textAlignVertical: TextAlignVertical.center,
                                                  obscureText: !_passwordVisible!,
                                                  validator: InputValidator(ch: AppLocalizations.of(context)!.text_password).passwordChecking,
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
                                                /*Row(
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
                                                )*/
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(top: 20.5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(AppLocalizations.of(context)!.text_confirm_password,
                                                  style: Styles.textLabelTitle,
                                                ),
                                                TextFormField(
                                                  textAlignVertical: TextAlignVertical.center,
                                                  obscureText: !_confirmPasswordVisible!,
                                                  validator:
                                                  InputValidator(ch: AppLocalizations.of(context)!.text_password).passwordChecking,
                                                  controller: _confirmPwdController,
                                                  focusNode: _confirmPswdFocusNode,
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
                                                          _confirmPasswordVisible!
                                                              ? Icons.visibility
                                                              : Icons.visibility_off,
                                                          color: Colors.grey,
                                                        ),
                                                        onPressed: () {
                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                          setState(() {
                                                            _confirmPasswordVisible = !_confirmPasswordVisible!;
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
                                                /*Row(
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
                                                )*/
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

                                                  /*if(formValidate()){
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    checkPassWord(
                                                        _passwordController.text,
                                                        _confirmPwdController.text);
                                                  }else{
                                                    print("_formKey.currentState!.validate() - else");
                                                  }*/

                                                  if (_formKey.currentState!.validate()) {
                                                    print("_formKey.currentState!.validate()");

                                                    _checkInternet.check().then((intenet) {
                                                      if (intenet != null && intenet) {

                                                        // Internet Present Case
                                                        print('internet connection - true');
                                                        widget.userCategory == TextStrings.user_category_individual
                                                            && widget.userType == TextStrings.user_customer
                                                            ? signUpCustomerIndividual()
                                                            :  widget.userCategory == TextStrings.user_category_individual
                                                            && widget.userType == TextStrings.user_mechanic
                                                            ? signUpMechanicIndividual()
                                                            : widget.userCategory == TextStrings.user_category_corporate
                                                            && widget.userType == TextStrings.user_customer
                                                            ? signUpCustomerCorporate()
                                                            : widget.userCategory == TextStrings.user_category_corporate
                                                            && widget.userType == TextStrings.user_mechanic
                                                            ? signUpMechanicCorporate()
                                                            : signUpCustomerGovernment();
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                      } else {
                                                        print('No internet connection');

                                                      }
                                                    });
                                                  } else {
                                                    print("_formKey.currentState!.validate() - else");
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
                                                        AppLocalizations.of(context)!.text_sign_up,
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
                                                    text: AppLocalizations.of(context)!.text_already_have_account,
                                                    style: Styles.textLabelSubTitle,
                                                  ),
                                                  TextSpan(
                                                      text: AppLocalizations.of(context)!.text_sign_in,
                                                      style: Styles.textLabelTitle_10,
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
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
                          ),
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
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectStateScreen(),
        ));
    setState(() {
      selectedState = result;
      _stateController.text = selectedState;
      print ("Selected state @ sign up: " + selectedState );
    });
  }

  bool validateSignUpCustomerIndividual(){
    print("validateSignUpCustomerIndividual");
    if(_nameController.text.isEmpty){
      errorMsg = "Name cannot Empty";
      return false;
    }else if(_phoneController.text.isEmpty){
      errorMsg = "Phone Number cannot Empty";
      return false;
    }else if(_emailController.text.isEmpty){
      errorMsg = "Email cannot Empty";
      return false;
    }else if(_stateController.text.isEmpty){
      errorMsg = "Select State";
      return false;
    }
    /*else if(_photoController.text.isEmpty){
      errorMsg = "Select Photo";
      return false;
    }*/
    else if(_passwordController.text.isEmpty){
      errorMsg = "Fill Password";
      return false;
    }else if(_confirmPwdController.text.isEmpty){
      errorMsg = "Enter Confirm Password";
      return false;
    }else if(_passwordController.text.toString() != _confirmPwdController.text.toString()) {
      errorMsg = "Passwords are different!";
      setState(() {
        _passwordController.text = " ";
        _confirmPwdController.text = " ";
      });
      return false;
    }
    else{
      return true;
    }

  }

  void signUpCustomerIndividual(){
    print("signUpCustomerIndividual - loaded");
    if(validateSignUpCustomerIndividual()){
      print("signUpCustomerIndividual");
      print(" Name : " + _nameController.text +
          "\n Email : "+ _emailController.text +
          "\n phone : "+ _photoController.text +
          "\n State : " +
          "\n photo path :" +
          "\n password : " + _passwordController.text+
          "\n c password " + _confirmPwdController.text
      );
      _signupBloc.postSignUpRequest(
          " "," "," ",
          _emailController.text,
          _phoneController.text,
          _passwordController.text);

    }else{
      print("signUpCustomerIndividual - else");
      SnackBarWidget().setSnackBar(errorMsg, context);
    }
  }

  bool validateSignUpMechanicIndividual(){
    print("validateSignUpCustomerIndividual");
    if(_nameController.text.isEmpty){
      errorMsg = "Name cannot Empty";
      return false;
    }else if(_phoneController.text.isEmpty){
      errorMsg = "Phone Number cannot Empty";
      return false;
    }else if(_emailController.text.isEmpty){
      errorMsg = "Email cannot Empty";
      return false;
    }else if(_stateController.text.isEmpty){
      errorMsg = "Select State";
      return false;
    }
    else if(_yearOfExperienceController.text.isEmpty){
      errorMsg = "Enter Year of Experience";
      return false;
    }
    /*else if(_photoController.text.isEmpty){
      errorMsg = "Select Photo";
      return false;
    }*/
    else if(_passwordController.text.isEmpty){
      errorMsg = "Fill Password";
      return false;
    }else if(_confirmPwdController.text.isEmpty){
      errorMsg = "Enter Confirm Password";
      return false;
    }else if(_passwordController.text.toString() != _confirmPwdController.text.toString()) {
      errorMsg = "Passwords are different!";
      setState(() {
        _passwordController.text = " ";
        _confirmPwdController.text = " ";
      });
      return false;
    }
    else{
      return true;
    }
  }

  void signUpMechanicIndividual(){
    print("signUpMechanicIndividual - loaded");
    if(validateSignUpMechanicIndividual()){
      print("signUpMechanicIndividual");
      print(" Name : " + _nameController.text +
          "\n Email : "+ _emailController.text +
          "\n phone : "+ _photoController.text +
          "\n State : " +
          "\n photo path :" +
          "\n password : " + _passwordController.text+
          "\n c password " + _confirmPwdController.text
      );
      _signupBloc.postSignUpRequest(
          " "," "," ",
          _emailController.text,
          _phoneController.text,
          _passwordController.text);

    }else{
      print("signUpMechanicIndividual - else");
      SnackBarWidget().setSnackBar(errorMsg, context);
    }
  }

  void signUpCustomerCorporate(){
    print("signUpCustomerCorporate");
  }

  void signUpMechanicCorporate(){
    print("signUpMechanicCorporate");
  }

  void signUpCustomerGovernment(){
    print("signUpCustomerGovernment");
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

  _showDialogSelectPhoto() async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
              height: 115.0,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: CustColors.blue,
                    ),
                    title: Text("Camera",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 30);

                      setState(() {
                        if (image != null) {
                          _images = File(image.path);
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.image,
                      color: CustColors.blue,
                    ),
                    title: Text("Gallery",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image = (await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 30));

                      setState(() {
                        if (image != null) {
                          _images = (File(image.path));
                          _photoController.text = image.path;
                        }
                      });
                    },
                  ),
                ],
              ));
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
