import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/CreatePasswordScreen/create_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SparePartsListScreen extends StatefulWidget {
  const SparePartsListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SparePartsListScreenState();
  }
}

class _SparePartsListScreenState extends State<SparePartsListScreen> {


  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }
  double _setValueFont(double value) {
    return value * perfont + value;
  }
  bool language_en_ar=true;


  @override
  void initState() {
    super.initState();
    _getForgotPwd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getForgotPwd() {

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                // ignore: avoid_unnecessary_containers
                child: Column(
                  children: [
                    appBarCustomUi(),
                    SparePartsListUi(),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Ford Fiesta',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () {


          },
        ),
        IconButton(
          icon: Icon(Icons.sort, color: Colors.black),
          onPressed: () {


          },
        ),
      ],
    );
  }

  Widget SparePartsListUi() {
    return GridView.builder(
      itemCount:8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context,index,) {
        return GestureDetector(
          onTap:(){

          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustColors.greyText1),
                borderRadius: BorderRadius.circular(0)
            ),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustColors.whiteBlueish,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.ice_skating,size: 100,color: CustColors.light_navy,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text('dgsgs',
                    style: Styles.textLabelTitleEmergencyServiceName,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

