import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowPopUpWidget  {
  void showPopUp(BuildContext context){
    showDialog(context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text("Confirm Exit",
                style: TextStyle(
                  fontFamily: 'Formular',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: CustColors.materialBlue,
                )),
            content: Text("Are you sure you want to exit?"),
            actions: <Widget>[
              CupertinoDialogAction(
                  textStyle: TextStyle(
                    color: CustColors.rusty_red,
                    fontWeight: FontWeight.normal,
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
              CupertinoDialogAction(
                  textStyle: TextStyle(
                    color: CustColors.rusty_red,
                    fontWeight: FontWeight.normal,
                  ),
                  isDefaultAction: true,
                  onPressed: () async {
                    SystemNavigator.pop();
                  },
                  child: Text("Yes")),
            ],
          );
      /*    return AlertDialog(
            title: Text('Confirm'),
            content: Text('Do you want to exit?'),
            actions: <Widget>[
              RaisedButton(
                child: Text('No'),
                color: Colors.white,
                onPressed: (){
                  Navigator.of(context).pop();
                },),
              RaisedButton(
                  child: Text("Yes"),
                  color: Colors.white,
                  onPressed: (){
                    SystemNavigator.pop();
                  }
              )
            ],
          );*/
        }
    );
  }

}
