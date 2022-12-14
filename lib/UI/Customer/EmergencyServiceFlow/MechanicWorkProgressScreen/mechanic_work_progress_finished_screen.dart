import 'dart:async';
import 'dart:ui';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/ExtraDiagnosisScreen/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicWorkProgressScreen/mechanic_work_progress_working_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/PaymentScreens/mechanic_waiting_payment.dart';
import 'package:auto_fix/Widgets/Countdown.dart';
import 'package:auto_fix/Widgets/mechanicWorkTimer.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicWorkProgressFinishedScreen extends StatefulWidget {

  final String workStatus;
  final String bookingId;

  MechanicWorkProgressFinishedScreen({
    required this.workStatus,
    required this.bookingId
  });

  @override
  State<StatefulWidget> createState() {
    return _MechanicWorkProgressFinishedScreenState();
  }
}

class _MechanicWorkProgressFinishedScreenState extends State<MechanicWorkProgressFinishedScreen> with TickerProviderStateMixin{


  String workStatus = "";     // 1 - arrived - screen 075,
  // 2 - started working - screen 078,
  // 3 - completed - screen 079,
  // 4 - ready to pickup vehicle - screen 094
  // 5 - mechanic reached your location - screen 102

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String mechanicDiagonsisState = "0";
  String isWorkCompleted = "0";
  String isPaymentRequested = "0";

  String totalEstimatedTime = "00";
  String mechanicName = "";
  String bookingIdEmergency="";


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String authToken="";
  String userName="";


  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String extendedTime="0";
  String currentUpdatedTime="0";


  String extendedTimeFirstTymCall="0";




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    bookingIdEmergency = widget.bookingId;
    workStatus = widget.workStatus.toString();
  }

  @override
  void didUpdateWidget(covariant MechanicWorkProgressFinishedScreen oldWidget) {
    // TODO: implement didUpdateWidget
    getSharedPrefData();
    super.didUpdateWidget(oldWidget);
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
      serviceIdEmergency = shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
      mechanicIdEmergency = shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
      updateToCloudFirestoreMechanicCurrentScreenDB();
      listenToCloudFirestoreDB();
      print('MechanicWorkProgressScreen bookingIdEmergency ++++ ${bookingIdEmergency} ');

    });

    await _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots().listen((event) {
      setState(() {
        extendedTime= event.get("extendedTime");
        currentUpdatedTime = event.get("currentUpdatedTime");
        isPaymentRequested = event.get("isPaymentRequested");
        isWorkCompleted = event.get("isWorkCompleted");
        mechanicDiagonsisState = event.get("mechanicDiagonsisState");
        totalEstimatedTime = event.get('timerCounter');
        mechanicName = event.get('mechanicName');

      });
    });
  }

  void updateToCloudFirestoreMechanicCurrentScreenDB() {

    if(widget.workStatus == "1")
    {
      _firestore
          .collection("ResolMech")
          .doc('${bookingIdEmergency}')
          .update({
        "customerFromPage" : "C2",
      })
          .then((value) => print("Location Added"))
          .catchError((error) =>
          print("Failed to add Location: $error"));
    }
    else if(widget.workStatus == "2")
    {
      _firestore
          .collection("ResolMech")
          .doc('${bookingIdEmergency}')
          .update({
        "customerFromPage" : "C4",
      })
          .then((value) => print("Location Added"))
          .catchError((error) =>
          print("Failed to add Location: $error"));
    }
    else if(widget.workStatus == "3")
    {
      _firestore
          .collection("ResolMech")
          .doc('${bookingIdEmergency}')
          .update({
        "customerFromPage" : "C5",
      })
          .then((value) => print("Location Added"))
          .catchError((error) =>
          print("Failed to add Location: $error"));
    }

  }


  void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("$bookingIdEmergency");
    reference.snapshots().listen((querySnapshot) {
       if(widget.workStatus =="3") {
        isPaymentRequested = querySnapshot.get("isPaymentRequested");
        print('isPaymentRequested ++++ $isPaymentRequested');
      }
       if(widget.workStatus =="3")
      {
        if(isPaymentRequested =="1")
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MechanicWaitingPaymentScreen()));

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                startedWorkScreenTitle(size),

                startedWorkScreenTitleImage(size),

                startedWorkScreenBottomCurve(size),

                startedWorkScreenSuccess(size)

              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget startedWorkScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3 / 100,
      ),
      child: Text(
        'Job completed',
        style: Styles.workProgressTitleText,),
    );
  }

  Widget startedWorkScreenTitleImage(Size size){
    return Center(
      child: Container(
        height: 150,
        margin: EdgeInsets.only(
          left: size.width * 6 /100,
          right: size.width * 6 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.5 / 100,
        ),
        child: Image.asset('assets/image/img_started_work_bg.png',),
      ),
    );
  }

  Widget startedWorkScreenBottomCurve(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * 3.2 / 100,
        ),
        child: Stack(
          children: [
            curvedBottomContainer(
                size,
                "1",
                size.height * 14 / 100,
                Text(
                  "Hi, $userName, congratulations!,  Your mechanic completed his Work wait for the payment process",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                )
            ),

            Container(
              margin: EdgeInsets.only(
                  top: size.height * 9.3 / 100
              ),
              child: curvedBottomContainer(
                  size,
                  "2",
                  size.height * 19 / 100,
                  mechanicImageAndName(size)
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget curvedBottomContainer(Size size,String colorsInt,double height, Widget child){
    return Container(
      height: height,
      width: size.width,
      padding: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 8 / 100,
          top: size.width * 6 / 100
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: colorsInt == '1' ? CustColors.light_navy : CustColors.pale_grey,
      ),
      child: child,
    );
  }

  Widget mechanicImageAndName(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 2 / 100
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: CustColors.light_navy,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      70,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                child: Container(
                    child:CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child:SvgPicture.asset('assets/image/CustomerType/profileAvathar.svg')
                        ))),
                borderRadius: BorderRadius.circular(44),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 10 / 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$mechanicName",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.bold,
                ),),
              Text(
               "Completed his work",
                style: TextStyle(
                  fontSize: 8,
                  color: CustColors.light_navy,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w400,
                ),)
            ],
          ),

          //customerApprovedScreenTimer(size)
        ],
      ),
    );
  }

  Widget startedWorkScreenWarningText(Size size){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
            color: CustColors.greyish,
            width: 0.3
        ),
        color: CustColors.pale_grey,
      ),
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 4.8 / 100
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: size.width * 3 / 100,
                        bottom: size.width * 3 / 100
                    ),
                    child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
                      height: size.height * 3 / 100,width: size.width * 3 / 100,),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                "Wait for some time, your mechanic has started diagnostic test. He will complete the services requested.",
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: "Samsung_SharpSans_Regular",
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget startedWorkScreenSuccess(Size size){
    return Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  left: size.width * 2.5 / 100,
                  right: size.width * 2.5 / 100
              ),
              child: SvgPicture.asset(
                "assets/image/img_success_bg.svg",
                height: size.height * 28 / 100,
                width:size.width * 90 / 100,)),

          Container(
            alignment: Alignment.bottomCenter,
            child: Text("Job Completed successfully!",
              style: TextStyle(
                  fontSize: 20,
                  color: CustColors.light_navy
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }


}
