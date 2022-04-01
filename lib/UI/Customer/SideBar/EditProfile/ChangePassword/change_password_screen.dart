import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/ChangePassword/change_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChangePasswordScreen extends StatefulWidget {

   ChangePasswordScreen(
       {Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final ChangePasswordBloc _createPasswordBloc = ChangePasswordBloc();

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  FocusNode _newPasswordFocusNode = FocusNode();
  FocusNode _confirmPwdFocusNode = FocusNode();
  TextStyle _lableStyleNewPassword = const TextStyle();
  TextStyle _lableStyleConfirmPwd = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible= false;


  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(onFocusChange);
    _confirmPwdController.addListener(onFocusChange);
    _getCreatePwd();
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordFocusNode.removeListener(onFocusChange);
    _newPasswordController.dispose();
    _confirmPwdFocusNode.removeListener(onFocusChange);
    _confirmPwdController.dispose();
    _createPasswordBloc.dispose();
  }

  _getCreatePwd() {
    _createPasswordBloc.postChangePassword.listen((value) {
      print(value);
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
            content: Text("Password Reset Successful",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()
            ),
          );*/
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void onFocusChange() {
    setState(() {
      _lableStyleNewPassword = _newPasswordFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _lableStyleConfirmPwd = _confirmPwdFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            // ignore: avoid_unnecessary_containers
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height *0.40 ,
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
                          child: SvgPicture.asset('assets/image/forgotPwd/forgotPwd_bg.svg',height: MediaQuery.of(context).size.height *0.23,),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20.8),
                                    child: _isLoading
                                        ? Center(
                                      child: Container(
                                        height: _setValue(28),
                                        width: _setValue(28),
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              CustColors.peaGreen),
                                        ),
                                      ),
                                    )
                                        : Container(

                                      child: MaterialButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            checkPassWord(_newPasswordController.text,
                                                _confirmPwdController.text);
                                          } else {
                                            setState(() => _autoValidate = AutovalidateMode.always);
                                          }
                                        },
                                        child: Container(
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Reset password',
                                                textAlign: TextAlign.center,
                                                style: Styles.textButtonLabelSubTitle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        color: CustColors.materialBlue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                _setValue(13))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
        ));


  }

  void checkPassWord(String pwds, String cndpwd) {
    if (pwds != cndpwd) {
      //toastMsg.toastMsg(msg: "Passwords are different!");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords are different!",
            style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
        duration: Duration(seconds: 2),
        backgroundColor: CustColors.peaGreen,
      ));
      setState(() {
        _newPasswordController.text = "";
        _confirmPwdController.text = "";
      });
    } else {

      _createPasswordBloc.postChangePasswordRequest(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQ4Nzk0NjIwLCJleHAiOjE2NDg4ODEwMjB9.FF3rFlaVphjFF1A5-QsVVgVLuiyCdEc5U81cYruazts",
        "athiras152@gmail.com",
        "Abc@123",
        "Abc@123#",
        "Abc@123#"
      );

      setState(() {
        _isLoading = true;
      });
      /*setState(() {
        // isLoading = true;
        *//*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen()));*//*
      });*/
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

