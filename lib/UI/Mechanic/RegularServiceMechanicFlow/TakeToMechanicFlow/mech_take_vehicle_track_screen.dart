import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceStatusUpdate/service_status_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechTakeVehicleTrackScreen extends StatefulWidget{

  final String bookedDate;
  //final String reachTime;
  final String bookedId;

  MechTakeVehicleTrackScreen({
    required this.bookedDate,
    //required this.reachTime,
    required this.bookedId,
  });

  @override
  State<StatefulWidget> createState() {
    return _MechTakeVehicleTrackScreen();
  }

}

class _MechTakeVehicleTrackScreen extends State <MechTakeVehicleTrackScreen>{

  final ServiceStatusUpdateBloc _serviceStatusUpdateBloc = ServiceStatusUpdateBloc();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String bookingDate = "";
  String isReachedServiceCenter = "-1";
  String isWorkStarted = "-1";
  String isWorkFinished = "-1";
  //String paymentStatus = "-1"; // -1 = no payment ; 0 = requested for payment ; 1 = customer paid ;
  //String paymentRecieved = "-1";
  String isPayment = "-1";
  String completed = "-1";
  String authToken = "";

  @override
  void initState(){
    listenToCloudFirestoreDB();
    getSharedPrefData();
    super.initState();

  }

  void listenToCloudFirestoreDB() {
    //_firestoreData = _firestore.collection("ResolMech").doc('$bookingId').snapshots();
    _firestore.collection("Regular-TakeVehicle").doc('${widget.bookedId}').snapshots().listen((event) {
      setState(() {
        bookingDate = event.get("bookingDate");
        isReachedServiceCenter = event.get("isReachedServiceCenter");
        isWorkStarted = event.get("isWorkStarted");
        isWorkFinished = event.get("isWorkFinished");
        //paymentStatus = event.get("paymentStatus");
       // paymentRecieved = event.get("paymentRecieved");
        isPayment = event.get("isPayment");
        completed = event.get("completed");
      });
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData MechTakeVehicleTrackScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
    });
  }

