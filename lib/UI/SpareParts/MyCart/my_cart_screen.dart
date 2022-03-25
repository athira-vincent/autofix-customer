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

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenState();
  }
}

class _MyCartScreenState extends State<MyCartScreen> {
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
                    productsListUi(),
                    placeOrderUi(),
                    changeAddressUi(),
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
            'My Cart',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget productsListUi() {
    return  ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount:3,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: CustColors.whiteBlueish,
              borderRadius: BorderRadius.circular(0.0)
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustColors.greyText1),
                borderRadius: BorderRadius.circular(0)
            ),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,0),
                          child: Text(
                            "Ford fiesta",
                            style: Styles.sparePartNameSubTextBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,0),
                          child: Text(
                            "Clutch assembly",
                            style: Styles.sparePartNameTextBlack17,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,10),
                          child: Text(
                            "A2137635123. | Ford fiesta fort",
                            style: Styles.sparePartNameSubTextBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,5,0),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              height: 20,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: CustColors.greyText3),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 25,
                                    color: Colors.transparent,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "-",
                                      textAlign: TextAlign.start,
                                      style: Styles.homeNameTextStyle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "12",
                                        textAlign: TextAlign.center,
                                        style: Styles.homeActiveTextStyle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 25,
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "+",
                                      style: Styles.homeNameTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Icon(Icons.delete_outline_outlined, color: CustColors.light_navy),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Text(
                          "\$ 3000",
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Container(
                          height: 20,
                          width: 70,
                          alignment: Alignment.center,
                          color: CustColors.light_navy,
                          child: Text(
                            "Place order",
                            style: Styles.badgeTextStyle1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }

  Widget placeOrderUi() {
    return  Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: CustColors.greyText1),
              borderRadius: BorderRadius.circular(0)
          ),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/image/home_customer/mycartSucessflag.svg',height: 35,width: 35,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Text(
                          "Buy all the  products in the cart",
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,0,0),
                      child: Text(
                        "\$ 3000",
                        style: Styles.sparePartNameTextBlack17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,0,0),
                      child: Container(
                        height: 20,
                        width: 70,
                        alignment: Alignment.center,
                        color: CustColors.light_navy,
                        child: Text(
                          "Place order",
                          style: Styles.badgeTextStyle1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget changeAddressUi() {
    return  Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: CustColors.greyText1),
              borderRadius: BorderRadius.circular(0)
          ),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/image/home_customer/myCartLocation.svg',height: 30,width: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Text(
                          "Delivering To: Savannah estate,plot 176",
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Text(
                          "Beside oando filling station.",
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          height: 25,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustColors.light_navy),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Text(
                            "Change Address",
                            style: Styles.homeActiveTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
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

