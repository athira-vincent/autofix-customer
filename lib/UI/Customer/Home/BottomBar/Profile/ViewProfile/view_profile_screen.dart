import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/ViewProfile/view_profile_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewProfileScreen extends StatefulWidget {
  final String id;
  const ViewProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewProfileScreenState();
  }
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final ViewProfileBloc _viewProfileBloc = ViewProfileBloc();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailIDController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  FocusNode _emailIDFocusNode = FocusNode();
  FocusNode _phoneNoFocusNode = FocusNode();
  TextStyle _labelStyleFirstName = TextStyle();
  TextStyle _labelStyleLastName = TextStyle();
  TextStyle _labelStyleAddress = TextStyle();
  TextStyle _labelStyleEmailId = TextStyle();
  TextStyle _labelStylePhoneNo = TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(onFocusChange);
    _lastNameController.addListener(onFocusChange);
    _addressController.addListener(onFocusChange);
    _emailIDController.addListener(onFocusChange);
    _phoneNoController.addListener(onFocusChange);
    _viewProfileBloc.postViewProfileRequest(widget.id);
    _getViewProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameFocusNode.removeListener(onFocusChange);
    _firstNameController.dispose();
    _lastNameFocusNode.removeListener(onFocusChange);
    _lastNameController.dispose();
    _addressFocusNode.removeListener(onFocusChange);
    _addressController.dispose();
    _emailIDFocusNode.removeListener(onFocusChange);
    _emailIDController.dispose();
    _phoneNoFocusNode.removeListener(onFocusChange);
    _phoneNoController.dispose();
    _viewProfileBloc.dispose();
  }

  void onFocusChange() {
    setState(() {
      _labelStyleFirstName = _firstNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleLastName = _lastNameFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleAddress = _addressFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStyleEmailId = _emailIDFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
      _labelStylePhoneNo = _phoneNoFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  _getViewProfile() async {
    _viewProfileBloc.postViewProfile.listen((value) {
      if (value.status == "error") {
        setState(() {
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
          _firstNameController.text =
              value.data!.customerDetails!.firstName.toString();
          _lastNameController.text =
              value.data!.customerDetails!.lastName.toString();
          _addressController.text =
              value.data!.customerDetails!.address.toString();
          _emailIDController.text =
              value.data!.customerDetails!.emailId.toString();
          _phoneNoController.text =
              value.data!.customerDetails!.phoneNo.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto_Regular',
                        ),
                        focusNode: _firstNameFocusNode,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        validator:
                            InputValidator(ch: "First name").nameChecking,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        controller: _firstNameController,
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'First Name',
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
                            labelStyle: _labelStyleFirstName),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        enabled: false,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto_Regular',
                        ),
                        focusNode: _lastNameFocusNode,
                        keyboardType: TextInputType.text,
                        validator:
                            InputValidator(ch: "First name").emptyChecking,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'First Name',
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
                            labelStyle: _labelStyleLastName),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 19.3),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        validator:
                            InputValidator(ch: "Email ID").emailValidator,
                        focusNode: _emailIDFocusNode,
                        controller: _emailIDController,
                        maxLines: 1,
                        enabled: false,
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
                          labelStyle: _labelStyleEmailId,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto_Regular',
                        ),
                        focusNode: _addressFocusNode,
                        keyboardType: TextInputType.text,
                        enabled: false,
                        validator: InputValidator(ch: "Address").emptyChecking,
                        controller: _addressController,
                        decoration: InputDecoration(
                            labelText: 'Address',
                            hintText: 'Address',
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
                            labelStyle: _labelStyleAddress),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
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
                                  enabled: false,
                                  focusNode: _phoneNoFocusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneNoController,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Roboto_Regular',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number*',
                                    hintText: 'Phone Number',
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
                                    labelStyle: _labelStylePhoneNo,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ))));
  }
}
