import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class SnackBarWidget  {
  void setSnackBar(String msg, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$msg',
          style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
      duration: Duration(seconds: 2),
      backgroundColor: CustColors.peaGreen,
    ));
  }

}