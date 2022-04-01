import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/Countdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:slider_button/slider_button.dart';

class IncomingJobRequestScreen extends StatefulWidget {
  const IncomingJobRequestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IncomingJobRequestScreenState();
  }
}

class _IncomingJobRequestScreenState extends State<IncomingJobRequestScreen> with TickerProviderStateMixin{
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

  bool SliderVal=false;

  int _counter = 0;
  late AnimationController _controller;
  int levelClock = 30;


  @override
  void initState() {
    super.initState();
    _getForgotPwd();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller.forward();
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
                    Container(
                      height: MediaQuery.of(context).size.height *0.32 ,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SvgPicture.asset('assets/image/MechanicType/incomingRequestBg.svg',height: MediaQuery.of(context).size.height *0.32,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          autovalidateMode: _autoValidate,
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: _setValue(20.5), right: _setValue(20.5),top: _setValue(17.5), ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: CustColors.warm_grey04),
                                        borderRadius: BorderRadius.circular(11.0)
                                    ),
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10,),
                                              Container(
                                                child: Text('Timing  belt replacement',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelTitle_12,
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                child: Text('Toyota Corolla   [Black]',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelTitle16,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                child: Text('YAB477AB',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelTitle16,
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: 150,
                                                child: Text('Elenjikkal House '
                                                    'Empyreal Garden '
                                                    'Opposite of Ceevees International Auditorium Anchery'
                                                    'Anchery P.O'
                                                    'Thrissur - 680006',
                                                  maxLines: 4,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelSubTitlegrey11,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 40,
                                  width: SliderVal==false ? 240 : 40,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: SliderVal==false ? CustColors.light_navy : CustColors.white_02,
                                      ),
                                      borderRadius: BorderRadius.circular(50) // use instead of BorderRadius.all(Radius.circular(20))
                                  ),
                                  child:
                                  SliderVal==false
                                  ? SliderButton(
                                    buttonColor: CustColors.blue,
                                    backgroundColor: Colors.white,
                                    highlightedColor: CustColors.light_navy02,
                                    baseColor:  CustColors.light_navy,
                                      action: () {
                                        print('success');
                                        setState(() {
                                          SliderVal=true;
                                        });
                                      },
                                      label: Text(
                                        "Slide to accept offer",
                                        style: TextStyle(
                                            color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                                      ),
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                              color: CustColors.blue,
                                              borderRadius: BorderRadius.circular(40) // use instead of BorderRadius.all(Radius.circular(20))
                                          ),
                                          child:  Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 30.0,
                                              semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                      ),
                                    )
                                  : Container(
                                      height: 40,
                                      width: 50,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(color: CustColors.light_navy,),
                                          Icon(
                                            Icons.check,
                                            color:  CustColors.light_navy,
                                            size: 30.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                        ],
                                      ),
                                    ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 10),
                                  alignment: Alignment.center,
                                  //color: Colors.red,
                                  child: Text(
                                    "Accept offer within 30 seconds! ",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: Styles.textLabelSubTitle12,
                                  ),
                                ),
                                Countdown(
                                  animation: StepTween(
                                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                                    end: 0,
                                  ).animate(_controller),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        /*IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),*/
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Incoming job offer',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
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

