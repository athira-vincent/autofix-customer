import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserSelectionScreenState();
  }

}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => const ()));
              },
              child: Container(
                color: Colors.blue,
                child: Text("Mechanic", style: TextStyle(height: 2,),),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SigninScreen()));
              },
              child: Container(
                color: Colors.pink,
                child: Text("Customer",style: TextStyle(height: 2,),),
              ),
            ),
            GestureDetector(
              onTap: (){
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: Container(
                color: Colors.yellowAccent,
                child: Text("Vendor",style: TextStyle(height: 2,),),
              ),
            )
          ],
        ),
      ),
    );
  }


  void setUserType(String userType)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.userType, userType);
  }


}