import 'dart:async';

import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:flutter/material.dart';

class WaitAdminApprovalScreen extends StatefulWidget {

  final String refNumber;

  WaitAdminApprovalScreen({required this.refNumber,});

  @override
  State<StatefulWidget> createState() {
    return _WaitAdminApprovalScreenState();
  }
}

class _WaitAdminApprovalScreenState extends State<WaitAdminApprovalScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      _changeScreen();
    });
  }

  Future _changeScreen() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.only(
              left: size.width * 0.140,
              right: size.width * 0.140,
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.335,
                        left: size.width * 0.135,
                        right: size.width * 0.135
                        /*bottom: size.height * 0.455*/),
                    child: Image.asset("assets/image/img_admin_approval.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: size.width * 0.007,
                        right: size.width * 0.007,
                        top: size.height * 0.035),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Successfully  ", style: Styles.textSuccessfulTitleStyle01,),
                        Text("registered!", style: Styles.textSuccessfulTitleStyle02,)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * 0.080,
                      right: size.width * 0.080,
                      top: size.height * 0.022,
                    ),
                      child: Text("Your reference no: ${widget.refNumber}",style: Styles.textSuccessfulTitle02Style,)),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.048
                      ),
                      alignment: Alignment.bottomCenter,
                        child: Text("Wait for Approval from admin!  ",style: Styles.textSuccessfulTitle03Style,)
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

}