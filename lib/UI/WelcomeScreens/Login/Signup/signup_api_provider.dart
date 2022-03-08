// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersSignUp_Individual_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';

import 'package:flutter/services.dart';

class SignupApiProvider {

  final QueryProvider _queryProvider = QueryProvider();



  Future<CustomersSignUpIndividualMdl> getSignUpCustomerIndividualRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpCustomerIndividual(firstName, lastName, email, state, password, phone);
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


  Future<CustomersSignUpIndividualMdl> getSignUpCustomerCorporateRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String orgName,
      String orgType,) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpCustomerCorporate(firstName, lastName, email, state, password, phone,orgName,orgType);
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

  Future<CustomersSignUpIndividualMdl> getSignUpCustomerGovtBodiesRequest(
      String firstName,
      String lastName,
      String email,
      String state,
      String password,
      String phone,
      String orgName,
      String orgType,) async {
    Map<String, dynamic> _resp = await _queryProvider.signUpCustomerGovtBodies(firstName, lastName, email, state, password, phone,orgName,orgType);
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
