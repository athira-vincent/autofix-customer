import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/user_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                IndicatorWidget(isFirst: true,isSecond: true,isThird: false,isFourth: false,),

                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.033,
                      right: size.width * 0.181,
                      left: size.width * 0.172
                  ),
                  child: Text(AppLocalizations.of(context)!.text_customer,
                      style: Styles.hiddenTextBlack
                  ),
                  //child: Text("Select ! What type of user are you ?"),
                ),

                Container(
                  color: CustColors.pale_grey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.033,
                            right: size.width * 0.181,
                            left: size.width * 0.172
                        ),
                        child: Hero(
                            tag: "mechanic",
                            child: Text(AppLocalizations.of(context)!.text_mechanic,
                                style: Styles.TitleTextBlack
                            )),
                        //child: Text("Select ! What type of user are you ?"),
                      ),

                      InkWell(
                        onTap: () async {
                          startNextPage(TextStrings.user_category_individual);
                        },
                        child: UserCategorySelectionWidget(titleText: AppLocalizations.of(context)!.text_individual,
                          imagePath: "assets/image/MechanicType/img_individual.png",),
                      ),

                      InkWell(
                        onTap: () async {
                          startNextPage(TextStrings.user_category_corporate);
                        },
                        child: UserCategorySelectionWidget(titleText: AppLocalizations.of(context)!.text_corporate,
                          imagePath: "assets/image/MechanicType/img_corporate.png",),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startNextPage(String userCategory) async {
    print(">>>>userCategory" + userCategory);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userCategory, userCategory);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SignupScreen(
              userCategory: userCategory,
              userType: prefs.getString(SharedPrefKeys.userType).toString(),
            )));
  }


}