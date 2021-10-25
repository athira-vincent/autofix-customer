import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Home/home_screen.dart';
import 'package:auto_fix/UI/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SigninScreenState();
  }
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextStyle labelStyleUserName = const TextStyle();
  TextStyle labelStylePassword = const TextStyle();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SigninBloc _signinBloc = SigninBloc();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    userNameController.addListener(onFocusChange);
    passwordController.addListener(onFocusChange);
    _getSignInRes();
  }

  @override
  void dispose() {
    super.dispose();
    userNameFocusNode.removeListener(onFocusChange);
    userNameController.dispose();
    passwordFocusNode.removeListener(onFocusChange);
    passwordController.dispose();
    _signinBloc.dispose();
  }

  void onFocusChange() {
    setState(() {
      labelStyleUserName = userNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      labelStylePassword = passwordFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  _getSignInRes() async {
    _signinBloc.postSignIn.listen((value) {
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
        // _signinBloc.userDefault(value.data.agentSignIn.token);
        setState(() {
          isLoading = false;
          //toastMsg.toastMsg(msg: "Successfully Signed In");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Signed In",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 28, right: 28, top: 15),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustColors.peaGreen),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _signinBloc.postSignInRequest(
                              userNameController.text, passwordController.text);
                        } else {
                          setState(
                              () => _autoValidate = AutovalidateMode.always);
                        }
                      },
                      child: const Text(
                        'SIGN IN',
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen()));
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
