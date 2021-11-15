import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Vendor/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';

class VendorForgotPasswordScreen extends StatefulWidget {
  const VendorForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VendorForgotPasswordScreenState();
  }
}

class _VendorForgotPasswordScreenState extends State<VendorForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final VendorForgotPasswordBloc _forgotPasswordBloc = VendorForgotPasswordBloc();
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
            content: Text("Reset Password",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
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
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          children: [
            Container(
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
            ),
            Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 28, right: 28, top: 15),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustColors.peaGreen),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _forgotPasswordBloc
                              .postForgotPasswordRequest(_emailController.text);
                        } else {
                          setState(
                              () => _autoValidate = AutovalidateMode.always);
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
            ),
          ],
        ),
      ),
    );
  }
}
