// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/states_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/signUp_Mdl.dart';

import 'package:flutter/services.dart';

import '../../../Customer/BottomBar/Home/HomeCustomer/ModelsCustomerHome/mechanics_Booking_Mdl.dart';
import '../PhoneLogin/OtpModels/otp_Verification_Mdl.dart';
import '../PhoneLogin/OtpModels/phoneLoginOtpVerificationMdl.dart';

class SignupApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<SignUpMdl> signUp( type, firstName, lastName, emailId, phoneNo, password, state,
      fcmToken, userTypeId, userType, profilepic, orgName, orgType,
      ministryName, hod, latitude, longitude, yearExp, shopName,)  async {
    Map<String, dynamic> _resp = await _queryProvider.signUp( type, firstName, lastName,
      emailId, phoneNo, password, state,
      fcmToken, userTypeId, userType, profilepic, orgName, orgType,
      ministryName, hod, latitude, longitude, yearExp, shopName,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SignUpMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SignUpMdl.fromJson(data);
      }
    } else {
      final errorMsg = SignUpMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<OtpVerificationMdl> postOtpVerificationRequest(
      token,
      otp,
      userTypeId) async {
    Map<String, dynamic> _resp = await _queryProvider.postOtpVerificationRequest(
      token,
      otp,
      userTypeId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = OtpVerificationMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return OtpVerificationMdl.fromJson(data);
      }
    } else {
      final errorMsg = OtpVerificationMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<PhoneLoginOtpVerificationMdl> postPhoneLoginOtpVerificationRequest(
      token,
      otp,
      userTypeId) async {
    Map<String, dynamic> _resp = await _queryProvider.postPhoneLoginOtpVerificationRequest(
        token,
        otp,
        userTypeId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = PhoneLoginOtpVerificationMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return PhoneLoginOtpVerificationMdl.fromJson(data);
      }
    } else {
      final errorMsg = PhoneLoginOtpVerificationMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }




  Future<dynamic> getStates() async {
    dynamic response = await loadStates();
    return StatesMdl.fromJson(response);
  }

  Future<dynamic> loadStates() async {
    print('here');
    String jsonCrossword = await loadStatesAsset();
    final response = json.decode(jsonCrossword);
    return response;
  }

  Future<dynamic> loadStatesAsset() async {
    return await rootBundle.loadString('assets/json/states_list.json');
  }
}
