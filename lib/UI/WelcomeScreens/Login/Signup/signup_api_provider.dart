// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersCorporateSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersGovernmentSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersIndividualSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicCorporateSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicIndividualSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/states_mdl.dart';

import 'package:flutter/services.dart';

import '../PhoneLogin/otp_Verification_Mdl.dart';

class SignupApiProvider {

  final QueryProvider _queryProvider = QueryProvider();



  Future<CustomersSignUpIndividualMdl> getSignUpCustomerIndividualRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String profilepic) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpCustomerIndividual(firstName, lastName, email, state, password, phone,profilepic);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomersSignUpIndividualMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomersSignUpIndividualMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomersSignUpIndividualMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<CustomersSignUpCorporateMdl> getSignUpCustomerCorporateRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String orgName,
      String orgType,
      String profilepic) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpCustomerCorporate(firstName, lastName, email, state, password, phone,orgName,orgType,profilepic);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomersSignUpCorporateMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomersSignUpCorporateMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomersSignUpCorporateMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustomersSignUpGovtBodiesMdl> getSignUpCustomerGovtBodiesRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String govt_agency,
      String govt_type,
      String profilepic) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpCustomerGovtBodies(firstName, lastName, email, state, password, phone,govt_agency,govt_type,profilepic);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomersSignUpGovtBodiesMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomersSignUpGovtBodiesMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomersSignUpGovtBodiesMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<MechanicSignUpMdl> getSignUpMechanicIndividualRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String latitude,
      String longitude,
      String year_of_experience,
      String profilepic) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpMechanicIndividual(firstName, lastName, email, state, password, phone, latitude,  longitude,
      year_of_experience,profilepic);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicSignUpMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicSignUpMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicSignUpMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<MechanicSignUpCorporateMdl> getSignUpMechanicCorporateRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String latitude,
      String longitude,
      String year_of_experience,String orgName,String orgType,
      String profilepic) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpMechanicCorporate(firstName, lastName, email, state, password, phone, latitude,  longitude,
      year_of_experience, orgName, orgType,profilepic);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicSignUpCorporateMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicSignUpCorporateMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicSignUpCorporateMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<OtpVerificationMdl> postOtpVerificationRequest(
      token,
      otp,) async {
    Map<String, dynamic> _resp = await _queryProvider.postOtpVerificationRequest(
      token,
      otp,);
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
