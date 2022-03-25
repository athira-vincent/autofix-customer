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

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  bool _isLoading = false;

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
    _emailFocusNode.removeListener(onFocusChange);
    _forgotPasswordBloc.dispose();
  }

  _getForgotPwd() {
    _forgotPasswordBloc.postForgotPassword.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Reset Enabled.\nCheck Your mail",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void onFocusChange() {
    setState(() {
      _labelStyleEmail = _emailFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
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

                    SortByUi(),

                    PriceUi(),

                    DiscountUi(),

                    SizedBox(height: 40,),

                    ApplyFilterButtonUi(),


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
      ],
    );
  }

  Widget SortByUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,10),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,15),
              child: Text(
                'Sort by',
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: GridView.builder(
                itemCount:6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2
                ),
                itemBuilder: (context,index,) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          border: Border.all(color: CustColors.greyText1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text(
                            'Price: Low to high',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget PriceUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,10),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,15),
              child: Text(
                'Price',
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: GridView.builder(
                itemCount:6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2
                ),
                itemBuilder: (context,index,) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          border: Border.all(color: CustColors.greyText1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text(
                            'Price: Low to high',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget DiscountUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,10),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,15),
              child: Text(
                'Discount',
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: GridView.builder(
                itemCount:6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2
                ),
                itemBuilder: (context,index,) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          border: Border.all(color: CustColors.greyText1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text(
                            'Price: Low to high',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ApplyFilterButtonUi() {
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Spacer(),
            Container(
              height: 35,
              width:130,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 8, bottom: 6,left: 20,right: 20),
              //padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: CustColors.light_navy,
                border: Border.all(
                  color: CustColors.blue,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Apply filter",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
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

