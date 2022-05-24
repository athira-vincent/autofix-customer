import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_waiting_payment.dart';
import 'package:auto_fix/Widgets/Countdown.dart';
import 'package:auto_fix/Widgets/count_down_widget.dart';
import 'package:auto_fix/Widgets/mechanicWorkTimer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicWorkProgressScreen extends StatefulWidget {

  final String workStatus;

  MechanicWorkProgressScreen({required this.workStatus});

  @override
  State<StatefulWidget> createState() {
    return _MechanicWorkProgressScreenState();
  }
}

class _MechanicWorkProgressScreenState extends State<MechanicWorkProgressScreen> with TickerProviderStateMixin{


  String workStatus = "";     // 1 - arrived - screen 075,
  // 2 - started working - screen 078,
  // 3 - completed - screen 079,
  // 4 - ready to pickup vehicle - screen 094
  // 5 - mechanic reached your location - screen 102

  Timer? timerObjVar;
  Timer? timerObj;
  String mechanicDiagonsisState = "0";
  String isWorkCompleted = "0";
  String isPaymentRequested = "0";

  String totalEstimatedTime = "00.00";
  String mechanicName = "";
  String bookingIdEmergency="";


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String authToken="";
  String userName="";


  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String extendedTimeFromFirestore="0";

  String extendedTimeFirstTymCall="0";

  late AnimationController _controller;
  int levelClock = 0;
  int levelClock1 = 0;

