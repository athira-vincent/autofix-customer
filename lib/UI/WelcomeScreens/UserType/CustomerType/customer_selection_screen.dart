import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/user_category.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSelectionScreen extends StatefulWidget {
  const CustomerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerSelectionScreenState();
  }
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: Column(
                children: [
                  IndicatorWidget(isFirst: true,isSecond: true,isThird: false,isFourth: false,),

                  Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.033,
                        right: size.width * 0.181,
                        left: size.width * 0.172
                    ),
                    child: Text('Mechanic',
                      style: Styles.hiddenTextBlack
                    ),
                  ),

                  Expanded(
                    child: Container(
                      color: CustColors.pale_grey,
                      margin: EdgeInsets.only(
                          top: size.height * 0.026,
                          right: size.width * 0.05,
                          left: size.width * 0.05,
                          bottom: size.height * 0.041
                      ),
                      //padding: EdgeInsets.only(bottom: size.height * 0.101),
                      height: size.height * 0.810,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: size.height * 0.023,
                                right: size.width * 0.181,
                                left: size.width * 0.172
                            ),
                            child: Text('Customer',
                                style: Styles.TitleTextBlack
                            ),
                            //child: Text("Select ! What type of user are you ?"),
                          ),

                          InkWell(
                            onTap: (){
                              setUserCategory(TextStrings.user_category_individual);
                            },
                            child: UserCategorySelectionWidget(titleText: 'Individual',
                              imagePath: "assets/image/CustomerType/img_individual.png",),
                          ),

                          InkWell(
                            onTap: (){
                              setUserCategory(TextStrings.user_category_corporate);
                            },
                            child: UserCategorySelectionWidget(titleText: 'Corporate',
                              imagePath: "assets/image/CustomerType/img_corporate.png",),
                          ),

                          InkWell(
                            onTap: (){
                              setUserCategory(TextStrings.user_category_government);
                            },
                            child: UserCategorySelectionWidget(titleText: 'Government Bodies',
                              imagePath: "assets/image/CustomerType/img_government_bodies.png",),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setUserCategory(String userCategory) async {
    print(">>>>userCategory " + userCategory);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userCategory, userCategory);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SignupScreen(
              userCategory: userCategory,
              userType: prefs.getString(SharedPrefKeys.userType).toString(),
            )));
    print(">>>>> userCategory " + userCategory + " >>>>>>>userType " + prefs.getString(SharedPrefKeys.userType).toString());
  }

}