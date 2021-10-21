import 'package:flutter/material.dart';

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
  late TextStyle labelStyleFirstName;
  late TextStyle labelStyleUserName;
  late TextStyle labelStyleEmail;
  late TextStyle labelStyleState;
  late TextStyle labelStylePassword;
  late TextStyle labelStyleConfirmPwd;
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
