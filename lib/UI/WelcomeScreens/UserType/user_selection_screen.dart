import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserSelectionScreenState();
  }
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColors.blue,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/image01.png',
                      width: 117.3,
                      height: 74.9,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(bottom: 4.8),
                    child: Image.asset(
                      'assets/images/image02.png',
                      width: 45,
                      height: 45,
                    ),
                  )
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences shdPre =
                            await SharedPreferences.getInstance();
                        shdPre.setString(
                            SharedPrefKeys.userType, TextStrings.user_customer);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SigninScreen()));
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/customer.png',
                            width: 96.8,
                            height: 96.8,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7.8),
                            child: Text("CUSTOMER",
                                style: TextStyle(
                                    fontSize: 14.5,
                                    fontFamily: 'Corbel_Light',
                                    color: CustColors.blue)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences shdPre =
                            await SharedPreferences.getInstance();
                        shdPre.setString(
                            SharedPrefKeys.userType, TextStrings.user_mechanic);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const SigninScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 41.2),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/mechanic.png',
                              width: 96.8,
                              height: 96.8,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.8),
                              child: Text("MECHANIC",
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      fontFamily: 'Corbel_Light',
                                      color: CustColors.blue)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences shdPre =
                            await SharedPreferences.getInstance();
                        shdPre.setString(
                            SharedPrefKeys.userType, TextStrings.user_vendor);
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => const HomeScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 41.2),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/vendor.png',
                              width: 96.8,
                              height: 96.8,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.8),
                              child: Text("SAPRE PARTS VENDOR",
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      fontFamily: 'Corbel_Light',
                                      color: CustColors.blue)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setUserType(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userType, userType);
  }
}
