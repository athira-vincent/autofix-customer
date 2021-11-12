import 'package:auto_fix/Constants/cust_colors.dart';
<<<<<<< HEAD:lib/UI/Login/Signup/signup_screen.dart
import 'package:auto_fix/UI/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/Login/login_screen.dart';
=======
import 'package:auto_fix/UI/Customer/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/Customer/Login/login_screen.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Login/Signup/signup_screen.dart
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  FocusNode _confirmPwdFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  TextStyle _labelStyleFirstName = const TextStyle();
  TextStyle _labelStyleUserName = const TextStyle();
  TextStyle _labelStyleEmail = const TextStyle();
  TextStyle _labelStyleState = const TextStyle();
  TextStyle _labelStylePassword = const TextStyle();
  TextStyle _labelStyleConfirmPwd = const TextStyle();
  TextStyle _labelStylePhone = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SignupBloc _signupBloc = SignupBloc();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(onFocusChange);
    _userNameController.addListener(onFocusChange);
    _emailController.addListener(onFocusChange);
    _stateController.addListener(onFocusChange);
    _passwordController.addListener(onFocusChange);
    _confirmPwdController.addListener(onFocusChange);
    _phoneController.addListener(onFocusChange);
    _getSignUpRes();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameFocusNode.removeListener(onFocusChange);
    _firstNameController.dispose();
    _userNameFocusNode.removeListener(onFocusChange);
    _userNameController.dispose();
    _emailFocusNode.removeListener(onFocusChange);
    _emailController.dispose();
    _stateFocusNode.removeListener(onFocusChange);
    _stateController.dispose();
    _passwordFocusNode.removeListener(onFocusChange);
    _passwordController.dispose();
    _confirmPwdFocusNode.removeListener(onFocusChange);
    _confirmPwdController.dispose();
    _phoneFocusNode.removeListener(onFocusChange);
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
        setState(() {
          print("errrrorr 01");
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
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
      _labelStyleFirstName = _firstNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleUserName = _userNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleEmail = _emailFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleState = _stateFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStylePassword = _passwordFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleConfirmPwd = _confirmPwdFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStylePhone = _phoneFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: _autoValidate,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 26, left: 34, right: 34),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.5,
                        fontFamily: 'Montserrat_SemiBold'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 17, left: 34, right: 34),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Montserrat_Semibond',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    focusNode: _firstNameFocusNode,
                    keyboardType: TextInputType.text,
                    validator: InputValidator(ch: "Name").nameChecking,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    ],
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat_Light',
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 34,
                    right: 34,
                  ),
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
                    validator: InputValidator(ch: "User name").emptyChecking,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    ],
                    controller: _userNameController,
                    decoration: InputDecoration(
                        labelText: 'User Name',
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat_Light',
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.emailAddress,
                    validator: InputValidator(ch: "Email ID").emailValidator,
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Montserrat_Semibond',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Email ID*',
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat_Light',
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Montserrat_Semibond',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    focusNode: _stateFocusNode,
                    keyboardType: TextInputType.text,
                    validator: InputValidator(ch: "State").emptyChecking,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    ],
                    controller: _stateController,
                    decoration: InputDecoration(
                        labelText: 'State',
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat_Light',
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 34, right: 34),
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
                              validator: InputValidator(ch: "Phone number")
                                  .phoneNumChecking,
                              maxLines: 1,
                              focusNode: _phoneFocusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              style: TextStyle(
                                fontFamily: 'Montserrat_Semibond',
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              decoration: InputDecoration(
                                  labelText: 'Phone Number*',
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
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 7.8,
                                  ),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat_Light',
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                            ),
                          ),
                        ),
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: true,
                    validator: InputValidator(ch: "Password").passwordChecking,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Montserrat_Semibond',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Password*',
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat_Light',
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                  child: TextFormField(
                    obscureText: true,
                    validator:
                        InputValidator(ch: "Confirm Password").passwordChecking,
                    maxLines: 1,
                    controller: _confirmPwdController,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat_Semibond',
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Confirm Password*',
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
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
                  width: 108,
                  margin: const EdgeInsets.only(top: 25, left: 34, right: 34),
                  child: _isLoading
                      ? const Center(
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
                                checkPassWord(_passwordController.text,
                                    _confirmPwdController.text);
                              } else {
                                setState(() =>
                                    _autoValidate = AutovalidateMode.always);
                              }
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Sign up',
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
                                borderRadius: BorderRadius.circular(16)),
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
                    margin: EdgeInsets.only(top: 19, left: 34, right: 34),
                    child: Text(
                      'Already have an account ? Sign in',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontFamily: 'Montserrat_SemiBold'),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/images/signup_arc.png',
                      ),
                    ),
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
}
