import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
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

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,

            child: Column(
              children: [

                IndicatorWidget(isFirst: true,isSecond: true,isThird: false,isFourth: false,),

                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.069,
                    right: size.width * 0.181,
                    left: size.width * 0.172
                  ),
                  color: Colors.red,
                  //child: Text(),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                              bool? flag =
                              shdPre.getBool(SharedPrefKeys.isCustomerSignUp);
                              if (flag != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SigninScreen()));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignupScreen()));
                              }
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
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Corbel_Light',
                                          color: CustColors.blue)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                              bool? flag =
                              shdPre.getBool(SharedPrefKeys.isCustomerSignUp);
                              if (flag != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SigninScreen()));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignupScreen()));
                              }
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
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Corbel_Light',
                                          color: CustColors.blue)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            )
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
