import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustPickUpTrackScreen extends StatefulWidget{

  final String latitude;
  final String longitude;
  final String bookedDate;
  final String pickingDate;
  final String mechanicName;
  final String bookedId;

  CustPickUpTrackScreen({
    required this.latitude,
    required this.bookedDate,
    required this.pickingDate,
    required this.bookedId,
    required this.longitude,
    required this.mechanicName,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustPickUpTrackScreen();
  }

}

class _CustPickUpTrackScreen extends State <CustPickUpTrackScreen>{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  String authToken="";
  String userName="";
  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";

  String isStartedFromLocation = "-1";
  String isArrived = "-1";
  String isPickedUpVehicle = "-1";
  String isReachedServiceCenter = "-1";
  String isWorkStarted = "-1";
  String isWorkFinished = "-1";
  String isStartedFromLocationForDropOff = "-1";
  String isDropOff = "-1";
  String isPayment = "-1";
  String paymentStatus = "-1";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
    });
    await _firestore.collection("Regular-PickUp").doc('${widget.bookedId}').snapshots().listen((event) {
      setState(() {
        isStartedFromLocation = event.get("isStartedFromLocation");
        isArrived = event.get("isArrived");
        isPickedUpVehicle = event.get("isPickedUpVehicle");
        isReachedServiceCenter = event.get("isReachedServiceCenter");
        isWorkStarted = event.get("isWorkStarted");
        isWorkFinished = event.get("isWorkFinished");
        isStartedFromLocationForDropOff = event.get("isStartedFromLocationForDropOff");
        isDropOff = event.get("isDropOff");
        isPayment = event.get("isPayment");
        paymentStatus = event.get("paymentStatus");
      });
    });
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
                trackServiceBoxUi(size),
                serviceBookedDateUi(size),

                mechanicStartedToCustomerLoationUi(size),
                mechanicReachedNearCustomerForPickUpUi(size),
                mechanicPickedYourVehicleUi(size),
                vehicleReachedTheServiceLocationUi(size),
                mechanicStartedServiceWorkUi(size),
                workCompletedUi(size),
                mechanicStartedToCustomerLoationForDropOffUi(size),
                mechanicReachedDropOffUi(size),

                isDropOff == "-1" && isPayment == "-1" ?
                paymentOptionInActiveUi(size)
                    : isWorkFinished == "0" && isPayment == "5" ?
                paymentOptionFinishedUi(size)
                    : paymentOptionActiveUi(size),

                finishTrackUi(size),

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
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
    );
  }

  Widget serviceBookedDateUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0,top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              children: [
                Stack(
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
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                    SizedBox(height: 05),
                    Text(
                    //_homeCustomerBloc.dateMonthConverter(DateFormat("yyyy-MM-dd").parse('${widget.bookedDate}')),
                     // _homeCustomerBloc.dateMonthConverter(widget.bookedDate),
                     //_homeCustomerBloc.dateMonthConverter(DateFormat().parse('${widget.bookedDate}')),
                      '${widget.bookedDate}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'SamsungSharpSans-Medium',
                      color: const Color(0xff9b9b9b)
                    ),)
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(23,0,0,0),
              child: FDottedLine(
                  color: CustColors.blue,
                  height: 50.0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget mechanicStartedToCustomerLoationUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isStartedFromLocation == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                child: SvgPicture.asset('assets/image/ic_car1.svg',
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mechanic started from location for pickup. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Medium',
                                  color: const Color(0xff9b9b9b)
                              ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
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
                              child: SvgPicture.asset('assets/image/ic_car1.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mechanic started from location for pickup. ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'SamsungSharpSans-Bold',
                            ),),
                          SizedBox(height: 02),
                          Text('${widget.pickingDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                                color: const Color(0xff9b9b9b)
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23,0,0,0),
                  child: FDottedLine(
                    color: isStartedFromLocation == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                    height: 50.0,
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget mechanicReachedNearCustomerForPickUpUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isArrived == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Mechanic reached near you. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            SizedBox(height: 02),
                            /*Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Mechanic reached near you.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                              ),),
                            SizedBox(height: 02),
                            /*Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
                    child: FDottedLine(
                      color: isArrived == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                      height: 50.0,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget mechanicPickedYourVehicleUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isPickedUpVehicle == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_vehicle_picked_b.svg',
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Vehicle picked by the mechanic. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            SizedBox(height: 02),
                            /*Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
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
                              child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_vehicle_picked_w.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        //Expanded(child: child)
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Vehicle picked by the mechanic.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'SamsungSharpSans-Bold',
                            ),),
                          SizedBox(height: 02),
                          /*Text('${widget.pickingDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                                color: const Color(0xff9b9b9b)
                            ),)*/
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23,0,0,0),
                  child: FDottedLine(
                    color: isPickedUpVehicle == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                    height: 50.0,
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget vehicleReachedTheServiceLocationUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isReachedServiceCenter == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_reached_work_shop_b.svg',
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Reached the service center. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            SizedBox(height: 02),
                            /*Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
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
                              child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_reached_work_shop_w.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        //Expanded(child: child)
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Reached the service center.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'SamsungSharpSans-Bold',
                            ),),
                          /*SizedBox(height: 02),
                          Text('${widget.pickingDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                                color: const Color(0xff9b9b9b)
                            ),)*/
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23,0,0,0),
                  child: FDottedLine(
                    color: isReachedServiceCenter == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                    height: 50.0,
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget mechanicStartedServiceWorkUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isWorkStarted == "-1"
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
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
                                fit: BoxFit.contain,
                                //color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        //Expanded(child: child)
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Started work. ',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SamsungSharpSans-Medium',
                            ),),
                          /*SizedBox(height: 02),
                          Text('${widget.pickingDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Bold',
                                color: const Color(0xff9b9b9b)
                            ),)*/
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Started work.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                              ),),
                            /*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
                    child: FDottedLine(
                      color: isWorkStarted == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                      height: 50.0,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget workCompletedUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isWorkFinished == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Work Finished. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            /*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
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
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        //Expanded(child: child)
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Work Finished.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'SamsungSharpSans-Bold',
                            ),),
                          /*SizedBox(height: 02),
                          Text('${widget.pickingDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                                color: const Color(0xff9b9b9b)
                            ),)*/
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23,0,0,0),
                  child: FDottedLine(
                    color: isWorkFinished == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                    height: 50.0,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget mechanicStartedToCustomerLoationForDropOffUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isStartedFromLocationForDropOff == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_drive_started_b.svg',
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Mechanic started from service centre to DropOff ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                           /* SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
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
                        //Expanded(child: child)
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mechanic started from service centre to DropOff.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'SamsungSharpSans-Bold',
                            ),),
                         /* SizedBox(height: 02),
                          Text('${widget.pickingDate}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                                color: const Color(0xff9b9b9b)
                            ),)*/
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23,0,0,0),
                  child: FDottedLine(
                    color: isStartedFromLocationForDropOff == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                    height: 50.0,
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget mechanicReachedDropOffUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isDropOff == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_drop_off_b.svg',
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Vehicle dropoff by mechanic.',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            /*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_drop_off_w.svg',
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Vehicle dropoff by mechanic.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                              ),),
                            /*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23,0,0,0),
                    child: FDottedLine(
                      color: isDropOff == "-1" ? CustColors.light_navy05:CustColors.light_navy,
                      height: 50.0,
                    ),
                  ),
                ],
              ),
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
                                  firebaseCollection: TextStrings.firebase_pick_up,
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

  Widget finishTrackUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isPayment == "-1"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Completed',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            /*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Stack(
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
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          //Expanded(child: child)
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Completed',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                              ),),
                            /*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                      //Navigator.of(context).pop();
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