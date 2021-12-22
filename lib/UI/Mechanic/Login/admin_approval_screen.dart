import 'dart:async';

import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignIn/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminApprovalScreen extends StatefulWidget {
  const AdminApprovalScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminApprovalScreenState();
  }
}

class _AdminApprovalScreenState extends State<AdminApprovalScreen> {

  String referenceId = "";

  @override
  void initState() {
    super.initState();
    _getReferenceId();
    Timer(const Duration(seconds: 3), () {
      //_changeScreen();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MechanicSigninScreen()));
    });
  }

  _getReferenceId() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    referenceId = _shdPre.getString(SharedPrefKeys.mechanicCode)!;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("Your Reference ID is : " + referenceId + "Wait for admin approval",
          style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
