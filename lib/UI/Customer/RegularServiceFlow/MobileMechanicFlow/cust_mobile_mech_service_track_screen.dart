import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CustMobileTrackScreen extends StatefulWidget{

  final String bookingId;
  final String bookingDate;

  CustMobileTrackScreen({
    required this.bookingId,
    required this.bookingDate
  });

  @override
  State<StatefulWidget> createState() {
    return _CustMobileTrackScreen();
  }

}

class _CustMobileTrackScreen extends State <CustMobileTrackScreen>{

  HomeCustomerBloc _mechanicHomeBloc = HomeCustomerBloc();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String isBookedDate = "", scheduledDate = "",
      scheduledTime = "", isDriveStarted = "",
      isArrived = "", isWorkStarted = "",
      isWorkFinished = "", isPayment = "";
  String bookingDate = "", customerName = "", mechanicName = "";
  DateTime dateToday = DateTime.now();
  String isDriveStartedTime = "", isArrivedTime = "", isWorkStartedTime = "", isWorkFinishedTime = "", isPaymentTime = "";
  String customerAddress = "", mechanicAddress = "";
  String isCompleted = "-1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenToCloudFirestoreDB();
    bookingDate = widget.bookingDate;
  }

  void listenToCloudFirestoreDB() {
   // _firestoreData = _firestore.collection("ResolMech").doc('$bookingId').snapshots();
    _firestore.collection("${TextStrings.firebase_mobile_mech}").doc('${widget.bookingId}').snapshots().listen((event) {

      setState(() {
        bookingDate = event.get("bookingDate");
        customerName = event.get("customerName");
        customerAddress = event.get("customerAddress");
        scheduledTime = event.get("scheduledTime");
        mechanicName = event.get("mechanicName");
        mechanicAddress = event.get("mechanicAddress");
        isBookedDate = event.get("isBookedDate");
        scheduledDate = event.get("scheduledDate");
        scheduledDate = event.get("scheduledDate");
        isDriveStarted = event.get("isDriveStarted");
        isDriveStartedTime = event.get("isDriveStartedTime");
        isArrived = event.get("isArrived");
        isArrivedTime = event.get("isArrivedTime");
        isWorkStarted = event.get("isWorkStarted");
        isWorkStartedTime = event.get("isWorkStartedTime");
        isWorkFinished = event.get("isWorkFinished");
        isWorkFinishedTime = event.get("isWorkFinishedTime");
        isPayment = event.get("isPayment");
        isPaymentTime = event.get("isPaymentTime");
      });

      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(scheduledDate);

      print(" >>>> Date : >>>>>" + tempDate.compareTo(dateToday).toString());
      if(tempDate.compareTo(dateToday) == 0 || tempDate.compareTo(dateToday) == -1){
        setState(() {
          //isBookedDate = "0";
          updateToCloudFirestoreDB("isBookedDate","0");
          print(" >>>>> isBookedDate >>>" + isBookedDate);
        });
      }

      if(isPayment == "5"){
        setState(() {
          isCompleted = "0";
        });
      }

      print(" >>>> Date : >>>>>" + dateToday.toString());

      print(" >>>> Date : >>>>>" + tempDate.toString());
     /* customerDiagonsisApproval = event.get("customerDiagonsisApproval");
      mechanicName = event.get('mechanicName');
      totalEstimatedCost = event.get("updatedServiceCost");
      totalEstimatedTime = event.get('updatedServiceTime');
      totalTimeTakenByMechanic = event.get('totalTimeTakenByMechanic');
      String extendedTime = event.get('extendedTime');
      int time = int.parse(totalEstimatedTime) + int.parse(extendedTime);
      totalExtendedTime = time.toString();
      print('_firestoreData>>>>>>>>> ' + event.get('serviceName'));
      print('_firestoreData>>>>>>>>> ' + totalEstimatedCost);*/
    });
  }

  void updateToCloudFirestoreDB(String key, String value ) {
    _firestore
        .collection("${TextStrings.firebase_mobile_mech}")
        .doc('${widget.bookingId}')
        .update({
      "$key" : "$value",
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
                appBarCustomerUi(size),
                trackServiceBoxUi(size),
                serviceBookedUi(size),
                isDriveStarted == "-1" ? driveStartedInactiveUi(size) : driveStartedCompletedUi(size),
                isArrived == "-1" ? mechanicArrivedInactiveUi(size) : mechanicArrivedCompletedUi(size),
                isWorkStarted == "-1" ? workStartedInactiveUi(size) : workStartedCompletedUi(size),
                isWorkFinished == "-1" ? workFinishedInactiveUi(size) : workFinishedCompletedUi(size),

                isWorkFinished == "-1" && isPayment == "-1" ?
                paymentOptionInActiveUi(size)
                    : isWorkFinished == "0" && isPayment == "5" ?
                        paymentOptionFinishedUi(size)
                    : paymentOptionActiveUi(size),

                // one more widget on processing payment or waiting payment

                completedUi(size),

                textButtonUi(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomerUi(Size size){
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
                  onPressed: () => Navigator.pop(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget trackServiceBoxUi(Size size){
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

  Widget serviceBookedUi(Size size){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // MainAxisSize.min,
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
                      //_mechanicHomeBloc.dateMonthConverter(DateFormat("yyyy-MM-dd").parse(bookingDate)),
                      _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(bookingDate)),
                      //bookingDate.toString(),
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

  Widget driveStartedCompletedUi(Size size){
    return Container(
      child: Column(
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
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$mechanicName drive started',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 02),
                      mechanicAddress.isEmpty ? Container():
                      Text(
                        'from - $mechanicAddress',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),),
                      mechanicAddress.isEmpty ? Container(): SizedBox(height: 02),
                      Text('on ${_mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate))}'
                          + '\nat ${isDriveStartedTime}',
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

  Widget driveStartedInactiveUi(Size size){
    return Container(
      child: Column(
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
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mechanic $mechanicName come to ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 02),
                      Text('$customerAddress',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),),
                      SizedBox(height: 02),
                      Text(
                        'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                        //'Mar 5,2022',
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
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget mechanicArrivedCompletedUi(Size size){
    return Container(
      child: Column(
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
                          child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_arrived_w.svg',
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
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$mechanicName reached',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 02),
                      Text('Savannah estate, plot 176',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),),*/
                      SizedBox(height: 02),
                      Text('at ${isArrivedTime}',
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

  Widget mechanicArrivedInactiveUi(Size size){
    return Container(
      child: Column(
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
                          child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_arrived_b.svg',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( isDriveStarted == "-1" ? 'Drive not started' : "Expected to reach",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      /*SizedBox(height: 02),
                      isDriveStarted != "-1" ? Text('Expected to reach',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),) : Container(),*/
                      isDriveStarted != "-1" ? SizedBox(height: 02) : Container(),
                      isDriveStarted != "-1" ? Text('before $scheduledTime',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),) : Container()
                    ],
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
      ),
    );
  }

  Widget workStartedInactiveUi(Size size){
    return Container(
      child: Column(
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
              flex:200,
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start work',
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
      ),
    );
  }

  Widget workStartedCompletedUi(Size size){
    return Container(
      child: Column(
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
                      Text('$mechanicName started work',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                      Text('at ${isWorkStartedTime}',
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

  Widget workFinishedInactiveUi(Size size){
    return Container(
      child: Column(
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
                flex:200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Finish work',
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

  Widget workFinishedCompletedUi(Size size){
    return Container(
      child: Column(
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
                      Text('$mechanicName finished work',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                      Text('at ${isWorkFinishedTime}',
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
                                  firebaseCollection: TextStrings.firebase_mobile_mech,
                                  bookingId: widget.bookingId,
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
                      SizedBox(height: 05),
                      Text('at $isPaymentTime',
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
      child: isCompleted == '-1'
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
                  Text('Service Completed',
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
                  Text('Service Completed',
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