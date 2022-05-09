import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicMyJobReviewScreen extends StatefulWidget {

  MechanicMyJobReviewScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyJobReviewScreenState();
  }
}

class _MechanicMyJobReviewScreenState extends State<MechanicMyJobReviewScreen> {

  String authToken = "", mechanicId = "" ;
  MechanicMyJobReviewBloc _mechanicJobReviewBloc = MechanicMyJobReviewBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenApiResponse();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
      print('userFamilyId ' + authToken.toString());
      //print('userId ' + userId.toString());
      _mechanicJobReviewBloc.postMechanicFetchMyJobReviewRequest(authToken, mechanicId );
    });
  }

  _listenApiResponse() {

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Scaffold(
       backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Container(
                child: Stack(
                    children: [

                    ]
                ),
              ),
            ),
          ),
        ),
     ),
   );

  }

}