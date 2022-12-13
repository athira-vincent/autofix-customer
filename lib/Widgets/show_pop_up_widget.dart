import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowPopUpWidget {
  void showPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.text_Confirm_Exit,
                style: TextStyle(
                  fontFamily: 'Formular',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: CustColors.materialBlue,
                )),
            content: Text(AppLocalizations.of(context)!.text_sure_exit),
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
                  child: Text(AppLocalizations.of(context)!.text_No)),
              CupertinoDialogAction(
                  textStyle: TextStyle(
                    color: CustColors.rusty_red,
                    fontWeight: FontWeight.normal,
                  ),
                  isDefaultAction: true,
                  onPressed: () async {
                    SystemNavigator.pop();
                  },
                  child: Text(AppLocalizations.of(context)!.text_Yes)),
            ],
          );
        });
  }

  void showdeletePopUp(BuildContext context, String productid) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(AppLocalizations.of(context)!.text_Confirm,
                style: TextStyle(
                  fontFamily: 'Formular',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: CustColors.materialBlue,
                )),
            content: const Text(AppLocalizations.of(context)!.text_sure_delete),
            actions: <Widget>[
              CupertinoDialogAction(
                  textStyle: const TextStyle(
                    color: CustColors.rusty_red,
                    fontWeight: FontWeight.normal,
                  ),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.text_No)),
              CupertinoDialogAction(
                  textStyle: const TextStyle(
                    color: CustColors.rusty_red,
                    fontWeight: FontWeight.normal,
                  ),
                  isDefaultAction: true,
                  onPressed: () async {

                  },
                  child: const Text(AppLocalizations.of(context)!.text_Yes)),
            ],
          );
        });
  }
}
