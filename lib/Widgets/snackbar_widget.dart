import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class SnackBarWidget  {

  void setSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$message',
          style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
      duration: Duration(seconds: 3),
      backgroundColor: CustColors.light_navy,
    ));
  }

  void setMaterialSnackBar(String message,GlobalKey<ScaffoldState> _scaffoldKey){

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: CustColors.light_navy,
      duration: Duration(seconds: 5),

    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

/*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  content: Text(,
  style: const TextStyle(
  fontFamily: 'Roboto_Regular',
  fontWeight: FontWeight.w600,
  fontSize: 14)),
  duration: const Duration(seconds: 2),
  backgroundColor: CustColors.peaGreen,
  ));
  */

}