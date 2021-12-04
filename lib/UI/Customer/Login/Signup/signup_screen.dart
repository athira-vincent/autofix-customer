import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/add_vehicle_screen.dart';
import 'package:auto_fix/UI/Customer/Home/home_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/states_mdl.dart';
import 'package:auto_fix/UI/Customer/Login/login_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
    _getSignUpRes();
    _signupBloc.dialStatesListRequest();
    _populateCountryList();
    _setSignUpVisitFlag();
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
          shdPre.setString(SharedPrefKeys.userProfilePic,
              value.data!.customerSignUp!.customer!.profilePic.toString());
          shdPre.setInt(SharedPrefKeys.isDefaultVehicleAvailable,
              value.data!.customerSignUp!.customer!.isProfileCompleted!);
          shdPre.setString(
              SharedPrefKeys.token, value.data!.customerSignUp!.token!);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
          if (value.data!.customerSignUp!.customer!.isProfileCompleted! == 2) {
            setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            FocusScope.of(context).unfocus();
          } else {
            //setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()));
          }
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const LoginScreen()));
          // FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void setIsSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isUserLoggedIn, true);
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
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Form(
                autovalidateMode: _autoValidate,
                key: _formKey,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height + 1000,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(26),
                                  left: _setValue(34),
                                  right: _setValue(34)),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _setValueFont(19.5),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Corbel_Bold'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(17),
                                  left: _setValue(34),
                                  right: _setValue(34)),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: _setValueFont(13),
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
                                      vertical: _setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      color: Colors.white.withOpacity(.60),
                                      fontWeight: FontWeight.w600,
                                      fontSize: _setValueFont(12),
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: _setValue(20),
                                left: _setValue(34),
                                right: _setValue(34),
                              ),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: _setValueFont(13),
                                ),
                                focusNode: _userNameFocusNode,
                                keyboardType: TextInputType.text,
                                validator: InputValidator(ch: "User name")
                                    .emptyChecking,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-z0-9]')),
                                ],
                                controller: _userNameController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'User Name',
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
                                      vertical: _setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      color: Colors.white.withOpacity(.60),
                                      fontWeight: FontWeight.w600,
                                      fontSize: _setValueFont(12),
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(20),
                                  left: _setValue(34),
                                  right: _setValue(34)),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.emailAddress,
                                validator: InputValidator(ch: "Email ID")
                                    .emailValidator,
                                focusNode: _emailFocusNode,
                                controller: _emailController,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: _setValueFont(13),
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
                                      vertical: _setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      color: Colors.white.withOpacity(.60),
                                      fontWeight: FontWeight.w600,
                                      fontSize: _setValueFont(12),
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(20),
                                  left: _setValue(34),
                                  right: _setValue(34)),
                              child: InkWell(
                                onTap: () {
                                  showDialCodeSelector();
                                },
                                child: Container(
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    enabled: false,
                                    style: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: _setValueFont(13),
                                    ),
                                    focusNode: _stateFocusNode,
                                    keyboardType: TextInputType.text,
                                    validator: InputValidator(ch: "State")
                                        .emptyChecking,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]')),
                                    ],
                                    controller: _stateController,
                                    decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: .3,
                                          ),
                                        ),
                                        isDense: true,
                                        hintText: 'State',
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
                                          vertical: _setValue(7.8),
                                        ),
                                        hintStyle: TextStyle(
                                          fontFamily: 'Corbel_Light',
                                          color: Colors.white.withOpacity(.60),
                                          fontWeight: FontWeight.w600,
                                          fontSize: _setValueFont(12),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(20),
                                  left: _setValue(34),
                                  right: _setValue(34)),
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
                                            fontSize: _setValueFont(13),
                                          ),
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText: 'Phone Number*',
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: .3,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: .3,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: .3,
                                                ),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: _setValue(7.8),
                                              ),
                                              hintStyle: TextStyle(
                                                fontFamily: 'Corbel_Light',
                                                color: Colors.white
                                                    .withOpacity(.60),
                                                fontWeight: FontWeight.w600,
                                                fontSize: _setValueFont(12),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(20),
                                  left: _setValue(34),
                                  right: _setValue(34)),
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
                                  fontSize: _setValueFont(13),
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
                                      vertical: _setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      color: Colors.white.withOpacity(.60),
                                      fontWeight: FontWeight.w600,
                                      fontSize: _setValueFont(12),
                                    )),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: _setValue(20),
                                  left: _setValue(34),
                                  right: _setValue(34)),
                              child: TextFormField(
                                obscureText: true,
                                validator:
                                    InputValidator(ch: "Confirm Password")
                                        .passwordChecking,
                                maxLines: 1,
                                controller: _confirmPwdController,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: _setValueFont(13),
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
                                      vertical: _setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      color: Colors.white.withOpacity(.60),
                                      fontWeight: FontWeight.w600,
                                      fontSize: _setValueFont(12),
                                    )),
                              ),
                            ),
                            Container(
                              height: _setValue(28),
                              width: _setValue(98),
                              margin: EdgeInsets.only(
                                  top: _setValue(25),
                                  left: _setValue(34),
                                  right: _setValue(34)),
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                CustColors.peaGreen),
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
                                          if (_formKey.currentState!
                                              .validate()) {
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
                                                  fontSize: _setValueFont(11.5),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: _setValue(16.6),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/arrow_forword.png',
                                                  width: _setValue(12.5),
                                                  height: _setValue(12.5),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                _setValue(16))),
                                      ),
                                    ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: _setValue(21.3),
                                  left: _setValue(36),
                                ),
                                child: Text(
                                  'Already have an account ? Sign in',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _setValueFont(11.5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Corbel_Light'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  //margin: EdgeInsets.only(top: 40),
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    'assets/images/signup_arc.png',
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.bottomLeft,
                                    margin: EdgeInsets.only(
                                        left: _setValue(66),
                                        bottom: _setValue(24.5),
                                        right: _setValue(78)),
                                    child: Image.asset(
                                      'assets/images/autofix_logo.png',
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
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
            style: TextStyle(
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.w600,
                fontSize: 14)),
        duration: Duration(seconds: 2),
        backgroundColor: CustColors.peaGreen,
      ));
      setState(() {
        _passwordController.text = "";
        _confirmPwdController.text = "";
      });
    } else {
      _signupBloc.postSignUpRequest(
          _firstNameController.text,
          _userNameController.text,
          _emailController.text,
          _stateController.text,
          _passwordController.text,
          _phoneController.text);
      setState(() {
        _isLoading = true;
      });
    }
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
