import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughPages  extends StatefulWidget {
  @override
  WalkThroughPagesState createState() => WalkThroughPagesState();
}

class WalkThroughPagesState extends State<WalkThroughPages> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       width:double.infinity,
       height: double.infinity,
       alignment: Alignment.bottomRight,

       child: FlatButton(

         onPressed: () {
           setIswalked();

           Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                   builder: (context) => UserSelectionScreen()));
         },
         child: Text(
           "Skip",
           style: TextStyle(
               fontWeight: FontWeight.bold,
               color: Colors.black,
               fontSize: 25),
         ),
         splashColor: Colors.white,
         color: Colors.white,
         shape: RoundedRectangleBorder(
             borderRadius:
             BorderRadius.circular(25)),
       ),
     ),
   );
  }


  void setIswalked()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isWalked, true);
  }


}