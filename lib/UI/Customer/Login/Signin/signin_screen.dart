import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/add_vehicle_screen.dart';
import 'package:auto_fix/UI/Customer/Home/home_screen.dart';
import 'package:auto_fix/UI/Customer/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SigninScreenState();
  }
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SigninBloc _signinBloc = SigninBloc();
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

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _getSignInRes();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _signinBloc.dispose();
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Signed In",
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          if (value.data!.customerSignIn!.customer!.isProfileCompleted! == 2) {
            setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            FocusScope.of(context).unfocus();
          } else {
            //setIsSignedIn();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()));
          }
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
    return Scaffold(
      backgroundColor: CustColors.blue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: CustColors.blue,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  autovalidateMode: _autoValidate,
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: _setValue(37.5), right: _setValue(37.5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: _setValue(160)),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _setValueFont(19.5),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Corbel_Bold'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: _setValue(25.5)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Montserrat_Semibond',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: _setValueFont(13),
                            ),

                            focusNode: _userNameFocusNode,
                            keyboardType: TextInputType.text,
                            validator:
                                InputValidator(ch: "User name").emptyChecking,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                            // ],
                            controller: _userNameController,
                            decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Container(
                                  width: 5,
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Container(
                                      child: Image.asset(
                                        'assets/images/username.png',
                                      ),
                                    ),
                                  ),
                                ),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 25,
                                  minHeight: 25,
                                ),
                                hintText: 'User Name',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 7.8,
                                  horizontal: 20.0,
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(.60),
                                  fontSize: _setValueFont(12),
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 32.5),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: !_passwordVisible!,
                            // validator:
                            //     InputValidator(ch: "Password").passwordChecking,
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Montserrat_Semibond',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: _setValueFont(13),
                            ),
                            decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Container(
                                  width: 5,
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset(
                                      'assets/images/password.png',
                                    ),
                                  ),
                                ),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 25,
                                  minHeight: 25,
                                ),
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
                                      color: Colors.white,
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
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 7.8,
                                  horizontal: 20.0,
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(.60),
                                  fontSize: _setValueFont(12),
                                )),
                          ),
                        ),
                        Container(
                          height: _setValue(28),
                          width: _setValue(96),
                          margin: EdgeInsets.only(top: 31.8),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
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
                                      child: Row(
                                        children: [
                                          Text(
                                            'Login',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: _setValue(22)),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _setValueFont(11.5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Corbel_Light'),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: _setValue(22)),
                                child: Text(
                                  'New user ? Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _setValueFont(11.5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Corbel_Light'),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      width: double.infinity,
                      height: _setValue(225),
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/images/arc_left.png',
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/images/arc_right.png',
                            width: _setValue(336))),
                    Container(
                        width: double.infinity,
                        height: _setValue(60),
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(
                            left: _setValue(66),
                            bottom: _setValue(26.5),
                            right: _setValue(78)),
                        child: Image.asset(
                          'assets/images/autofix_logo.png',
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> isDefaultVehicleAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? _isDefaultVehicleAvailable =
        prefs.getBool(SharedPrefKeys.isUserLoggedIn);
    // prefs.setBool(SharedPrefKeys.isWalked, true);
    return _isDefaultVehicleAvailable;
  }
}
