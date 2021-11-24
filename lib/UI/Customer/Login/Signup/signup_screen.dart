import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/states_mdl.dart';
import 'package:auto_fix/UI/Customer/Login/login_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _stateFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final SignupBloc _signupBloc = SignupBloc();
  bool _isLoading = false;
  List<StateDetails> _countryData = [];
  bool isloading = false;
  String? countryCode;
  @override
  void initState() {
    super.initState();
    _getSignUpRes();
    _signupBloc.dialStatesListRequest();
    _populateCountryList();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    _passwordController.dispose();
    _confirmPwdController.dispose();
    _phoneController.dispose();
    _signupBloc.dispose();
  }

  _getSignUpRes() {
    _signupBloc.postSignUp.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("errrrorr 02");
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
          print("errrrorr 01");
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
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
            child: Form(
              autovalidateMode: _autoValidate,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 26, left: 34, right: 34),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.5,
                          fontFamily: 'Corbel_Bold'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 17, left: 34, right: 34),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Montserrat_Semibond',
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      focusNode: _firstNameFocusNode,
                      keyboardType: TextInputType.text,
                      validator: InputValidator(ch: "Name").nameChecking,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          labelText: 'Name',
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
                            fontSize: 12,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 34,
                      right: 34,
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Montserrat_Semibond',
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      focusNode: _userNameFocusNode,
                      keyboardType: TextInputType.text,
                      validator: InputValidator(ch: "User name").emptyChecking,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      ],
                      controller: _userNameController,
                      decoration: InputDecoration(
                          labelText: 'User Name',
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
                            fontSize: 12,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidator(ch: "Email ID").emailValidator,
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Montserrat_Semibond',
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Email ID*',
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
                            fontSize: 12,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                    child: InkWell(
                      onTap: () {
                        showDialCodeSelector();
                      },
                      child: Container(
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          enabled: false,
                          style: TextStyle(
                            fontFamily: 'Montserrat_Semibond',
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          focusNode: _stateFocusNode,
                          keyboardType: TextInputType.text,
                          validator: InputValidator(ch: "State").emptyChecking,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z]')),
                          ],
                          controller: _stateController,
                          decoration: InputDecoration(
                              labelText: 'State',
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
                                fontSize: 12,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 34, right: 34),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 8,
                            child: Container(
                              width: double.infinity,
                              child: TextFormField(
                                validator: InputValidator(ch: "Phone number")
                                    .phoneNumChecking,
                                maxLines: 1,
                                focusNode: _phoneFocusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                                style: TextStyle(
                                  fontFamily: 'Montserrat_Semibond',
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                    labelText: 'Phone Number*',
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
                                      fontSize: 12,
                                    )),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: true,
                      validator:
                          InputValidator(ch: "Password").passwordChecking,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Montserrat_Semibond',
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Password*',
                          errorMaxLines: 3,
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
                            fontSize: 12,
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 34, right: 34),
                    child: TextFormField(
                      obscureText: true,
                      validator: InputValidator(ch: "Confirm Password")
                          .passwordChecking,
                      maxLines: 1,
                      controller: _confirmPwdController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat_Semibond',
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Confirm Password*',
                          errorMaxLines: 3,
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
                            fontSize: 12,
                          )),
                    ),
                  ),
                  Container(
                    height: 28,
                    width: 98,
                    margin: const EdgeInsets.only(top: 25, left: 34, right: 34),
                    child: _isLoading
                        ? const Center(
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
                                  checkPassWord(_passwordController.text,
                                      _confirmPwdController.text);
                                } else {
                                  setState(() =>
                                      _autoValidate = AutovalidateMode.always);
                                }
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Sign up',
                                      style: TextStyle(
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                        fontSize: 11.5,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 16.6,
                                      ),
                                      child: Image.asset(
                                        'assets/images/arrow_forword.png',
                                        width: 12.5,
                                        height: 12.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 19, left: 34, right: 34),
                      child: Text(
                        'Already have an account ? Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontFamily: 'Corbel_Light'),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/images/signup_arc.png',
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(
                              left: 66, bottom: 26.5, right: 78),
                          child: Image.asset(
                            'assets/images/autofix_logo.png',
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        _passwordController.text = "";
        _confirmPwdController.text = "";
      });
    } else {
      _signupBloc.postSignUpRequest(
          _firstNameController.text,
          _userNameController.text,
          _emailController.text,
          _stateController.text,
          _passwordController.text,
          _phoneController.text);
      setState(() {
        _isLoading = true;
      });
    }
  }

  void showDialCodeSelector() {
    _signupBloc.searchStates("");
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              content: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: double.maxFinite,
                              child: Column(children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 10),
                                  width: double.infinity,
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      onChanged: (text) {
                                        setState(() {
                                          _countryData.clear();
                                          isloading = true;
                                        });
                                        _signupBloc.searchStates(text);
                                      },
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search",
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 5,
                                  color: Colors.grey,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.6 -
                                          108,
                                  child: _countryData.length != 0
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: _countryData.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              onTap: () {
                                                final dial_Code =
                                                    _countryData[index].name;

                                                setState(() {
                                                  _stateController.text =
                                                      dial_Code.toString();
                                                });

                                                Navigator.pop(context);
                                              },
                                              title: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 0, 5, 0),
                                                  height: 55,
                                                  color: index % 2 == 0
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Text(
                                                        '${_countryData[index].name}',
                                                        style: TextStyle(
                                                            color: CustColors
                                                                .peaGreen,
                                                            fontFamily:
                                                                'Robot_Regular',
                                                            fontSize: 13),
                                                        maxLines: 4,
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      // Flexible(
                                                      //     child: Text(
                                                      //         '${_countryData[index].countryName}'))
                                                    ],
                                                  )),
                                            );
                                          })
                                      : Center(
                                          child: Text('No Results found.'),
                                        ),
                                ),
                                Divider(
                                  height: 5,
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  child: Container(
                                      height: 40,
                                      child: Center(
                                          child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: CustColors.peaGreen),
                                      ))),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ])),
                          Center(
                            child: isloading
                                ? CircularProgressIndicator()
                                : Text(''),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          });
        });
  }

  _populateCountryList() {
    _signupBloc.statesCode.listen((value) {
      setState(() {
        isloading = false;
        _countryData = value.cast<StateDetails>();
      });
    });
  }
}
