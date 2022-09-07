import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/TrackingScreens/FindYourCustomer/find_your_customer_screen.dart';
import 'package:auto_fix/Widgets/Countdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';

class IncomingJobRequestScreen extends StatefulWidget {

  final NotificationPayloadMdl notificationPayloadMdl;

  IncomingJobRequestScreen(
      {
        required this.notificationPayloadMdl
      });

  @override
  State<StatefulWidget> createState() {
    return _IncomingJobRequestScreenState();
  }
}

class _IncomingJobRequestScreenState extends State<IncomingJobRequestScreen> with TickerProviderStateMixin{

  String serverToken = 'AAAADMxJq7A:APA91bHrfSmm2qgmwuPI5D6de5AZXYibDCSMr2_qP9l3HvS0z9xVxNru5VgIA2jRn1NsXaITtaAs01vlV8B6VjbAH00XltINc32__EDaf_gdlgD718rluWtUzPwH-_uUbQ5XfOYczpFL';
  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc = MechanicOrderStatusUpdateBloc();
  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  String customerToken = "", bookingIdEmergency = "", serviceName = "";
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  //late bool _isJobOfferAccepted;

  late int isAccepted;
  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }
  bool language_en_ar=true;

  bool SliderVal = false;
  String? FcmToken ="";

  int _counter = 0;
  late AnimationController _controller;
  int levelClock = 30;
  String authToken = "", userId = "";
  List yourItemList = [];

  @override
  void initState() {
    super.initState();
    customerToken = widget.notificationPayloadMdl.customerFcmToken;
    bookingIdEmergency = widget.notificationPayloadMdl.bookingId;
    serviceName = widget.notificationPayloadMdl.serviceName;
    getSharedPrefData();
    _getApiResponse();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds: levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("levelClock >>>>>> " + levelClock.toString() );
        isAccepted = 0;
        Navigator.of(context, rootNavigator: true).pop(context);
      }
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      print('userFamilyId ' + authToken.toString());
      print('userId ' + userId.toString());

    });
  }

  Future<void> callOnFcmApiSendPushNotifications(int length,) async {

    print(" callOnFcmApiSendPushNotifications > isAccepted " + isAccepted.toString());
    print("customerToken >> " + customerToken);

    FirebaseMessaging.instance.getToken().then((value) {
      FcmToken = value;
      print("Instance ID Fcm Token: +++++++++ +++++ +++++ minnu " + FcmToken.toString());
    });

    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    // print('userToken>>>${appData.fcmToken}'); //alp dec 28

    final data = {
      'notification': {
        'body': 'You have $length new booking',
        'title': 'Emergency Service Request Response',
        'sound': 'alarmw.wav',
      },
      'priority': 'high',
      'data': {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "screen": "MechanicTrackingScreen",
        "bookingId" : "${widget.notificationPayloadMdl.bookingId}",
        "serviceName" : "${widget.notificationPayloadMdl.serviceName}",
        "serviceId" : "${widget.notificationPayloadMdl.serviceId}",
        "serviceList" : "${widget.notificationPayloadMdl.serviceList}",
        "carName" : "${widget.notificationPayloadMdl.carName}",
        "carPlateNumber" : "${widget.notificationPayloadMdl.carPlateNumber}",
        "carColor" : "${widget.notificationPayloadMdl.carColor}",
        "customerName" : "${widget.notificationPayloadMdl.customerName}",
        "customerAddress" : "${widget.notificationPayloadMdl.customerAddress}",
        "customerLatitude" : "${widget.notificationPayloadMdl.customerLatitude}",
        "customerLongitude" : "${widget.notificationPayloadMdl.customerLongitude}",
        "customerFcmToken" : "${widget.notificationPayloadMdl.customerFcmToken}",
        "mechanicName" : "${widget.notificationPayloadMdl.mechanicName}",
        "mechanicID" : "${widget.notificationPayloadMdl.mechanicID}",
        "customerID" : "${widget.notificationPayloadMdl.customerID}",
        "mechanicPhone" : "${widget.notificationPayloadMdl.mechanicPhone}",
        "customerPhone" : "${widget.notificationPayloadMdl.customerPhone}",
        "mechanicAddress" : "${widget.notificationPayloadMdl.mechanicAddress}",
        "mechanicLatitude" : "${widget.notificationPayloadMdl.mechanicLatitude}",
        "mechanicLongitude" : "${widget.notificationPayloadMdl.mechanicLongitude}",
        "mechanicFcmToken" : "$FcmToken",
        "totalTimeTakenByMechanic": "0",
        "mechanicArrivalState": "0",
        "mechanicDiagonsisState": "0",
        "customerDiagonsisApproval": "0",
        "requestFromApp" : "$isAccepted",
        "paymentStatus" : "0",
        "isPaymentRequested" : "0",
        "isPaymentAccepted" : "0",
        "extendedTime" : "0",
        "customerFromPage" : "0",
        "mechanicFromPage" : "0",
        "updatedServiceCost" : "${widget.notificationPayloadMdl.serviceCost}",
        "updatedServiceList" : "",
        "updatedServiceTime" : "${widget.notificationPayloadMdl.serviceTime}",
        "serviceModel" : "",
        "isWorkStarted" : "0",
        "isWorkCompleted" : "0",
        "serviceTime" : "${widget.notificationPayloadMdl.serviceTime}",
        "serviceCost" : "${widget.notificationPayloadMdl.serviceCost}",
        "message": "ACTION"
      },
      'apns': {
        'headers': {'apns-priority': '5', 'apns-push-type': 'background'},
        'payload': {
          'aps': {'content-available': 1, 'sound': 'alarmw.wav'}
        }
      },

      'to':'$customerToken'
      //'to': 'fZ5X6-BfTSGbeIbe-SO_pZ:APA91bGTsUoghS-1YXbecO3wsSmlui-vo0gp7ykssyD6J4vAMwpprU2aZC_h4jX0ym9pp42tRDt6uGWie8SxKAyDn8dq23JrOwxDgl3XJu40a4_JwxID9lMKsxw_Dmg4Zgafgm5XVu5P',
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
      'key=$serverToken'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);

      if (response.statusCode == 200) {
        print('notification sending success');
        SliderVal = true;
        /*if(isAccepted == 0){

          Navigator.pop(context);

        }else*/

        if(isAccepted == 1){

          SharedPreferences shdPre = await SharedPreferences.getInstance();
          shdPre.setString(SharedPrefKeys.bookingIdEmergency, widget.notificationPayloadMdl.bookingId);

          updateToCloudFirestoreDB();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => FindYourCustomerScreen(
                    latitude: widget.notificationPayloadMdl.customerLatitude/*"10.0159"*/,
                    longitude: widget.notificationPayloadMdl.customerLongitude/*"76.3419"*/,
                    //notificationPayloadMdl: widget.notificationPayloadMdl,
                  )));
        }

      } else {
        print('notification sending failed');
      }
    } catch (e) {
      print('exception $e');
    }
  }

  void updateToCloudFirestoreDB() async{

    yourItemList.add({
      "serviceCost":  '${widget.notificationPayloadMdl.serviceCost}',
      "serviceId": '${widget.notificationPayloadMdl.serviceId}',
      "serviceName": '${widget.notificationPayloadMdl.serviceName}',
      "serviceTime":  '${widget.notificationPayloadMdl.serviceTime}',
      "isDefault":  '1',
    });

    print("yourItemList >>>>" + yourItemList.toString());

    _firestore
        .collection("ResolMech")
        .doc('${widget.notificationPayloadMdl.bookingId}')
        .set({
      "bookingId" : "${widget.notificationPayloadMdl.bookingId}",
      "serviceName" : "${widget.notificationPayloadMdl.serviceName}",
      "serviceId" : "${widget.notificationPayloadMdl.serviceId}",
      "serviceList" : "${widget.notificationPayloadMdl.serviceList}",
      "carName" : "${widget.notificationPayloadMdl.carName}",
      "carPlateNumber" : "${widget.notificationPayloadMdl.carPlateNumber}",
      "carColor" : "${widget.notificationPayloadMdl.carColor}",
      "customerID" : "${widget.notificationPayloadMdl.customerID}",
      "customerPhone" : "${widget.notificationPayloadMdl.customerPhone}",
      "customerName" : "${widget.notificationPayloadMdl.customerName}",
      "customerAddress" : "${widget.notificationPayloadMdl.customerAddress}",
      "customerLatitude" : "${widget.notificationPayloadMdl.customerLatitude}",
      "customerLongitude" : "${widget.notificationPayloadMdl.customerLongitude}",
      "customerFcmToken" : "${widget.notificationPayloadMdl.customerFcmToken}",
      "mechanicName" : "${widget.notificationPayloadMdl.mechanicName}",
      "mechanicID" : "${widget.notificationPayloadMdl.mechanicID}",
      "mechanicPhone" : "${widget.notificationPayloadMdl.mechanicPhone}",
      "mechanicAddress" :"${widget.notificationPayloadMdl.mechanicAddress}",
      "mechanicLatitude" : "${widget.notificationPayloadMdl.mechanicLatitude}",
      "mechanicLongitude" : "${widget.notificationPayloadMdl.mechanicLongitude}",
      "mechanicFcmToken" : "$FcmToken",
      "requestFromApp" : "$isAccepted",
      "paymentStatus" : "0",
      "isPaymentRequested" : "0",
      "isPaymentAccepted" : "0",
      "extendedTime" : "0",
      "totalTimeTakenByMechanic": "0",
      "timerCounter": "${widget.notificationPayloadMdl.serviceTime}",
      "currentUpdatedTime": "${widget.notificationPayloadMdl.serviceTime}",
      "customerFromPage" : "MechanicTrackingScreen",
      "mechanicFromPage" : "FindYourCustomerScreen",
      "isWorkStarted" : "0",
      "isWorkCompleted" : "0",
      "latitude": "${widget.notificationPayloadMdl.mechanicLatitude}",
      'longitude': "${widget.notificationPayloadMdl.mechanicLongitude}",
      "serviceTime" : "${widget.notificationPayloadMdl.serviceTime}",
      "serviceCost" :"${widget.notificationPayloadMdl.serviceCost}",
      "updatedServiceCost" : "${widget.notificationPayloadMdl.serviceCost}",
      "updatedServiceList" : FieldValue.arrayUnion([{
        "serviceCost":  '${widget.notificationPayloadMdl.serviceCost}',
        "serviceId": '${widget.notificationPayloadMdl.serviceId}',
        "serviceName": '${widget.notificationPayloadMdl.serviceName}',
        "serviceTime":  '${widget.notificationPayloadMdl.serviceTime}',
        "isDefault":  '1',
      }]),
      "updatedServiceTime" : "${widget.notificationPayloadMdl.serviceTime}",
      "serviceModel" : FieldValue.arrayUnion([{
        "serviceCost":  '${widget.notificationPayloadMdl.serviceCost}',
        "serviceId": '${widget.notificationPayloadMdl.serviceId}',
        "serviceName": '${widget.notificationPayloadMdl.serviceName}',
        "serviceTime":  '${widget.notificationPayloadMdl.serviceTime}',
        "isDefault":  '1',
      }]),
      "mechanicArrivalState": "0",
      "mechanicDiagonsisState": "0",
      "customerDiagonsisApproval": "0",
    })
        .then((value) => print("ToCloudFirestoreDB - row - created"))
        .catchError((error) =>
        print("Failed to add row: $error"));

  }

  /*void changeScreen(){
    if (widget.serviceModel == "0"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FindYourCustomerScreen(serviceModel: widget.serviceModel,)));
    }else if (widget.serviceModel == "1"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FindYourCustomerScreen(serviceModel: widget.serviceModel,)));
     // PickUpCustomerLocationScreen
    }else if (widget.serviceModel == "2"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FindYourCustomerScreen(serviceModel: widget.serviceModel,)));
    }else if (widget.serviceModel == "3"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FindYourCustomerScreen(serviceModel: widget.serviceModel,)));
    }
  }*/

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _emailFocusNode.removeListener(onFocusChange);
    _mechanicOrderStatusUpdateBloc.dispose();
    _mechanicHomeBloc.dispose();
  }

  _getApiResponse() {
    _mechanicOrderStatusUpdateBloc.MechanicOrderStatusUpdateResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
          // Navigator.pop(context);
        });
      } else {
        setState(() {
          _isLoading = false;
          print('getSharedPrefData');
          callOnFcmApiSendPushNotifications(1);
          /*Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          FocusScope.of(context).unfocus();*/
        });

      }
    });
  }

  void onFocusChange() {
    setState(() {
      _labelStyleEmail = _emailFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              // ignore: avoid_unnecessary_containers
              child: Column(
                children: [
                  appBarCustomUi(),
                  Container(
                    height: MediaQuery.of(context).size.height *0.32 ,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SvgPicture.asset('assets/image/MechanicType/incomingRequestBg.svg',
                              height: MediaQuery.of(context).size.height *0.32,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        autovalidateMode: _autoValidate,
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: _setValue(20.5), right: _setValue(20.5),top: _setValue(17.5), ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: CustColors.warm_grey04),
                                      borderRadius: BorderRadius.circular(11.0)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Container(
                                              child: Text(widget.notificationPayloadMdl.serviceName,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle_12,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text(
                                                widget.notificationPayloadMdl.carName,
                                                // 'Toyota Corolla   [Black]',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle16,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              child: Text(widget.notificationPayloadMdl.carPlateNumber,      //'YAB477AB',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle16,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              width: 150,
                                              child: Text(
                                                widget.notificationPayloadMdl.customerName,
                                                maxLines: 4,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelSubTitlegrey11,
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Text(
                                                widget.notificationPayloadMdl.customerAddress
                                                /*'Elenjikkal House '
                                                    'Empyreal Garden '
                                                    'Opposite of Ceevees International Auditorium Anchery'
                                                    'Anchery P.O'
                                                    'Thrissur - 680006'*/,
                                                maxLines: 4,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelSubTitlegrey11,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                height: 40,
                                width: SliderVal==false ? 240 : 40,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: SliderVal==false ? CustColors.light_navy : CustColors.white_02,
                                    ),
                                    borderRadius: BorderRadius.circular(50) // use instead of BorderRadius.all(Radius.circular(20))
                                ),
                                child:
                                SliderVal == false
                                    ? SliderButton(
                                  buttonColor: CustColors.blue,
                                  backgroundColor: Colors.white,
                                  highlightedColor: CustColors.light_navy02,
                                  baseColor:  CustColors.light_navy,
                                  action: () {
                                    print(' SliderButton success');
                                    setState(() {
                                      SliderVal = true;
                                      _controller.stop(canceled: true);
                                      isAccepted = 1;
                                      //callOnFcmApiSendPushNotifications(1, 1);
                                      _mechanicHomeBloc.postMechanicOnlineOfflineRequest("$authToken", "2", userId,);
                                      _mechanicOrderStatusUpdateBloc.postMechanicOrderStatusUpdateRequest(
                                          authToken, widget.notificationPayloadMdl.bookingId, "2");
                                      //--------- call notification
                                    });
                                  },
                                  label: Text(
                                    "Slide to accept offer",
                                    style: TextStyle(
                                        color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                        color: CustColors.blue,
                                        borderRadius: BorderRadius.circular(40) // use instead of BorderRadius.all(Radius.circular(20))
                                    ),
                                    child:  Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 30.0,
                                      semanticLabel: 'Text to announce in accessibility modes',
                                    ),
                                  ),
                                )
                                    : Container(
                                  height: 40,
                                  width: 50,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularProgressIndicator(color: CustColors.light_navy,),
                                      Icon(
                                        Icons.check,
                                        color:  CustColors.light_navy,
                                        size: 30.0,
                                        semanticLabel: 'Text to announce in accessibility modes',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 10),
                                alignment: Alignment.center,
                                //color: Colors.red,
                                child: Text(
                                  "Accept offer within 30 seconds! ",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: Styles.textLabelSubTitle12,
                                ),
                              ),
                              Countdown(
                                animation: StepTween(
                                  begin: levelClock, // THIS IS A USER ENTERED NUMBER
                                  end: 0,
                                ).animate(_controller),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        /*IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),*/
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Incoming job offer',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
    );
  }



}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

