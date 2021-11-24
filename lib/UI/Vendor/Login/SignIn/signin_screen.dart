import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Vendor/Home/home_screen.dart';
import 'package:auto_fix/UI/Vendor/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/Vendor/Login/SignIn/signin_bloc.dart';
import 'package:auto_fix/UI/Vendor/Login/SignUp/signup_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VendorSigninScreen extends StatefulWidget {
  const VendorSigninScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VendorSigninScreenState();
  }
}

class _VendorSigninScreenState extends State<VendorSigninScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final VendorSigninBloc _signinBloc = VendorSigninBloc();
  bool _isLoading = false;
  bool? _passwordVisible;
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
    _signinBloc.postSignIn.listen((value) {
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
        _signinBloc.userDefault(value.data!.token.toString());
        setState(() {
          _isLoading = false;
          //toastMsg.toastMsg(msg: "Successfully Signed In");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Signed In",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const VendorHomeScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
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
                    margin: EdgeInsets.only(left: 37.5, right: 37.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 160),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.5,
                                fontFamily: 'Montserrat_SemiBold'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.5),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Montserrat_Semibond',
                              color: Colors.white,
                              fontSize: 13,
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
                                prefixIcon: Container(
                                  width: 5,
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset(
                                      'assets/images/username.png',
                                    ),
                                  ),
                                ),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 25,
                                  minHeight: 25,
                                ),
                                labelText: 'User Name',
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
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat_Light',
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 32.5),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: !_passwordVisible!,
                            validator:
                                InputValidator(ch: "Password").passwordChecking,
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Montserrat_Semibond',
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
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
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    iconSize: 15,
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
                                labelText: 'Password',
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
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat_Light',
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ),
                        ),
                        Container(
                          height: 28,
                          width: 96,
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
                                              fontFamily: 'Montserrat_SemiBold',
                                              fontSize: 11.5,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 16.6,
                                            ),
                                            child: Image.asset(
                                              'assets/images/arrow_forword.png',
                                              width: 12.5,
                                              height: 12.5,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                            VendorForgotPasswordScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 22),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Montserrat_Light'),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VendorSignupScreen()));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 22),
                                child: Text(
                                  'New user ? Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.5,
                                      fontFamily: 'Montserrat_SemiBold'),
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
                      height: 225,
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/images/arc_left.png',
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/images/arc_right.png',
                            width: 336)),
                    Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.bottomLeft,
                        margin:
                            EdgeInsets.only(left: 66, bottom: 26.5, right: 78),
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
}
