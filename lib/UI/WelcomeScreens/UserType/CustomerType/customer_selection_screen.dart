import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/MechanicType/mechanic_selection_screen.dart';
import 'package:auto_fix/Widgets/custom_page_route.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/user_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                  child: Text(AppLocalizations.of(context)!.text_mechanic,
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
                            tag: "customer",
                            child: Text(AppLocalizations.of(context)!.text_customer,
                                style: Styles.TitleTextBlack
                            )),
                        //child: Text("Select ! What type of user are you ?"),
                      ),

                      InkWell(
                        onTap: (){
                          startNextPage(TextStrings.user_category_individual);
                        },
                        child: UserCategorySelectionWidget(titleText: AppLocalizations.of(context)!.text_individual,
                          imagePath: "assets/image/CustomerType/img_individual.png",),
                      ),

                      InkWell(
                        onTap: (){
                          startNextPage(TextStrings.user_category_corporate);
                        },
                        child: UserCategorySelectionWidget(titleText: AppLocalizations.of(context)!.text_corporate,
                          imagePath: "assets/image/CustomerType/img_corporate.png",),
                      ),

                      InkWell(
                        onTap: (){
                          startNextPage(TextStrings.user_category_government);
                        },
                        child: UserCategorySelectionWidget(titleText: AppLocalizations.of(context)!.text_govt_bodies,
                          imagePath: "assets/image/CustomerType/img_government_bodies.png",),
                      ),
                    ],
                  ),
                ),

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