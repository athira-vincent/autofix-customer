import 'package:auto_fix/Constants/styles.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.only(
              left: size.width * 0.155,
              right: size.width * 0.155,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.335,
                      left: size.width * 0.133,
                      right: size.width * 0.133
                      /*bottom: size.height * 0.455*/),
                  child: Image.asset("assets/image/img_admin_approval.png"),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: size.width * 0.009,
                      right: size.width * 0.009,
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
                    left: size.width * 0.085,
                    right: size.width * 0.085,
                    top: size.height * 0.022,
                  ),
                    child: Text("Your reference no: 1234567",style: Styles.textSuccessfulTitle02Style,)),
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
        )
      ),
    );
  }

}