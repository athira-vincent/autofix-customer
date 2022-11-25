import 'package:auto_fix/Common/TokenChecking/JWTTokenChecking.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ChangePassword/change_password_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangePasswordScreen extends StatefulWidget {
  final String email;
   ChangePasswordScreen(
       {Key? key,required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final ChangePasswordBloc _createPasswordBloc = ChangePasswordBloc();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  FocusNode _oldPasswordFocusNode = FocusNode();
  FocusNode _newPasswordFocusNode = FocusNode();
  FocusNode _confirmPwdFocusNode = FocusNode();
  TextStyle _lableStyleOldPassword = const TextStyle();
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
  bool _oldPasswordVisible = true;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible= true;
  String authToken = "";
  String email = "";


  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    _oldPasswordController.addListener(onFocusChange);
    _newPasswordController.addListener(onFocusChange);
    _confirmPwdController.addListener(onFocusChange);
    _getCreatePwd();
  }

  @override
  void dispose() {
    super.dispose();
    _oldPasswordFocusNode.removeListener(onFocusChange);
    _oldPasswordController.dispose();
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
            content: Text("Reset Successfully. Login with new Password",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
          Navigator.pop(context);
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
      _lableStyleOldPassword = _oldPasswordFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _lableStyleNewPassword = _newPasswordFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _lableStyleConfirmPwd = _confirmPwdFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData CustomerMyProfileScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      email = widget.email;
      JWTTokenChecking.checking(authToken, context);
      print('userFamilyId CustomerMyProfileScreen'+authToken.toString());
    });
    String id = shdPre.getString(SharedPrefKeys.userID,).toString();
    //_fetchProfileBloc.postCustomerProfileRequest(authToken,id);
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
                  height: MediaQuery.of(context).size.height * 0.35 ,
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
                          child: Image.asset('assets/image/changePswd_bg.png',height: MediaQuery.of(context).size.height *0.23,),
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
                            Container(
                              child: Text(
                                'Change password',   //'Check your mail',
                                style: Styles.textHeadLogin,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 0, right: 5, top: 15,bottom: 10),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              //color: Colors.red,
                              child: Text(
                                'Create new password. Your new password must be different from previous used passwords. ',
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                style: Styles.textLabelSubTitle12,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 20.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Old Password',
                                    style: Styles.textLabelTitle,
                                  ),
                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    obscureText: _oldPasswordVisible,
                                    validator: InputValidator(ch: 'Password').passwordChecking,
                                    controller: _oldPasswordController,
                                    focusNode: _oldPasswordFocusNode,
                                    maxLines: 1,
                                    style: Styles.textLabelSubTitle,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      suffixIconConstraints: BoxConstraints(
                                        minWidth: 25,
                                        minHeight: 25,
                                      ),
                                      suffixIcon: Container(
                                        width: 5,
                                        height: 10,
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          iconSize: 15,
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _oldPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _oldPasswordVisible = !_oldPasswordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      hintText: 'Old Password',
                                      errorMaxLines: 3,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.8,
                                        horizontal: 0.0,
                                      ),
                                      hintStyle: Styles.textLabelSubTitle,),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 20.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('New Password',
                                    style: Styles.textLabelTitle,
                                  ),
                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    obscureText: _passwordVisible,
                                    validator: InputValidator(ch: 'New Password').passwordChecking,
                                    controller: _newPasswordController,
                                    focusNode: _newPasswordFocusNode,
                                    maxLines: 1,
                                    style: Styles.textLabelSubTitle,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      suffixIconConstraints: BoxConstraints(
                                        minWidth: 25,
                                        minHeight: 25,
                                      ),
                                      suffixIcon: Container(
                                        width: 5,
                                        height: 10,
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          iconSize: 15,
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      hintText: 'New Password',
                                      errorMaxLines: 3,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.8,
                                        horizontal: 0.0,
                                      ),
                                      hintStyle: Styles.textLabelSubTitle,),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 20.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Confirm password',
                                    style: Styles.textLabelTitle,
                                  ),
                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    obscureText: _confirmPasswordVisible,
                                    validator:
                                    InputValidator(ch: 'Confirm Password').passwordChecking,
                                    controller: _confirmPwdController,
                                    focusNode: _confirmPwdFocusNode,
                                    maxLines: 1,
                                    style: Styles.textLabelSubTitle,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      suffixIconConstraints: BoxConstraints(
                                        minWidth: 25,
                                        minHeight: 25,
                                      ),
                                      suffixIcon: Container(
                                        width: 5,
                                        height: 10,
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          iconSize: 15,
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _confirmPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _confirmPasswordVisible = !_confirmPasswordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      hintText: 'Password',
                                      errorMaxLines: 3,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.greyish,
                                          width: .5,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.8,
                                        horizontal: 0.0,
                                      ),
                                      hintStyle: Styles.textLabelSubTitle,),
                                  ),
                                  /*Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ForgotPasswordScreen()));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: _setValue(10)),
                                                        child: Text(
                                                          'Forgot password?',
                                                          style: Styles.textLabelSubTitle,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )*/
                                ],
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5), bottom: _setValue(15.5)),
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

                /*Column(
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
                ),*/
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
        "$authToken",
        "${widget.email}",
        _oldPasswordController.text,
        _newPasswordController.text,
        _confirmPwdController.text
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

