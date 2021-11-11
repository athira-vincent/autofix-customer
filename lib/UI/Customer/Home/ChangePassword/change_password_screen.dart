import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  FocusNode _newPasswordFocusNode = FocusNode();
  FocusNode _confirmPwdFocusNode = FocusNode();
  TextStyle _lableStyleNewPassword = const TextStyle();
  TextStyle _lableStyleConfirmPwd = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(onFocusChange);
    _confirmPwdController.addListener(onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordFocusNode.removeListener(onFocusChange);
    _newPasswordController.dispose();
    _confirmPwdFocusNode.removeListener(onFocusChange);
    _confirmPwdController.dispose();
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
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                obscureText: true,
                validator: InputValidator(ch: "New Password").passwordChecking,
                controller: _newPasswordController,
                focusNode: _newPasswordFocusNode,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto_Regular',
                ),
                decoration: InputDecoration(
                    labelText: 'Enter new Password*',
                    hintText: 'Enter new Password',
                    errorMaxLines: 3,
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
                      fontFamily: 'Roboto_Regular',
                      color: Color.fromARGB(52, 3, 43, 80),
                      fontSize: 14,
                    ),
                    labelStyle: _lableStyleNewPassword),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: TextFormField(
                obscureText: true,
                validator:
                    InputValidator(ch: "Confirm Password").passwordChecking,
                maxLines: 1,
                controller: _confirmPwdController,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto_Regular',
                ),
                decoration: InputDecoration(
                  labelText: 'Confirm Password*',
                  hintText: 'Confirm Password',
                  errorMaxLines: 3,
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
                    fontFamily: 'Roboto_Regular',
                    color: Color.fromARGB(52, 3, 43, 80),
                    fontSize: 14,
                  ),
                  labelStyle: _lableStyleConfirmPwd,
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 28, right: 28, top: 15),
              child:
                  //  isLoading
                  //     ? Center(
                  //         child: CircularProgressIndicator(
                  //           valueColor: AlwaysStoppedAnimation<Color>(
                  //               CustColors.peaGreen),
                  //         ),
                  //       )
                  //     :
                  MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    checkPassWord(_newPasswordController.text,
                        _confirmPwdController.text);
                  } else {
                    setState(() => _autoValidate = AutovalidateMode.always);
                  }
                },
                child: const Text(
                  'CHANGE',
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
            ),
          ],
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
        _newPasswordController.text = "";
        _confirmPwdController.text = "";
      });
    } else {
      setState(() {
        // isLoading = true;
      });
    }
  }
}
