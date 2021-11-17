// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_mdl.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/states_mdl.dart';
import 'package:flutter/services.dart';

class SignupApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<SignupMdl> getSignUpRequest(String firstName, String userName,
      String email, String state, String password, String phone) async {
    Map<String, dynamic> _resp = await _queryProvider.signUp(
        firstName, userName, email, state, password, phone);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SignupMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SignupMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          SignupMdl(status: "error", message: "No Internet connection");
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