  Timer? timerForCouterTime;
  Timer? timerCouterTime;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    workStatus = widget.workStatus.toString();
    timerObj = Timer.periodic(Duration(seconds: 5), (Timer t) {
      timerObjVar = t;
      print('Timer listenToCloudFirestoreDB ++++++');

      listenToCloudFirestoreDB();
    });


    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );

  }

  @override
  void didUpdateWidget(covariant MechanicWorkProgressScreen oldWidget) {
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
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('MechanicWorkProgressScreen bookingIdEmergency ++++ ${bookingIdEmergency} ');

    });

    await _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots().listen((event) {
      setState(() {
        extendedTimeFromFirestore = event.get("extendedTime");
        isPaymentRequested = event.get("isPaymentRequested");
        isWorkCompleted = event.get("isWorkCompleted");
        mechanicDiagonsisState = event.get("mechanicDiagonsisState");
        totalEstimatedTime = event.get('updatedServiceTime');
        mechanicName = event.get('mechanicName');
        print('_firestoreData>>>>>>>>> ' + event.get('serviceName'));
        int sec = Duration(minutes: int.parse('${totalEstimatedTime.split(":").first}')).inSeconds;
        levelClock = sec;
        _controller = AnimationController(
            vsync: this,
            duration: Duration(
                seconds: levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );
        _controller.forward();

      });

    });
  }


  void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("$bookingIdEmergency");
    reference.snapshots().listen((querySnapshot) {
      setState(() {

        if(widget.workStatus =="1") {
          mechanicDiagonsisState = querySnapshot.get("mechanicDiagonsisState");
          print('mechanicDiagonsisState ++++ $mechanicDiagonsisState');

        }
        else if(widget.workStatus =="2") {
          isWorkCompleted = querySnapshot.get("isWorkCompleted");
          print('isWorkCompleted ++++ $isWorkCompleted');

          extendedTimeFromFirestore = querySnapshot.get("extendedTime");
          int sec = Duration(minutes: int.parse('$extendedTimeFromFirestore')).inSeconds;
          if(extendedTimeFromFirestore.toString() != "0")
          {
            if(extendedTimeFirstTymCall == "0")
            {
              extendedTimeFirstTymCall = "1";
              print('levelClock  levelClock1 ++++ ${levelClock}');
              levelClock1 = levelClock + sec ;
              print('levelClock  levelClock2 ++++ ${levelClock1}');


              _controller.stop();
              _controller = AnimationController(
                  vsync: this,
                  duration: Duration(
                      seconds: levelClock1) // gameData.levelClock is a user entered number elsewhere in the applciation
              );
              print('${_controller.status}');
              _controller.forward();
            }

          }

        }
        else if(widget.workStatus =="3") {
          isPaymentRequested = querySnapshot.get("isPaymentRequested");
          print('isPaymentRequested ++++ $isPaymentRequested');
        }


        if(widget.workStatus =="1")
        {
          if(mechanicDiagonsisState =="1")
          {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ExtraServiceDiagonsisScreen(isEmergency: true,)
                )).then((value){
            });
          }
        }
        else if(widget.workStatus =="2")
        {
          if(isWorkCompleted =="1")
          {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicWorkProgressScreen(workStatus: "3",))
            ).then((value){
            });
          }
        }
        else if(widget.workStatus =="3")
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
    });
  }


  void changeScreen(){
    if(workStatus == "1"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ExtraServiceDiagonsisScreen(isEmergency: true,)));
    }else if(workStatus == "2"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MechanicWorkProgressScreen(workStatus: "3",)));
    }else if(workStatus == "3"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MechanicWaitingPaymentScreen()));
    }
    else if(workStatus == "4"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ExtraServiceDiagonsisScreen(isEmergency: false,)));
    }
    else if(workStatus == "5"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ExtraServiceDiagonsisScreen(isEmergency: false,)));
    }
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      startedWorkScreenTitle(size),

                      startedWorkScreenTitleImage(size),

                      startedWorkScreenBottomCurve(size),

                      workStatus == "2"
                          ? startedWorkScreenTimer(size)
                          : workStatus == "3"
                          ? startedWorkScreenSuccess(size)
                          : startedWorkScreenWarningText(size) ,
                    ],
                ),
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
        workStatus == "1" ?
          "Mechanic arrived"
            :
            workStatus == "2" ?
              "Mechanic start repair"
                :
            workStatus == "3"?
            "Job completed"
                :
            workStatus == "4"?
            "Ready to pick up your vehicle "
                :
            "Mechanic reached your location.",
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
          //left: size.width * 6 /100,
          //right: size.width * 6 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.4 / 100,
        ),
        child: Stack(
          children: [
            curvedBottomContainer(
              size,
              "1",
              size.height * 14 / 100,
              Text(
                workStatus == "1"
                    ? "Hi.. $userName congratulations! Your mechanic reached near you. He fix your vehicle faults."
                    : workStatus == "2"
                    ? "Hi.. $userName congratulations! Your mechanic started repair your vehicle. Wait for the count down stop."
                    : workStatus == "3"
                    ? "Hi.. $userName congratulations!  Your mechanic completed his Work wait for the payment process"
                    : "Hi.. $userName congratulations!  Your mechanic reached near you. He list your vehicle faults.Then read the estimate. if you can afford the service charge  then agree. ",

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
               //workStatus == "1" ? "Started diagnostic test!" :
                workStatus == "2" ? "Started repair" :
                workStatus == "3" ? "Completed his work" : "Started diagnostic test!",
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
                "Wait for some time. Mechanic started diagnostic test. He will finalise the service you needed",
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


  Widget startedWorkScreenTimer(Size size){
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SvgPicture.asset('assets/image/ic_alarm.svg',
                  width: size.width * 4 / 100,
                  height: size.height * 4 / 100,),
                SizedBox(width: 20,),
                /*Expanded(
                  child: Text("$totalEstimatedTime",
                    style: TextStyle(
                        fontSize: 36,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: .7
                    ),
                  ),
                ),*/
                CountdownMechanicTimer(
                  animation: StepTween(
                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_controller),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
                border: Border.all(
                    color: CustColors.light_navy02,
                    width: 0.3
                )
            ),
            padding: EdgeInsets.only(
              left: size.width * 4 / 100,
              right: size.width * 4 / 100,
              top: size.height * 1 / 100,
              bottom: size.height * 1 / 100,
            ),
            child: Text("Total estimated time "),
          )
        ],
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
    // TODO: implement dispose
    _controller.dispose();
    cancelTimer1();
    if(widget.workStatus =="3") {
      cancelTimer();
    }
    super.dispose();
    print("dispose");
  }

  cancelTimer() {

    if (timerObjVar != null) {
      timerObjVar?.cancel();
      timerObjVar = null;
    }

    if (timerObj != null) {
      timerObj?.cancel();
      timerObj = null;
    }
  }

  cancelTimer1() {

    if (timerForCouterTime != null) {
      timerForCouterTime?.cancel();
      timerForCouterTime = null;
    }

    if (timerCouterTime != null) {
      timerCouterTime?.cancel();
      timerCouterTime = null;
    }
  }

}