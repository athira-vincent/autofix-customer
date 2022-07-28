import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceStatusUpdate/service_status_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/PickAndDropOffFlow/find_your_cust_regular_pickup__screen.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechPickUpTrackScreen extends StatefulWidget{

  final String latitude;
  final String longitude;
  final String mechanicAddress;
  final String bookedDate;
  final String pickingDate;
  final String mechanicName;
  final String bookedId;


  MechPickUpTrackScreen({
    required this.latitude,
    required this.bookedDate,
    required this.bookedId,
    required this.pickingDate,
    required this.longitude,
    required this.mechanicAddress,
    required this.mechanicName,
  });

  @override
  State<StatefulWidget> createState() {
    return _MechPickUpTrackScreen();
  }

}

class _MechPickUpTrackScreen extends State <MechPickUpTrackScreen>{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  final ServiceStatusUpdateBloc _serviceStatusUpdateBloc = ServiceStatusUpdateBloc();

  String authToken="";
  String userName="";

  String isStartedFromLocation = "-1";
  String isArrived = "-1";
  String isPickedUpVehicle = "-1";
  String isReachedServiceCenter = "-1";
  String isWorkStarted = "-1";
  String isWorkFinished = "-1";
  String isStartedFromLocationForDropOff = "-1";
  String isDropOff = "-1";
  String isPayment = "-1";
  String customerLatitude = "", customerLongitude = "";



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
        customerLatitude = event.get("customerLatitude");
        customerLongitude = event.get("customerLongitude");

      });
    });
  }

  /*Future<void> callOnFcmApiSendPushNotifications(int length) async {
    String? token;
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      setState(() {
        FcmToken = value;
      });
      print("Instance ID Fcm Token: +++++++++ +++++ +++++ minnu " + token.toString());
    });


    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    // print('userToken>>>${appData.fcmToken}'); //alp dec 28

    final data = {
      'notification': {
        'body': 'You have new Emergency booking',
        'title': 'Notification',
        'sound': 'alarmw.wav',
      },
      'priority': 'high',
      'data': {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "screen": "CustomerServiceDetailsScreen",
        "bookingId" : "$bookingIdEmergency",
        "serviceName" : "${widget.mechanicListData?.mechanicService?[0].service?.serviceName}",
        "carName" : "$carNameBrand [$carNameModel]",
        "carPlateNumber" : "$carPlateNumber",
        "customerName" : "$userName",
        "customerAddress" : "${widget.customerAddress}",
        "customerLatitude" : "${widget.latitude}",
        "customerLongitude" : "${widget.longitude}",
        "customerFcmToken" : "$token",
        "mechanicName" : "${widget.mechanicListData?.firstName}",
        "mechanicID" : "${widget.mechanicId}",
        "mechanicLatitude" : "${widget.latitude}",
        "mechanicLongitude" : "${widget.longitude}",
        "latitude" : "${widget.latitude}",
        "longitude" : "${widget.longitude}",
        "mechanicFcmToken" :  "${widget.mechanicListData?.fcmToken}",
        "isWorkStarted" : "0",
        "isWorkCompleted" : "0",
        "message": "ACTION"
      },
      'apns': {
        'headers': {'apns-priority': '5', 'apns-push-type': 'background'},
        'payload': {
          'aps': {'content-available': 1, 'sound': 'alarmw.wav'}
        }
      },
      'to':'${_mechanicDetailsMdl?.data?.mechanicDetails?.fcmToken}'
      //'to':'$token'
      // 'to': 'ctsKmrE-QDmMJKTC_3w9IJ:APA91bEiYGvfKDstMKwYh927f76Gy0w88LY7E1K2vszl2Cg7XkBIaGOXZeSkhYpx8Oqh4ws2AvAVfdif89YvDZNFUondjMEj48bvQE3jXmZFy1ioHauybD6qJPeo7VRcJdUzHfMHCiij',
    };

    print('FcmToken data >>> ${data}');
    print('FcmToken >>> ${FcmToken}');
    print('FcmToken token >>> ${token}');


    final headers = {
      'content-type': 'application/json',
      'Authorization':
      'key=$serverToken'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 30 * 1000,    // 30 seconds
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);

      if (response.statusCode == 200) {
        setState(() {
          print('notification sending success');

        });
      } else {
        setState(() {
          print('notification sending failed');

        });
      }
    } catch (e) {
      print('exception $e');
    }
  }*/

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

                mechanicStartedToCustomerLoationUi(size),     // - 9
                mechanicReachedNearCustomerForPickUpUi(size),
                mechanicPickedYourVehicleUi(size),              // - 10 // - 11
                vehicleReachedTheServiceLocationUi(size),       // - 12
                mechanicStartedServiceWorkUi(size),             // - 5
                workCompletedUi(size),                          // - 6
                mechanicStartedToCustomerLoationForDropOffUi(size), // - 13
                mechanicReachedDropOffUi(size),

                isWorkFinished == "-1" && isPayment == "-1" ?
                paymentOptionInActiveUi(size)
                    : (isWorkFinished == "0" && isPayment == "-1") || (isWorkFinished == "0" && isPayment == "0") ?
                paymentOptionWaitingActiveUi(size)
                    : isWorkFinished == "0" && isPayment == "1" ?
                paymentOptionActiveUi(size)
                    : paymentOptionFinishedUi(size),

                //addPaymentUi(size),               // - 7, 8
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
      //),
    );
  }

  Widget serviceBookedDateUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 15,right: 22),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Booking received on',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                      Text(
                        '${widget.bookedDate}',
                        //_mechanicHomeBloc.dateMonthConverter(DateFormat().parse(widget.bookedDate)),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'SamsungSharpSans-Medium',
                            color: const Color(0xff9b9b9b)
                        ),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      updateToCloudFirestoreDB(
                          '0' ,
                          '-1' ,
                          '-1' ,
                          '-1' ,
                          '-1' ,
                          '-1' ,
                          '-1' ,
                          '-1' ,
                         '-1' ,);
                      _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "9");
                    });
                  },
                  child:
                  isStartedFromLocation == "-1"
                  ? Container(
                    height: 25,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:  CustColors.light_navy,
                    ),
                    child: Text('Start',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                      ),
                    ),
                  )
                  : Container(),
                ),
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
                          children: [
                            Text('Started from location for pickup. ',
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
                      InkWell(
                        onTap: (){

                        },
                        child:
                        Container(
                          height: 25,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:  CustColors.light_navy05,
                          ),
                          child: Text('Track',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: CustColors.light_navy,
                                fontSize: 10
                            ),
                          ),
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
                        children: [
                          Text('Started from location for pickup.',
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
                    isArrived == "-1"
                    ? InkWell(
                      onTap: (){
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FindYourCustomerRegularScreen(
                                    latitude: '${customerLatitude}' /*"10.0159"*/,
                                    longitude: "${customerLongitude}" /*"76.3419"*/,
                                    bookedId: '${widget.bookedId}',
                                    //notificationPayloadMdl: widget.notificationPayloadMdl,
                                  )));
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:  CustColors.light_navy,
                        ),
                        child: Text('Track',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10
                          ),
                        ),
                      ),
                    )
                    : Container(),
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
                          Text('Reached near the destination. ',
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
                          Text('Reached near the destination.',
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
                            Text('Picked the vehicle. ',
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
                          Text('Picked the vehicle.',
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
                    isPickedUpVehicle == "-1"
                        ? InkWell(
                            onTap: (){
                              setState(() {
                                updateToCloudFirestoreDB(
                                  '0' ,
                                  '0' ,
                                  '0' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,);
                                _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "11");
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  CustColors.light_navy,
                              ),
                              child: Text('PickUp',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10
                                ),
                              ),
                            ),
                          )
                        : Container(),
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
                              child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_reached_work_shop_b.svg',
                                fit: BoxFit.contain,
                                //color: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Reached the service center. ',
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
                    isReachedServiceCenter == "-1"
                        ? InkWell(
                            onTap: (){
                              setState(() {
                                updateToCloudFirestoreDB(
                                  '0' ,
                                  '0' ,
                                  '0' ,
                                  '0' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,);
                                _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "12");
                                });
                            },
                            child: Container(
                              height: 25,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  CustColors.light_navy,
                              ),
                              child: Text('Reached',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10
                                ),
                              ),
                            ),
                          )
                        : Container(),
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

  Widget mechanicStartedServiceWorkUi(Size size){
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
                              child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_work_started_b.svg',
                                fit: BoxFit.contain,
                                //color: Colors.white,
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
                    isWorkStarted == "-1"
                        ? InkWell(
                            onTap: (){
                              setState(() {
                                updateToCloudFirestoreDB(
                                  '0' ,
                                  '0' ,
                                  '0' ,
                                  '0' ,
                                  '0' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,
                                  '-1' ,);
                                _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "5");
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  CustColors.light_navy,
                              ),
                              child: Text('Start',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10
                                ),
                              ),
                            ),
                          )
                        : Container(),
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

  Widget workCompletedUi(Size size){
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_work_finished_b.svg',
                                  fit: BoxFit.contain,
                                  //color: Colors.white,
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
                    isWorkFinished== "-1"
                        ? InkWell(
                          onTap: (){
                            setState(() {
                              updateToCloudFirestoreDB(
                                '0' ,
                                '0' ,
                                '0' ,
                                '0' ,
                                '0' ,
                                '0' ,
                                '-1' ,
                                '-1' ,
                                '-1' ,);
                              _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "6");
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:  CustColors.light_navy,
                            ),
                            child: Text('Stop',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10
                              ),
                            ),
                          ),
                        )
                        : Container(),

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

  Widget mechanicStartedToCustomerLoationForDropOffUi(Size size){
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
                            Text('Started vehicle to dropoff.',
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
                          Text('Started vehicle to dropoff.',
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
                    isWorkFinished== "-1"
                        ? InkWell(
                      onTap: (){
                        setState(() {
                          updateToCloudFirestoreDB(
                            '0' ,
                            '0' ,
                            '0' ,
                            '0' ,
                            '0' ,
                            '0' ,
                            '-1' ,
                            '-1' ,
                            '-1' ,);
                          _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "13");
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:  CustColors.light_navy,
                        ),
                        child: Text('Stop',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10
                          ),
                        ),
                      ),
                    )
                        : Container(),
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

  Widget mechanicReachedDropOffUi(Size size){
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
                          Text('Vehicle dropoff.',
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
                        ],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Vehicle dropoff.',
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
                      isStartedFromLocationForDropOff== "-1"
                          ? InkWell(
                              onTap: (){
                                setState(() {
                                  updateToCloudFirestoreDB(
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '-1' ,);
                                  _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "7");
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:  CustColors.light_navy,
                                ),
                                child: Text('DropOff',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10
                                  ),
                                ),
                              ),
                            )
                          : Container(),
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
                  padding: const EdgeInsets.only(left: 5.0,top: 00),
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
                  padding: const EdgeInsets.only(left: 5.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'SamsungSharpSans-Bold',
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
                  padding: const EdgeInsets.only(left: 5.0,top: 00),
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
                  padding: const EdgeInsets.only(left: 5.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Received Payment',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'SamsungSharpSans-Bold',
                        ),),
                     /* SizedBox(height: 05),
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


  /*Widget addPaymentUi(Size size){
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_b.svg',
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
                            Text(isPaymentFinished == "-1" ? 'Payment received.':'Payment initiated.',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SamsungSharpSans-Medium',
                              ),),
                            *//*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*//*
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 85,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffc9d6f2)
                        ),
                        child: Text('Add payment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: CustColors.light_navy,
                              fontSize: 10
                          ),
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
                                child: SvgPicture.asset('assets/image/ServiceTrackScreen/ic_pay_w.svg',
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
                            Text('Payment received.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SamsungSharpSans-Bold',
                              ),),
                            *//*SizedBox(height: 02),
                            Text('${widget.pickingDate}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'SamsungSharpSans-Bold',
                                  color: const Color(0xff9b9b9b)
                              ),)*//*
                          ],
                        ),
                      ),
                      isPaymentFinished== "-1"
                          ? InkWell(
                              onTap: (){
                                setState(() {
                                  updateToCloudFirestoreDB(
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,
                                    '0' ,);
                                  _serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, '${widget.bookedId}', "8");
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:  CustColors.light_navy,
                                ),
                                child: Text('Received',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10
                                  ),
                                ),
                              ),
                            )
                          : Container(),
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
  }*/

  Widget finishTrackUi(Size size){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,top: 0,right: 22),
        child: isPayment == "5"
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
                      Text('Service Completed',
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
                      Text('Service Completed',
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
                  shape: RoundedRectangleBorder(
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


  void updateToCloudFirestoreDB(
      isStartedFromLocation ,
      isArrived ,
      isPickedUpVehicle,
      isReachedServiceCenter,
      isWorkStarted,
      isWorkFinished ,
      isStartedFromLocationForDropOff ,
      isDropOff ,
      isPaymentFinished) {

    _firestore
        .collection("Regular-PickUp")
        .doc('${widget.bookedId}')
        .update({
            'isStartedFromLocation': "$isStartedFromLocation",
            'isArrived': "$isArrived",
            'isPickedUpVehicle': "$isPickedUpVehicle",
            'isReachedServiceCenter': "$isReachedServiceCenter",
            'isWorkStarted': "$isWorkStarted",
            'isWorkFinished': "$isWorkFinished",
            'isStartedFromLocationForDropOff': "$isStartedFromLocationForDropOff",
            'isDropOff': "$isDropOff",
            'isPayment': "$isPaymentFinished",
          })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));

  }

  void updateFirestoreDB(String key, String value ) {
    _firestore
        .collection("${TextStrings.firebase_pick_up}")
        .doc('${widget.bookedId}')
        .update({
      "$key" : "$value",
      "${key}Time" : "${DateFormat("hh:mm a").format(DateTime.now())}",
    })
        .then((value) => print("Location Added >>> ${DateFormat("hh:mm a").format(DateTime.now())}"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

}