  void updateToCloudFirestoreDB(
      isReachedServiceCenter,
      isWorkStarted,
      isWorkFinished,
      isPayment,
      // paymentStatus,
      // paymentRecieved,
      completed
      ) {
    _firestore
        .collection("Regular-TakeVehicle")
        .doc('${widget.bookedId}')
        .update({
            'isReachedServiceCenter' : "$isReachedServiceCenter",
            'isWorkStarted' : "$isWorkStarted",
            'isWorkFinished' : "$isWorkFinished",
            'isPayment' : "$isPayment",
            //'paymentStatus' : "$paymentStatus",
            //'paymentRecieved' : "$paymentRecieved",
            'completed' : "$completed",
            //'isPaymentRequested': "1",
          })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  void updateFirestoreDB(String key, String value ) {
    _firestore
        .collection("${TextStrings.firebase_take_vehicle}")
        .doc('${widget.bookedId}')
        .update({
      "$key" : "$value",
      "${key}Time" : "${DateFormat("hh:mm a").format(DateTime.now())}",
    })
        .then((value) => print("Location Added >>> ${DateFormat("hh:mm a").format(DateTime.now())}"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomui(size),
                trackServiceBoxui(size),
                bookingRecievedUi(size),

                vehicleReachedUi(size),
                startedWorkUi(size),
                finishedWorkUi(size),
                //paymentRequestUi(size),
                //paymentAcceptUi(size),

                isWorkFinished == "-1" && isPayment == "-1" ?
                paymentOptionInActiveUi(size)
                    : (isWorkFinished == "0" && isPayment == "-1") || (isWorkFinished == "0" && isPayment == "0") ?
                paymentOptionWaitingActiveUi(size)
                    : isWorkFinished == "0" && isPayment == "1" ?
                paymentOptionActiveUi(size)
                    : paymentOptionFinishedUi(size),

                completedUi(size),
                textButtonUi(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomui(Size size){
    return Container(
      margin: EdgeInsets.only(
         // left: size.width * 10 / 100,
          //top: size.height * 3.3 / 100
      ),
      child: Stack(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: const Color(0xff707070)),
                //onPressed: () {  },
                onPressed: () => Navigator.pop(context),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget trackServiceBoxui(Size size){
    return Padding(
      padding: const EdgeInsets.only(left: 22.0,right: 22.0),
      child: Container(
        height: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustColors.light_navy,
        ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                    height: 50,
                    width:50,
                    child: Image.asset('assets/image/ic_clock.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('TRACK SERVICE',
                style: TextStyle(
                  fontFamily: 'SamsungSharpSans-Medium',
                  fontSize: 16,
                  //height: 30
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
      //),
    );
  }

  Widget bookingRecievedUi(Size size){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 30),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      //color: CustColors.light_navy,
                      child: SvgPicture.asset('assets/image/ic_calender.svg',
                        fit: BoxFit.contain,
                      color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                    SizedBox(height: 05),
                    Text(
                      //'Mar 5,2022',
                    '${widget.bookedDate}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                      color: const Color(0xff9b9b9b)
                    ),)
                  ],
                ),
              )
            ],
        ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,3,5,0),
            child: FDottedLine(
              color: CustColors.blue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleReachedUi(Size size){
    return Container(
      child: isReachedServiceCenter == "-1"
      ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // MainAxisSize.min,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy05,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_arrived_b.svg',
                        fit: BoxFit.contain,
                        color: CustColors.light_navy),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer Reached at',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('00:00',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text('TRACK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff919191),
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffc9d6f2),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,3,5,0),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      )
      : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // MainAxisSize.min,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_arrived_w.svg',
                          fit: BoxFit.contain,
                          color: CustColors.white_02),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer Reached at service center',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('${widget.reachTime}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          updateToCloudFirestoreDB(
                              '0',
                              '0',
                              '-1',
                              '-1',
                               '-1',
                               '-1'
                          );
                        });
                      },
                      child: Text('START',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustColors.white_02,
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: CustColors.light_navy,
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,3,5,0),
            child: FDottedLine(
              color: CustColors.light_navy,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget startedWorkUi(Size size){
    return Container(
      child: isReachedServiceCenter == '-1'
     ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy05,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_work_started_b.svg',
                        fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mechanic ready to started work',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('Mar 5,2022',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text('FINISH',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff919191),
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffc9d6f2),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      )
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_work_started_w.svg',
                        fit: BoxFit.contain,
                        color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mechanic ready to started work',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('Mar 5,2022',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 22.0,),
                child: isWorkStarted =='-1'
                ? Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          updateToCloudFirestoreDB('0', '0', '-1', '-1', '-1',);
                          _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "5");
                        });
                      },
                      child: Text('START',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustColors.white_02,
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: CustColors.light_navy,
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                )
                : Container(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,5),
            child: FDottedLine(
              color: CustColors.light_navy,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget finishedWorkUi(Size size){
    return Container(
      child: isWorkStarted == '-1'
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy05,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_work_finished_b.svg',
                        fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Service finished.',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('Mar 5,2022',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 22.0,),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text('FINISH',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff919191),
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffc9d6f2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
        ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,0),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
       ],
      )
      :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_work_finished_w.svg',
                        fit: BoxFit.contain,
                      color: CustColors.white_02),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Service finished.',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('Mar 5,2022',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: isWorkFinished == '-1'
                ? Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          updateToCloudFirestoreDB('0', '0', '0', '-1', '-1',);
                          _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "6");
                        });
                      },
                      child: Text('FINISH',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustColors.white_02,
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: CustColors.light_navy,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                )
                : Container(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,0),
            child: FDottedLine(
              color: CustColors.light_navy,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  // Widget paymentRequestUi(Size size){
  //   return Container(
  //     child: isWorkFinished == "-1"
  //     ? Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children:[
  //         Row(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 22.0,top: 00),
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children:[
  //                 Container(
  //                   height:50,
  //                   width: 50,
  //                   decoration: BoxDecoration(
  //                       color: CustColors.light_navy05,
  //                       borderRadius: BorderRadius.circular(25)
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 25,
  //                   width: 25,
  //                   child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_b.svg',
  //                     fit: BoxFit.contain,),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 22.0,top: 00),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Payment Requested',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontFamily: 'SamsungSharpSans-Medium',
  //                     ),),
  //                   /*SizedBox(height: 02),
  //                   Text('Mar 5,2022',
  //                     textAlign: TextAlign.start,
  //                     style: TextStyle(
  //                         fontSize: 12,
  //                         fontFamily: 'SamsungSharpSans-Medium',
  //                         color: const Color(0xff9b9b9b)
  //                     ),)*/
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(45,0,5,5),
  //           child: FDottedLine(
  //             color: CustColors.light_navy05,
  //             height: 50.0,
  //           ),
  //         ),
  //   ],
  //     )
  //     : Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children:[
  //         Row(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(left: 22.0,top: 00),
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children:[
  //                   Container(
  //                     height:50,
  //                     width: 50,
  //                     decoration: BoxDecoration(
  //                         color: CustColors.light_navy,
  //                         borderRadius: BorderRadius.circular(25)
  //                       //more than 50% of width makes circle
  //                     ),
  //                   ),
  //                   Container(
  //                     height: 25,
  //                     width: 25,
  //                     child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_w.svg',
  //                       fit: BoxFit.contain,
  //                       color: CustColors.white_02),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 22.0,top: 00),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('Payment Requested',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontFamily: 'SamsungSharpSans-Medium',
  //                       ),),
  //                    /* SizedBox(height: 02),
  //                     Text('Mar 5,2022',
  //                       textAlign: TextAlign.start,
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           fontFamily: 'SamsungSharpSans-Medium',
  //                           color: const Color(0xff9b9b9b)
  //                       ),)*/
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(right: 22.0,top: 05),
  //               child: isPayment == '-1'
  //               ? Container(
  //                 height: 23,
  //                 width: 64,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: const Color(0xffc9d6f2)
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(top: 00.0),
  //                   child: TextButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         updateToCloudFirestoreDB('0', '0', '0', '-1', '-1');
  //                         _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "7");
  //                       });
  //                     },
  //                     child: Text('REQUEST',
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: CustColors.white_02,
  //                         fontSize: 7,
  //                       ),
  //                     ),
  //                     style: ElevatedButton.styleFrom(
  //                       primary: CustColors.light_navy,
  //                       shape:
  //                       RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10)
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //               : paymentRecieved == '-1'
  //                   ? Container(
  //                       height: 23,
  //                       width: 64,
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                           color: const Color(0xffc9d6f2)
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 00.0),
  //                         child: TextButton(
  //                           onPressed: () {
  //                           },
  //                           child: Text('REQUESTED',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               color: CustColors.light_navy,
  //                               fontSize: 7,
  //                             ),
  //                           ),
  //                           style: ElevatedButton.styleFrom(
  //                             primary: CustColors.light_navy05,
  //                             shape:
  //                             RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(10)
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     )
  //                   : Container(),
  //             ),
  //           ],
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(45,0,5,5),
  //           child: FDottedLine(
  //             color: CustColors.light_navy,
  //             height: 50.0,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget paymentAcceptUi(Size size){
  //   return Container(
  //     child: paymentStatus == "0" || paymentStatus == "-1"
  //         ? Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children:[
  //               Row(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 22.0,top: 00),
  //                     child: Stack(
  //                       alignment: Alignment.center,
  //                       children:[
  //                         Container(
  //                           height:50,
  //                           width: 50,
  //                           decoration: BoxDecoration(
  //                               color: CustColors.light_navy05,
  //                               borderRadius: BorderRadius.circular(25)
  //                             //more than 50% of width makes circle
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 25,
  //                           width: 25,
  //                           child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_payment_b.svg',
  //                             fit: BoxFit.contain,),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(left: 22.0,top: 00),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text('Waiting for payment.',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               fontFamily: 'SamsungSharpSans-Medium',
  //                             ),),
  //                           /*SizedBox(height: 05),
  //                           Text('Mar 5,2022',
  //                             textAlign: TextAlign.start,
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 fontFamily: 'SamsungSharpSans-Medium',
  //                                 color: const Color(0xff9b9b9b)
  //                             ),)*/
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 22.0,top: 05),
  //                     child: Container(
  //                       height: 23,
  //                       width: 55,
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                           color: const Color(0xffc9d6f2)
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 00.0),
  //                         child: TextButton(
  //                           onPressed: () {
  //
  //                           },
  //                           child: Text('Received',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               color:  CustColors.light_navy,
  //                               fontSize: 08,
  //                             ),
  //                           ),
  //                           style: ElevatedButton.styleFrom(
  //                             primary: CustColors.light_navy05,
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(10)
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(45,5,5,0),
  //                 child: FDottedLine(
  //                   color: CustColors.light_navy05,
  //                   height: 50.0,
  //                 ),
  //               ),
  //             ],
  //           )
  //         : Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children:[
  //             Row(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 22.0,top: 00),
  //                   child: Stack(
  //                     alignment: Alignment.center,
  //                     children:[
  //                       Container(
  //                         height:50,
  //                         width: 50,
  //                         decoration: BoxDecoration(
  //                             color: CustColors.light_navy,
  //                             borderRadius: BorderRadius.circular(25)
  //                           //more than 50% of width makes circle
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 25,
  //                         width: 25,
  //                         child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_payment_w.svg',
  //                             fit: BoxFit.contain,
  //                             color: CustColors.white_02),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(left: 22.0,top: 00),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(paymentRecieved=='-1' ? 'Waiting for payment.':'Payment received.',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontFamily: 'SamsungSharpSans-Medium',
  //                           ),),
  //                         /*SizedBox(height: 05),
  //                         Text('Mar 5,2022',
  //                           textAlign: TextAlign.start,
  //                           style: TextStyle(
  //                               fontSize: 12,
  //                               fontFamily: 'SamsungSharpSans-Medium',
  //                               color: const Color(0xff9b9b9b)
  //                           ),)*/
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 22.0,top: 05),
  //                   child: paymentRecieved=='-1'
  //                       ? Container(
  //                         height: 23,
  //                         width: 55,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             color: const Color(0xffc9d6f2)
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(top: 00.0),
  //                           child: TextButton(
  //                             onPressed: () {
  //                               setState(() {
  //                                 updateToCloudFirestoreDB('0', '0', '0', '1', '0', '0');
  //                                 _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "8");
  //                               });
  //                             },
  //                             child: Text('Received',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 08,
  //                               ),
  //                             ),
  //                             style: ElevatedButton.styleFrom(
  //                               primary: CustColors.light_navy,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10)
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                       : Container(),
  //                 ),
  //               ],
  //             ),
  //             Padding(
  //                 padding: const EdgeInsets.fromLTRB(45,5,5,0),
  //                 child: FDottedLine(
  //                   color: CustColors.light_navy,
  //                   height: 50.0,
  //                 ),
  //               ),
  //           ],
  //         ),
  //   );
  // }


  Widget paymentOptionInActiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy05,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_b.svg',
                        fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex:200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                      /*Text('Mar 5,2022',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text('TRACK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff919191),
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffc9d6f2),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              SizedBox(height: 20)
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,0),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentOptionActiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_w.svg',
                        fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex:200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                      /*Text('Mar 5,2022',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {
                        updateFirestoreDB("isPayment","5");
                      },
                      child: Text('Received',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CustColors.white_02,
                            fontSize: 08,
                          )
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: CustColors.light_navy,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,0),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentOptionWaitingActiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy05,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_b.svg',
                        fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex:200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment waiting...',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,0),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentOptionFinishedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_w.svg',
                        fit: BoxFit.contain,
                        //color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex:200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Received Payment',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('at ${isPaymentTime}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)*/
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffc9d6f2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 00.0),
                    child: TextButton(
                      onPressed: () {  },
                      child: Text('TRACK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff919191),
                          fontSize: 08,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffc9d6f2),
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              SizedBox(height: 20)
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,5,5,0),
            child: FDottedLine(
              color: CustColors.light_navy,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }


  Widget completedUi(Size size){
    return Container(
      child: completed == '-1'
      ? Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 00),
            child: Stack(
              alignment: Alignment.center,
              children:[
                Container(
                  height:50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: CustColors.light_navy05,
                      borderRadius: BorderRadius.circular(25)
                    //more than 50% of width makes circle
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_service_completed_b.svg',
                    fit: BoxFit.contain,),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                ],
              ),
            ),
          ),
        ],
      )
      : Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 00),
            child: Stack(
              alignment: Alignment.center,
              children:[
                Container(
                  height:50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: CustColors.light_navy,
                      borderRadius: BorderRadius.circular(25)
                    //more than 50% of width makes circle
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_service_completed_w.svg',
                    fit: BoxFit.contain,
                  color: CustColors.white_02),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textButtonUi (Size size){
    return Container(
      child: Row(
        children:[
          Container(
            height: 10,
            width: 10,
            color: Colors.white,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 22.0,top: 15,bottom: 20),
            child: Container(
              width: 130,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MechanicHomeScreen()));
                },
                child: Text('Back to home',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'SamsungSharpSans-Medium',
                  color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  primary: CustColors.light_navy,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
        ),
            ),
          ),
          SizedBox(height: 20)
    ]
      ),

    );
  }

}