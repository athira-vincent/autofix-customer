import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignIn/signin_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';

import 'forgot_password_bloc.dart';

class MechanicForgotPasswordScreen extends StatefulWidget {
  const MechanicForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicForgotPasswordScreenState();
  }
}

class _MechanicForgotPasswordScreenState extends State<MechanicForgotPasswordScreen> {

  TextEditingController _emailController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final MechanicForgotPasswordBloc _forgotPasswordBloc = MechanicForgotPasswordBloc();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(onFocusChange);
    _getForgotPwd();
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.removeListener(onFocusChange);
    _emailController.dispose();
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
              MaterialPageRoute(builder: (context) => const MechanicSigninScreen()));
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
    return Scaffold(
      backgroundColor: CustColors.blue,
      body: Theme(
        data: ThemeData(
          disabledColor: Colors.white,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6, left: 15),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    //child: Icons(Icons.keyboard_arrow_left_outlined),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 62, top: 95),
                    padding: EdgeInsets.all(5),
                    //color: Colors.red,
                    child: Text(
                      "Forgot  Password ?",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: ScreenSize().setValueFont(44),
                        fontFamily: 'Corbel_Bold',
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.7,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 16, top: 17),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    //color: Colors.red,
                    child: Text(
                      "Enter the email address  associated with your "
                          "account, we’ll send an email with instructions "
                          "to reset your password. ",
                      //textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(
                          height: 1.3,
                          fontSize: ScreenSize().setValueFont(14.5),
                          fontFamily: 'Corbel_Regular',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.7),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 22, right: 20),
                    padding: EdgeInsets.all(4),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidator(ch: "Email ").emailValidator,
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Corbel_SemiBold',
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email Id*',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: .3,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: .3,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: .3,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.8,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Corbel_Light',
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 98,
                    margin: EdgeInsets.only(top: 22, left: 25),
                    child: _isLoading
                        ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.peaGreen),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustColors.darkBlue,
                            blurRadius: 5,
                            offset: Offset(0, 3.3),
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _forgotPasswordBloc.postForgotPasswordRequest(
                                _emailController.text);

                            setState(() {
                              _isLoading = true;
                            });
                          } else {
                            setState(() =>
                            _autoValidate = AutovalidateMode.always);
                          }
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Send',
                                style: TextStyle(
                                  color: CustColors.blue,
                                  fontFamily: 'Corbel_Regular',
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 16,
                                ),
                                child: Image.asset(
                                  'assets/images/arrow_forword.png',
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),

                  /*Container(
                    margin: const EdgeInsets.only(top: 19.3),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidator(ch: "Email ID").emailValidator,
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto_Regular',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email ID',
                        labelText: 'Email ID*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: const BorderSide(
                            color: CustColors.borderColor,
                            width: 0.3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: const BorderSide(
                            color: CustColors.peaGreen,
                            width: 0.3,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: const BorderSide(
                            color: CustColors.borderColor,
                            width: 0.3,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        labelStyle: _labelStyleEmail,
                      ),
                    ),
                  ),*/

                  /*Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 28, right: 28, top: 15),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  CustColors.peaGreen),
                            ),
                          )
                        : MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _forgotPasswordBloc.postForgotPasswordRequest(
                                    _emailController.text);
                              } else {
                                setState(() =>
                                    _autoValidate = AutovalidateMode.always);
                              }
                            },
                            child: const Text(
                              'SEND',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto_Bold',
                                fontSize: 14,
                              ),
                            ),
                            color: CustColors.peaGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.5)),
                          ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
