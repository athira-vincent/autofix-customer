import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/user_category.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicSelectionScreen extends StatefulWidget {
  const MechanicSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicSelectionScreenState();
  }
}

class _MechanicSelectionScreenState extends State<MechanicSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
                child: Text('Customer',
                    style: Styles.hiddenTextBlack
                ),
                //child: Text("Select ! What type of user are you ?"),
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
                  height: size.height * 0.850,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.033,
                            right: size.width * 0.181,
                            left: size.width * 0.172
                        ),
                        child: Text('Mechanic',
                            style: Styles.TitleTextBlack
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          setUserCategory(TextStrings.user_category_individual);
                        },
                        child: UserCategorySelectionWidget(titleText: 'Individual',
                          imagePath: "assets/image/MechanicType/img_individual.png",),
                      ),

                      InkWell(
                        onTap: () async {
                          setUserCategory(TextStrings.user_category_corporate);
                        },
                        child: UserCategorySelectionWidget(titleText: 'Corporate',
                          imagePath: "assets/image/MechanicType/img_corporate.png",),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setUserCategory(String userCategory) async {
    print(">>>> userCategory " + userCategory);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userCategory, userCategory);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SignupScreen(
              userCategory: userCategory,
              userType: prefs.getString(SharedPrefKeys.userType).toString(),
            )));
    print(">>>>> userCategory " + userCategory + " SharedPrefKeys.userType " + prefs.getString(SharedPrefKeys.userType).toString());
  }


}