import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SigninScreenState();
  }
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  late TextStyle labelStyleUserName;
  @override
  void initState() {
    super.initState();
    userNameController.addListener(onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    userNameFocusNode.removeListener(onFocusChange);
  }

  void onFocusChange() {
    setState(() {
      labelStyleUserName = userNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [],
      ),
    );
  }
}
