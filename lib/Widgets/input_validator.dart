// ignore_for_file: avoid_print

import 'package:auto_fix/Constants/text_strings.dart';

class InputValidator {
  final String? ch;
  InputValidator({required this.ch});
  String? nameChecking(String? value) {
    String pattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty && ch != "Last name") {
      return ch.toString() + " is " + TextStrings.errRequired;
    }
    if (value.isEmpty && ch == "Last name") return null;
    if (ch != "Last name") {
      if (value.length < 2) {
        return TextStrings.invalidName;
      }
    }
    if (value.length > 100) return TextStrings.invalidName;
    if (!regExp.hasMatch(value)) {
      return TextStrings.invalidName;
    } else {
      return "";
    }
  }

  String emptyChecking(String? value) {
    if (value!.isEmpty) {
      return ch! + " is " + TextStrings.errRequired;
    } else {
      return "";
    }
  }

  String emailValidator(String? value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    print(value);
    if (value!.isEmpty) return ch! + " is " + TextStrings.errRequired;
    if (!regex.hasMatch(value)) {
      return TextStrings.errIncorrectMail;
    } else {
      return "";
    }
  }

  String passwordChecking(String? value) {
    // String pattern =
    //     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&_])[A-Za-z\d@$!%*#?&_]{8,}$';
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[A-Za-z\d@$!%*#?&_]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) return ch! + " is " + TextStrings.errRequired;

    // if (value.length < 8) {
    //   return Txt.passwordLength;
    // }

    if (!regExp.hasMatch(value) || value.length < 8) {
      return TextStrings.weakPassword;
    } else {
      return "";
    }
  }
}
