import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'find_mechanic_by_customer_screen.dart';

class CustTakeVehicleTrackScreen01 extends StatefulWidget {

  final String bookedDate;
  final String latitude;
  final String longitude;
  final String goTime;
  //final String reachTime;
  final String bookedId;

  CustTakeVehicleTrackScreen01({
    required this.bookedDate,
    required this.latitude,
    //required this.reachTime,
    required this.longitude,
    required this.goTime,
    required this.bookedId,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustTakeVehicleTrackScreen01();
  }

}

class _CustTakeVehicleTrackScreen01 extends State <CustTakeVehicleTrackScreen01>{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String bookingDate = "", scheduledDate = "", scheduledTime = "";
  String isDriveStarted = "-1";
  String isArrived = "-1", isBookedDate = "-1";
  String isReachedServiceCenter = "-1";
  String isWorkStarted = "-1";
  String isWorkFinished = "-1", isPayment = "-1";
  /*String paymentStatus = "-1";
  String paymentRecieved = "-1";*/
  String completed = "-1";
  DateTime dateToday = DateTime.now() ;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    listenToCloudFirestoreDB();

  }

  void listenToCloudFirestoreDB() {
    print('${widget.bookedId} ?????? bookedId');
    _firestore.collection("Regular-TakeVehicle").doc('${widget.bookedId}').snapshots().listen((event) {
      setState(() {
        bookingDate = event.get("bookingDate");
        scheduledDate = event.get("scheduledDate");
        print("scheduledDate >>>> ${scheduledDate}");
        scheduledTime = event.get("scheduledTime");
        isBookedDate = event.get("isBookedDate");
        isDriveStarted = event.get("isDriveStarted");
        isArrived = event.get("isArrived");
        isReachedServiceCenter = event.get("isReachedServiceCenter");
        isWorkStarted = event.get("isWorkStarted");
        isWorkFinished = event.get("isWorkFinished");
        isPayment = event.get("isPayment");
       // paymentStatus = event.get("paymentStatus");
        //paymentRecieved = event.get("paymentRecieved");
        completed = event.get("completed");
      });
      if(scheduledDate.isNotEmpty){
        DateTime tempDate =  DateFormat("yyyy-MM-dd").parse(scheduledDate);

        if(tempDate.compareTo(dateToday) == 0 || tempDate.compareTo(dateToday) == -1){
          setState(() {
            //isBookedDate = "0";
            updateBookDateToCloudFirestoreDB("isBookedDate","0");
            print(" >>>>> isBookedDate >>>" + scheduledDate);
          });
        }
      }
    });
  }

