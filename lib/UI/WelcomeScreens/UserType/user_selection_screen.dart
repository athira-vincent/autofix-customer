import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/CustomerType/customer_selection_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/MechanicType/mechanic_selection_screen.dart';
import 'package:auto_fix/Widgets/custom_page_route.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/user_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserSelectionScreenState();
  }
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

     const _alignments = [
      // Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      //   Alignment.bottomRight,
    ];

    return MaterialApp(
      theme: ThemeData.from(colorScheme: const ColorScheme.light(),).copyWith(
        pageTransitionsTheme:  const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
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
                    top: size.height * 0.033,
                    right: size.width * 0.181,
                    left: size.width * 0.172
                  ),
                  child: Row(
                    children: [
                      Text( AppLocalizations.of(context)!.text_user_selection_red,style: Styles.textLabelSubTitleRed,),
                      Text(AppLocalizations.of(context)!.text_user_selection_blue,style: Styles.textLabelSubTitleBlue,),
                    ],
                  ),
                  //child: Text("Select ! What type of user are you ?"),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.026,
                        right: size.width * 0.06,
                        left: size.width * 0.06,
                        bottom: size.height * 0.035
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Center(
                          child: InkWell(

                            onTap: () async {
                              setUserType(TextStrings.user_customer);
                              /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute( builder: (context) => const CustomerSelectionScreen()));*/
                            },
                            child: UserTypeSelectionWidget(
                              imagePath: 'assets/image/UserType/img_user_customer.png',
                              titleText: Hero(
                                tag: "customer",
                                child: Text(AppLocalizations.of(context)!.text_customer,
                                  style: Styles.titleTextStyle),
                              ),
                              //titleText: ,
                            ),
                          ),
                        ),


                        Center(
                          child: InkWell(
                            onTap: () async {
                              setUserType( TextStrings.user_mechanic);
                            },
                            child: UserTypeSelectionWidget(
                              imagePath: 'assets/image/UserType/img_user_mechanic.png',
                              titleText: Hero(
                                tag: "mechanic",
                                child: Text(AppLocalizations.of(context)!.text_mechanic,
                                    style: Styles.titleTextStyle),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  void setUserType(String userType) async {
    print(">>>>userCategory" + userType);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userType, userType);
    if (userType == TextStrings.user_mechanic) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MechanicSelectionScreen()));
    } else if (userType == TextStrings.user_customer) {
      Navigator.push(context,
          MaterialPageRoute(
              builder: (
                  BuildContext context) => const CustomerSelectionScreen()));
    }
  }
}
