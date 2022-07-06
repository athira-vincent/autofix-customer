import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/TakeToMechanicFlow/payment_regular_takeVehicleToMechanic_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../PickAndDropOffFlow/payment_regular_picUpAndDropOff_screen.dart';
import 'find_mechanic_by_customer_screen.dart';

class CustTakeVehicleTrackScreen extends StatefulWidget {

  final String bookedDate;
  final String latitude;
  final String longitude;
  final String goTime;
  final String reachTime;
  final String mechanicName;
  final String mechanicAddress;
  final String pickingDate;
  final String bookedId;

  CustTakeVehicleTrackScreen({
    required this.bookedDate,
    required this.latitude,
    required this.reachTime,
    required this.longitude,
    required this.goTime,
    required this.mechanicName,
    required this.pickingDate,
    required this.bookedId,
    required this.mechanicAddress,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustTakeVehicleTrackScreen();
  }

}

class _CustTakeVehicleTrackScreen extends State <CustTakeVehicleTrackScreen>{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String bookingDate = "";
  String isDriveStarted = "-1";
  String isArrived = "-1";
  String isReachedServiceCenter = "-1";
  String isWorkStarted = "-1";
  String isWorkFinished = "-1";
  String paymentStatus = "-1";
  String paymentRecieved = "-1";
  String completed = "-1";

  @override
  void initState(){
    super.initState();
    listenToCloudFirestoreDB();

  }

  void listenToCloudFirestoreDB() {
    print('${widget.bookedId} ?????? bookedId');
    _firestore.collection("Regular-TakeVehicle").doc('${widget.bookedId}').snapshots().listen((event) {
      setState(() {
        bookingDate = event.get("bookingDate");
        isDriveStarted = event.get("isDriveStarted");
        isArrived = event.get("isArrived");
        isReachedServiceCenter = event.get("isReachedServiceCenter");
        isWorkStarted = event.get("isWorkStarted");
        isWorkFinished = event.get("isWorkFinished");
        paymentStatus = event.get("paymentStatus");
        paymentRecieved = event.get("paymentRecieved");
        completed = event.get("completed");
      });

    });
  }

  void updateToCloudFirestoreDB(
    isDriveStarted ,
    isReachedServiceCenter ,
    isWorkStarted ,
    isWorkFinished ,
    paymentStatus,
      paymentRecieved  ) {
    _firestore
        .collection("Regular-TakeVehicle")
        .doc('${widget.bookedId}')
        .update({
      'isDriveStarted' : "$isDriveStarted",
      'isReachedServiceCenter' : "$isReachedServiceCenter",
      'isWorkStarted' : "$isWorkStarted",
      'isWorkFinished' : "$isWorkFinished",
      'paymentStatus' : "$paymentStatus",
      'paymentRecieved' : "$paymentRecieved"
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
        child: Container(
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
                paymentRequestUi(size),
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
                    //color: CustColors.light_navy,
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
                      '${widget.bookedDate}',

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
                            '-1'
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
            ),
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
                        //color: CustColors.light_navy,
                        child: SvgPicture.asset('assets/image/ic_car1.svg',
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
                        //color: CustColors.light_navy,
                        child: SvgPicture.asset('assets/image/ic_car1.svg',
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
                          //color: CustColors.light_navy,
                          child: SvgPicture.asset('assets/image/ic_car2.svg',
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
                          Text('Reached at Mechanic Shop',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SamsungSharpSans-Medium',
                            ),),
                          SizedBox(height: 05),
                          Text(
                            //'Mar 5,2022',
                            '${widget.reachTime}',
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
                            //color: CustColors.light_navy,
                            child: SvgPicture.asset('assets/image/ic_car2.svg',
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
                            Text('Reached at Mechanic Shop',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            SizedBox(height: 05),
                            Text(
                              //'Mar 5,2022',
                              '${widget.reachTime}',
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
                          //color: CustColors.light_navy,
                          child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
                          //color: CustColors.light_navy,
                          child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
                    //color: CustColors.light_navy,
                    child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
                      //color: CustColors.light_navy,
                      child: SvgPicture.asset('assets/image/ic_carservice.svg',
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

  Widget paymentRequestUi(Size size){
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
                            //color: CustColors.light_navy,
                            child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          //color: CustColors.light_navy,
                          child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
  }

  Widget completedUi(Size size){
    return Container(
      child:completed == "-1"
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
                            //color: CustColors.light_navy,
                            child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
                            //color: CustColors.light_navy,
                            child: SvgPicture.asset('assets/image/ic_carservice.svg',
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
              onPressed: () {  },
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