  void updateBookDateToCloudFirestoreDB(String key, String value ) {
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

  void updateToCloudFirestoreDB(
    isDriveStarted ,
    isReachedServiceCenter ,
    isWorkStarted ,
    isWorkFinished ,
    paymentStatus) {
    _firestore
        .collection("Regular-TakeVehicle")
        .doc('${widget.bookedId}')
        .update({
      'isDriveStarted' : "$isDriveStarted",
      'isReachedServiceCenter' : "$isReachedServiceCenter",
      'isWorkStarted' : "$isWorkStarted",
      'isWorkFinished' : "$isWorkFinished",
      'paymentStatus' : "$paymentStatus",
     // 'paymentRecieved' : "$paymentRecieved"
      //'isPaymentRequested': "1",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading == true
            ?
        Container(
            width: size.width,
            height: size.height,
            child: Center(child: CircularProgressIndicator(color: CustColors.light_navy)))
            :
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomui(size),
                trackServiceBoxui(size),
                serviceBookedUi(size),
                vehicleStartedFromUi(size),
                reachedWorkShopUi(size),
                startedWorkUi(size),
                finishedWorkUi(size),

                //paymentRequestUi(size),
                isWorkFinished == "-1" && isPayment == "-1" ?
                paymentOptionInActiveUi(size)
                    : isWorkFinished == "0" && isPayment == "5" ?
                paymentOptionFinishedUi(size)
                    : paymentOptionActiveUi(size),

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
        //color: CustColors.light_navy,
        height: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustColors.light_navy,
        ),
        // child: Container(
        //
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10)
        //   ),
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

  Widget serviceBookedUi(Size size){
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
                    child: SvgPicture.asset('assets/image/ic_calender.svg',
                      fit: BoxFit.contain,
                    color: Colors.white,),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
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
                      //bookingDate.toString(),
                      '${bookingDate}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                      ),)
                  ],
                ),
              ),
            ),
            isBookedDate != "-1"
                ?
            Padding(
              padding: const EdgeInsets.only(right: 22.0,top: 15),
              child: isDriveStarted == '-1'
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
                        updateToCloudFirestoreDB(
                            '0',
                            '-1',
                            '-1',
                            '-1',
                            '-1',
                        );
                      });
                    },
                    child: Text('START',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDriveStarted == '-1' ? CustColors.white_02 : CustColors.light_navy,
                        fontSize: 08,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isDriveStarted == '-1' ? CustColors.light_navy : CustColors.light_navy05,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
              )
              : Container(),
            )
                :
            Container()
            ,
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

  Widget vehicleStartedFromUi(Size size){
  return Container(
    child: isDriveStarted == "-1"
    ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                        child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_drive_started_b.svg',
                          fit: BoxFit.contain,
                          //color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Go to Mechanic ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                      ),),
                    SizedBox(height: 02),
                    Text(
                      //'Savannah estate, plot 176',
                      'on : ${scheduledDate}\nat : ${scheduledTime}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                          color: const Color(0xff9b9b9b)
                      ),),
                    SizedBox(height: 02),
                    // Text('Mar 5,2022',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       fontSize: 12,
                    //       fontFamily: 'SamsungSharpSans-Medium',
                    //       color: const Color(0xff9b9b9b)
                    //   ),)
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
          padding: const EdgeInsets.fromLTRB(45,0,5,5),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                        child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_drive_started_w.svg',
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Go to Mechanic ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                      ),),
                    SizedBox(height: 02),
                    Text(
                      //'Savannah estate, plot 176',
                      '${widget.goTime}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                          color: const Color(0xff9b9b9b)
                      ),),
                    SizedBox(height: 02),
                    // Text('Mar 5,2022',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       fontSize: 12,
                    //       fontFamily: 'SamsungSharpSans-Medium',
                    //       color: const Color(0xff9b9b9b)
                    //   ),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 22.0,top: 05),
              child: isArrived == '-1'
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FindMechanicByCustomerScreen(
                            bookingId: '${widget.bookedId}',
                            longitude: '${widget.longitude}',
                            latitude: '${widget.latitude}',)));
                            setState(() {
                              // updateToCloudFirestoreDB(
                              //     '0',
                              //     '0',
                              //     '-1',
                              //     '-1',
                              //     '-1',
                              // );
                            });
                    },
                    child: Text('TRACK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        //color: const Color(0xff919191),
                        color: Colors.white,
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
          padding: const EdgeInsets.fromLTRB(45,0,5,5),
          child: FDottedLine(
            color: CustColors.light_navy,
            height: 50.0,
          ),
        ),
      ],
    ),
  );
}

  Widget reachedWorkShopUi(Size size){
    return Container(
      child: isArrived == "-1"
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
                          child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_arrived_b.svg',
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
                          Text('Reached Service Center',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SamsungSharpSans-Medium',
                            ),),
                         /* SizedBox(height: 05),
                          Text(
                            //'Mar 5,2022',
                            '${widget.reachTime}',
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
                            child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_arrived_w.svg',
                              fit: BoxFit.contain,
                            color: Colors.white,),
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
                            Text('Reached service center',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            /*SizedBox(height: 05),
                            Text(
                              //'Mar 5,2022',
                              '${widget.reachTime}',
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

  Widget startedWorkUi(Size size){
    return Container(
      child: isWorkStarted == "-1"
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
                            Text('Work Started',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            /*SizedBox(height: 05),
                            Text(
                              //'Mar 5,2022',
                              '${widget.bookedDate}',
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
                          Text('Work Started',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SamsungSharpSans-Medium',
                            ),),
                          /*SizedBox(height: 05),
                          Text(
                            //'Mar 5,2022',
                            '${widget.bookedDate}',
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
      child:isWorkFinished == "-1"
      ?Column(
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
                    Text('Work Finished',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                      ),),
                    /*SizedBox(height: 05),
                    Text(
                      //'Mar 5,2022',
                      '${widget.bookedDate}',
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
                      Text('Work Finished',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text(
                        //'Mar 5,2022',
                        '${widget.bookedDate}',
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
                        //updateToCloudFirestoreDB("isPayment","0");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegularPaymentScreen(
                                  firebaseCollection: TextStrings.firebase_take_vehicle,
                                  bookingId: widget.bookedId,
                                )));
                      },
                      child: Text('Pay Now',
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
                      Text('Payment Completed',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 05),
                      Text('at $isPaymentTime',
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

  /*Widget paymentRequestUi(Size size){
    return Container(
      child:paymentStatus == "-1"
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
                            child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_b.svg',
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
                            Text('Payment To Mechanic',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            *//*SizedBox(height: 05),
                            Text(
                              //'Mar 5,2022',
                              '${widget.bookedDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Medium',
                                  color: const Color(0xff9b9b9b)
                              ),)*//*
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
                            child: Text('payment',
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
                  padding: const EdgeInsets.fromLTRB(45,5,5,0),
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
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_w.svg',
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
                          Text('Payment To Mechanic',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SamsungSharpSans-Medium',
                            ),),
                          *//*SizedBox(height: 05),
                          Text(
                            //'Mar 5,2022',
                            '${widget.bookedDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                                color: const Color(0xff9b9b9b)
                            ),)*//*
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0,),
                    child: Container(
                      height: 25,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffc9d6f2)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 00.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentRegularScreen4(bookedId: widget.bookedId,)));
                            setState(() {
                              updateToCloudFirestoreDB(
                                  '0',
                                  '0',
                                  '0',
                                  '0',
                                  '0',
                                  '-1'
                              );
                            });
                          },
                          child: Text('payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
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
  }*/

  Widget completedUi(Size size){
    return Container(
      child:isPayment == "5"
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
                          color: CustColors.light_navy,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_service_completed_b.svg',
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
            padding: const EdgeInsets.only(right: 22.0,top:15,bottom: 20),
            child: Container(
              width: 130,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerMainLandingScreen()));
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