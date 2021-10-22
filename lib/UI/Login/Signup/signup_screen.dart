import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/Login/login_screen.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPwdFocusNode = FocusNode();
  TextStyle labelStyleFirstName = const TextStyle();
  TextStyle labelStyleUserName = const TextStyle();
  TextStyle labelStyleEmail = const TextStyle();
  TextStyle labelStyleState = const TextStyle();
  TextStyle labelStylePassword = const TextStyle();
  TextStyle labelStyleConfirmPwd = const TextStyle();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SignupBloc _signupBloc = SignupBloc();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    firstNameController.addListener(onFocusChange);
    userNameController.addListener(onFocusChange);
    emailController.addListener(onFocusChange);
    stateController.addListener(onFocusChange);
    passwordController.addListener(onFocusChange);
    confirmPwdController.addListener(onFocusChange);
    _getSignUpRes();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameFocusNode.removeListener(onFocusChange);
    firstNameController.dispose();
    userNameFocusNode.removeListener(onFocusChange);
    userNameController.dispose();
    emailFocusNode.removeListener(onFocusChange);
    emailController.dispose();
    stateFocusNode.removeListener(onFocusChange);
    stateController.dispose();
    passwordFocusNode.removeListener(onFocusChange);
    passwordController.dispose();
    confirmPwdFocusNode.removeListener(onFocusChange);
    confirmPwdController.dispose();
    _signupBloc.dispose();
  }

  _getSignUpRes() {
    _signupBloc.postSignUp.listen((value) {
      if (value.status == "error") {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message,
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          isLoading = false;
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
      labelStyleFirstName = firstNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      labelStyleUserName = userNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      labelStyleEmail = emailFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      labelStyleState = stateFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      labelStylePassword = passwordFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      labelStyleConfirmPwd = confirmPwdFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: _autoValidate,
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto_Regular',
                  ),
                  focusNode: firstNameFocusNode,
                  keyboardType: TextInputType.text,
                  validator: InputValidator(ch: "First name").nameChecking,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  controller: firstNameController,
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.peaGreen,
                          width: 0.3,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto_Regular',
                        color: Color.fromARGB(52, 3, 43, 80),
                        fontSize: 14,
                      ),
                      labelStyle: labelStyleFirstName),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto_Regular',
                  ),
                  focusNode: userNameFocusNode,
                  keyboardType: TextInputType.text,
                  validator: InputValidator(ch: "User name").emptyChecking,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  controller: userNameController,
                  decoration: InputDecoration(
                      labelText: 'User Name',
                      hintText: 'User Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.peaGreen,
                          width: 0.3,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto_Regular',
                        color: Color.fromARGB(52, 3, 43, 80),
                        fontSize: 14,
                      ),
                      labelStyle: labelStyleUserName),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 19.3),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  validator: InputValidator(ch: "Email ID").emailValidator,
                  focusNode: emailFocusNode,
                  controller: emailController,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto_Regular',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email ID',
                    labelText: 'Email ID*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide: const BorderSide(
                        color: CustColors.borderColor,
                        width: 0.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide: const BorderSide(
                        color: CustColors.peaGreen,
                        width: 0.3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide: const BorderSide(
                        color: CustColors.borderColor,
                        width: 0.3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    labelStyle: labelStyleEmail,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto_Regular',
                  ),
                  focusNode: stateFocusNode,
                  keyboardType: TextInputType.text,
                  validator: InputValidator(ch: "State").emptyChecking,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  controller: stateController,
                  decoration: InputDecoration(
                      labelText: 'State',
                      hintText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.peaGreen,
                          width: 0.3,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto_Regular',
                        color: Color.fromARGB(52, 3, 43, 80),
                        fontSize: 14,
                      ),
                      labelStyle: labelStyleState),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  validator: InputValidator(ch: "Password").passwordChecking,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto_Regular',
                  ),
                  decoration: InputDecoration(
                      labelText: 'Password*',
                      hintText: 'Password',
                      errorMaxLines: 3,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.peaGreen,
                          width: 0.3,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.5),
                        borderSide: const BorderSide(
                          color: CustColors.borderColor,
                          width: 0.3,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto_Regular',
                        color: Color.fromARGB(52, 3, 43, 80),
                        fontSize: 14,
                      ),
                      labelStyle: labelStylePassword),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  obscureText: true,
                  validator:
                      InputValidator(ch: "Confirm Password").passwordChecking,
                  maxLines: 1,
                  controller: confirmPwdController,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto_Regular',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password*',
                    hintText: 'Confirm Password',
                    errorMaxLines: 3,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide: const BorderSide(
                        color: CustColors.borderColor,
                        width: 0.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide: const BorderSide(
                        color: CustColors.peaGreen,
                        width: 0.3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide: const BorderSide(
                        color: CustColors.borderColor,
                        width: 0.3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: 'Roboto_Regular',
                      color: Color.fromARGB(52, 3, 43, 80),
                      fontSize: 14,
                    ),
                    labelStyle: labelStyleConfirmPwd,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 28, right: 28, top: 15),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustColors.peaGreen),
                        ),
                      )
                    : MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            checkPassWord(passwordController.text,
                                confirmPwdController.text);
                          } else {
                            setState(
                                () => _autoValidate = AutovalidateMode.always);
                          }
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto_Bold',
                            fontSize: 14,
                          ),
                        ),
                        color: CustColors.peaGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.5)),
                      ),
              ),
            ],
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
        passwordController.text = "";
        confirmPwdController.text = "";
      });
    } else {
      _signupBloc.postSignUpRequest(
          firstNameController.text,
          userNameController.text,
          emailController.text,
          stateController.text,
          passwordController.text);
      setState(() {
        isLoading = true;
      });
    }
  }
}
