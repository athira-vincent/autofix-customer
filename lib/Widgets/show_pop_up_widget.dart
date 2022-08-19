import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPopUpWidget {
  void showPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
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
        });
  }

  void showdeletePopUp(BuildContext context, String productid) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Confirm",
                style: TextStyle(
                  fontFamily: 'Formular',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: CustColors.materialBlue,
                )),
            content: const Text("Are you sure you want to delete?"),
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
                  child: Text("No")),
              CupertinoDialogAction(
                  textStyle: const TextStyle(
                    color: CustColors.rusty_red,
                    fontWeight: FontWeight.normal,
                  ),
                  isDefaultAction: true,
                  onPressed: () async {
                    final deletcartBloc =
                    BlocProvider.of<DeleteCartBloc>(context);
                    deletcartBloc.add(FetchDeleteCartEvent(productid));
                    Navigator.pop(context);
                    final addcartsBloc =
                    BlocProvider.of<ShowCartPopBloc>(context);
                    addcartsBloc.add(FetchShowCartPopEvent());
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}
