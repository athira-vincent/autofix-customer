import 'dart:convert';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignIn/signin_screen.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen1/signup_registration_bloc.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/work_selection_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicSignupRegistrationScreen extends StatefulWidget {
  const MechanicSignupRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicSignupRegistrationScreenState();
  }
}

class _MechanicSignupRegistrationScreenState
    extends State<MechanicSignupRegistrationScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _walletIdController = TextEditingController();
  TextEditingController _walletTypeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  //TextEditingController _stateController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _walletIdFocusNode = FocusNode();
  FocusNode _walletTypeFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  //FocusNode _stateFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final MechanicSignupRegistrationBloc _signupBloc =
      MechanicSignupRegistrationBloc();
  List<String> _walletTypeList = ['National ID Card','Driving License', 'Voter’s card',
     'Passport','Certificate of Origin','Refugee ID card',];
  bool _isLoading = false;
  //bool isloading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getSignUpRes();
  }

  _setSignUpVisitFlag() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _shdPre.setBool(SharedPrefKeys.isMechanicSignUp, true);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _walletTypeController.dispose();
    _walletIdController.dispose();
    _emailController.dispose();
    //_stateController.dispose();
    _passwordController.dispose();
    _confirmPwdController.dispose();
    _phoneController.dispose();
    _signupBloc.dispose();
    _addressController.dispose();
  }

  _getSignUpRes() {
    _signupBloc.postSignUp.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("errrrorr 02");
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
        setState(() async {
          print("errrrorr 01");
          _isLoading = false;
          SharedPreferences shdPre = await SharedPreferences.getInstance();

          shdPre.setString(SharedPrefKeys.token, value.data!.mechanicSignUp!.token!);
          shdPre.setInt(SharedPrefKeys.mechanicSignUpStatus, value.data!.mechanicSignUp!.mechanicSignUpData!.verified!);

          /*shdPre.setString(SharedPrefKeys.userProfilePic,
              value.data!.customerSignUp!.customer!.profilePic.toString());
          shdPre.setInt(SharedPrefKeys.isDefaultVehicleAvailable,
              value.data!.customerSignUp!.customer!.isProfileCompleted!);
          shdPre.setString(
              SharedPrefKeys.userName,
              value.data!.customerSignUp!.customer!.firstName.toString() +
                  " " +
                  value.data!.customerSignUp!.customer!.lastName.toString());
          shdPre.setString(SharedPrefKeys.userEmail,
              value.data!.customerSignUp!.customer!.emailId.toString());
          shdPre.setInt(SharedPrefKeys.userID,
              int.parse(value.data!.customerSignUp!.customer!.id!));*/

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
          /*if (value.data!.customerSignUp!.customer!.isProfileCompleted! == 2) {
            setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            FocusScope.of(context).unfocus();
          } else {
            //setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()));
          }*/
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const LoginScreen()));
          //FocusScope.of(context).unfocus();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustColors.blue,
        body: Theme(
          data: ThemeData(
            disabledColor: Colors.white,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Container(
                // height: double.infinity,
                child: Form(
                  autovalidateMode: _autoValidate,
                  key: _formKey,
                  // child: ConstrainedBox(
                  //   constraints: BoxConstraints.tightFor(
                  //       height: MediaQuery.of(context).size.height),
                  child: IntrinsicHeight(
                    child: Container(
                      color: CustColors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(26),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenSize().setValueFont(19.5),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Corbel_Bold'),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(17),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenSize().setValueFont(13),
                              ),
                              focusNode: _firstNameFocusNode,
                              keyboardType: TextInputType.text,
                              validator:
                                  InputValidator(ch: "Name").nameChecking,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z ]')),
                              ],
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Name',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color: Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        validator: InputValidator(ch: "Address")
                                            .emptyChecking,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(40),
                                        ],
                                        //minLines: 3,
                                        //maxLines: 3,
                                        focusNode: _addressFocusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType:
                                            TextInputType.multiline,
                                        controller: _addressController,
                                        style: TextStyle(
                                          fontFamily: 'Corbel_Light',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize:
                                              ScreenSize().setValueFont(13),
                                        ),
                                        enableSuggestions: false,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: 'Address',
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .3,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .3,
                                              ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .3,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenSize().setValue(7.8),
                                            ),
                                            hintStyle: TextStyle(
                                              fontFamily: 'Corbel_Light',
                                              color:
                                                  Colors.white.withOpacity(.60),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  ScreenSize().setValueFont(12),
                                            )),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              onTap: () {
                                showWalletTypeSelector();
                              },
                              readOnly: true,
                              autofocus: false,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(13),
                              ),
                              focusNode: _walletTypeFocusNode,
                              keyboardType: TextInputType.text,
                              validator:
                              InputValidator(ch: "Document Type").emptyChecking,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z]')),
                              ],
                              controller: _walletTypeController,
                              decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  isDense: true,
                                  hintText: 'Document Type',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color: Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34),
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenSize().setValueFont(13),
                              ),
                              focusNode: _walletIdFocusNode,
                              keyboardType: TextInputType.text,
                              validator:
                                  InputValidator(ch: "Wallet Id").emptyChecking,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[A-Za-z0-9]')),
                              ],
                              controller: _walletIdController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Wallet Id*',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color: Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        validator:
                                            InputValidator(ch: "Phone number")
                                                .phoneNumChecking,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(15),
                                        ],
                                        maxLines: 1,
                                        focusNode: _phoneFocusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.phone,
                                        controller: _phoneController,
                                        style: TextStyle(
                                          fontFamily: 'Corbel_Light',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize:
                                              ScreenSize().setValueFont(13),
                                        ),
                                        enableSuggestions: false,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: 'Phone Number*',
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .3,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .3,
                                              ),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .3,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical:
                                                  ScreenSize().setValue(7.8),
                                            ),
                                            hintStyle: TextStyle(
                                              fontFamily: 'Corbel_Light',
                                              color:
                                                  Colors.white.withOpacity(.60),
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  ScreenSize().setValueFont(12),
                                            )),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.emailAddress,
                              validator:
                                  InputValidator(ch: "Email ID").emailValidator,
                              focusNode: _emailFocusNode,
                              controller: _emailController,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(13),
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Email ID*',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color: Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: true,
                              validator: InputValidator(ch: "Password")
                                  .passwordChecking,
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(13),
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Password*',
                                  errorMaxLines: 3,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color: Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: TextFormField(
                              obscureText: true,
                              validator: InputValidator(ch: "Confirm Password")
                                  .passwordChecking,
                              maxLines: 1,
                              controller: _confirmPwdController,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(13),
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Confirm Password*',
                                  errorMaxLines: 3,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color: Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),
                          Container(
                            height: ScreenSize().setValue(28),
                            width: ScreenSize().setValue(98),
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(25),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: _isLoading
                                ? Center(
                                    child: Container(
                                      height: ScreenSize().setValue(28),
                                      width: ScreenSize().setValue(28),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                CustColors.peaGreen),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: CustColors.darkBlue,
                                          blurRadius: 5,
                                          offset: Offset(0, 3.3),
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MechanicWorkSelectionScreen()));
                                          checkPassWord(
                                              _passwordController.text,
                                              _confirmPwdController.text);
                                        } else {
                                          setState(() => _autoValidate =
                                              AutovalidateMode.always);
                                        }
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Sign up',
                                              style: TextStyle(
                                                color: CustColors.blue,
                                                fontFamily: 'Corbel_Regular',
                                                fontWeight: FontWeight.w600,
                                                fontSize: ScreenSize()
                                                    .setValueFont(11.5),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left:
                                                    ScreenSize().setValue(16.6),
                                              ),
                                              child: Image.asset(
                                                'assets/images/arrow_forword.png',
                                                width:
                                                    ScreenSize().setValue(12.5),
                                                height:
                                                    ScreenSize().setValue(12.5),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              ScreenSize().setValue(16))),
                                    ),
                                  ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MechanicSigninScreen()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: ScreenSize().setValue(21.3),
                                left: ScreenSize().setValue(36),
                              ),
                              child: Text(
                                'Already have an account ? Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenSize().setValueFont(11.5),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Corbel_Light'),
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  //margin: EdgeInsets.only(top: 40),
                                  alignment: Alignment.topCenter,

                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/signup_arc.png',
                                        fit: BoxFit.fitHeight,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topCenter,
                                    margin: EdgeInsets.only(
                                        left: ScreenSize().setValue(66),
                                        top: ScreenSize().setValue(119.6),
                                        right: ScreenSize().setValue(78)),
                                    child: Image.asset(
                                      'assets/images/autofix_logo.png',
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkPassWord(String pwds, String cndpwd) {
    if (pwds != cndpwd) {
      //toastMsg.toastMsg(msg: "Passwords are different!");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords are different!",
            style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
        duration: Duration(seconds: 2),
        backgroundColor: CustColors.peaGreen,
      ));
      setState(() {
        _passwordController.text = "";
        _confirmPwdController.text = "";
      });
    } else {

      var walletData = {};
      walletData["docType"] = _walletTypeController.text;
      walletData["docId"] = _walletIdController.text;
      String strWalletData = json.encode(walletData);

      print("firstNameController.text : " + _firstNameController.text +
          "emailController.text : " + _emailController.text +
          "phoneController.text : " + _phoneController.text +
          "address : " + _addressController.text +
          "passwordController.text : " + _passwordController.text +
          "Wallet Data : " +strWalletData
      );

      _signupBloc.postSignUpRequest(
          _firstNameController.text,
          _emailController.text,
          _phoneController.text,
          _addressController.text,
          10.397118,
          76.140387,
          //_walletIdController.text,
          strWalletData,
          _passwordController.text);
      setState(() {
        _isLoading = true;
      });
    }
  }
  void showWalletTypeSelector() {
    //_signupBloc.searchStates("");
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setType) {
            return BottomSheet(
                onClosing: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      height: 300,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: double.maxFinite,
                              child: Column(children: [
                                /*Container(
                                  height: ScreenSize().setValue(36.3),
                                  margin: EdgeInsets.only(
                                      left: ScreenSize().setValue(41.3),
                                      right: ScreenSize().setValue(41.3),
                                      top: ScreenSize().setValue(20.3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        ScreenSize().setValue(20),
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
                                ),*/
                                Container(
                                  height: 350 - 108,
                                  padding:
                                  EdgeInsets.only(top: ScreenSize().setValue(22.4)),
                                  child: _walletTypeList.length != 0
                                      ? ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _walletTypeList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            final walletType =
                                                _walletTypeList[index].toString();

                                            setState(() {
                                              _walletTypeController.text =
                                                  walletType.toString();
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: ScreenSize().setValue(41.3),
                                              right: ScreenSize().setValue(41.3),
                                            ),
                                            child: Text(
                                              '${_walletTypeList[index].toString()}',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenSize().setValueFont(12),
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
                                              top: ScreenSize().setValue(12.7),
                                              left: ScreenSize().setValue(41.3),
                                              right: ScreenSize().setValue(41.3),
                                              bottom: ScreenSize().setValue(12.9)),
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
                         /* Center(
                            child: isloading
                                ? CircularProgressIndicator()
                                : Text(''),
                          )*/
                        ],
                      ),
                    ),
                  );
                });
          });
        });
  }
}
