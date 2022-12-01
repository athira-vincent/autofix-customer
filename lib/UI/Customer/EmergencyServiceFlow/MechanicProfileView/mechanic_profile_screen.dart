import 'dart:convert';

import 'package:auto_fix/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Models/customer_models/booking_details_model/bookingDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_details_model/mechanicDetailsMdl.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:auto_fix/Widgets/screen_size.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;


class MechanicProfileViewScreen extends StatefulWidget {

  final String mechanicId;
  final String authToken;
  final bool isEmergency;
  Datum? mechanicListData;
  final String serviceModel;
  final String latitude;
  final String longitude;
  final String serviceIds;
  final String customerAddress;

  MechanicProfileViewScreen({
    required this.mechanicId,
    required this.authToken,
    required this.customerAddress,
    required this.mechanicListData,
    required this.isEmergency,
    required this.serviceModel,
    required this.latitude,
    required this.longitude,
    required this.serviceIds});

  @override
  State<StatefulWidget> createState() {
    return _MechanicProfileViewScreenState();
  }
}

class _MechanicProfileViewScreenState extends State<MechanicProfileViewScreen> {

  MechanicDetailsMdl? _mechanicDetailsMdl;

  String serverToken = TextStrings.firebase_serverToken;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;

  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc = MechanicOrderStatusUpdateBloc();


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List yourItemList = [];

  int? reviewLength = 0;

  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  double totalFees = 0.0;

  String? FcmToken="";
  String authToken="";
  String userName="";
  String currentDateTime = "";
  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";

  String carNameBrand="";
  String carNameModel="";

  String carPlateNumber="", carColor = "";

  late StateSetter mechanicAcceptance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yourItemList.add({
      "serviceName" : "${widget.mechanicListData?.mechanicService[0].service?.serviceName}",
      "serviceTime" : "${widget.mechanicListData?.mechanicService[0].time.split(':').first}",
      "serviceCost" :"${widget.mechanicListData?.mechanicService[0].fee}",
      "serviceId" : "${widget.mechanicListData?.mechanicService[0].service?.id}",
      "isDefault":  '1',
    });
    getSharedPrefData();
    _listen();

    _listenNotification(context);
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

      print('authToken>>>>>>>>> ' + authToken.toString());
      print('serviceIdEmergency>>>>>>>> ' + serviceIdEmergency.toString());
      print('mechanicIdEmergency>>>>>>> ' + mechanicIdEmergency.toString());
      print('bookingIdEmergency>>>>>>>>> ' + bookingIdEmergency.toString());

      totalFees = totalFees + double.parse('${widget.mechanicListData?.mechanicService[0].fee.toString()}');
      _homeCustomerBloc.fetchMechanicProfileDetails(
          authToken,
          '${widget.mechanicListData?.id}',
          widget.serviceIds,
          widget.latitude,
         widget.longitude,);

    });
  }

  _listen() {
    _homeCustomerBloc.MechanicProfileDetailsResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {
          _mechanicDetailsMdl = value;
          reviewLength = int.parse('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length}') >= 2 ? 2 : _mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length;

          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");
        });
      }
    });
    _homeCustomerBloc.mechanicsEmergencyBookingIDResponse.listen((value) async {
      if (value.status == "error") {
        setState(() {
          print("message mechanicsEmergencyBookingIDResponse >>>>>>>  ${value.message}");
          print("errrrorr mechanicsEmergencyBookingIDResponse  >>>>>>>  ${value.status}");
        });
      } else {

        SharedPreferences shdPre = await SharedPreferences.getInstance();
        setState(() {
          shdPre.setString(SharedPrefKeys.serviceIdEmergency, widget.serviceIds);
          shdPre.setString(SharedPrefKeys.mechanicIdEmergency, widget.mechanicId);
          shdPre.setString(SharedPrefKeys.bookingIdEmergency, "${value.data?.emergencyBooking?.id}");
          bookingIdEmergency = "${value.data?.emergencyBooking?.id}";
          _homeCustomerBloc.postBookingDetailsRequest(authToken, "${value.data?.emergencyBooking?.id}",);
          print("message mechanicsEmergencyBookingIDResponse >>>>>>>  ${value.message}");
          print("success mechanicsEmergencyBookingIDResponse >>>>>>>  ${value.data}");

        });
      }
    });
    _homeCustomerBloc.mechanicsUpdateBookingIDResponse.listen((value) async {
      if (value.status == "error") {
        setState(() {
          print("message mechanicsUpdateBookingIDResponse >>>>>>>  ${value.message}");
          print("errrrorr mechanicsUpdateBookingIDResponse >>>>>>>  ${value.status}");
        });
      } else {

        setState(() {
          _homeCustomerBloc.postBookingDetailsRequest(authToken, bookingIdEmergency,);
          print("message mechanicsUpdateBookingIDResponse >>>>>>>  ${value.message}");
          print("success mechanicsUpdateBookingIDResponse >>>>>>>  ${value.status}");
        });
      }
    });

    _homeCustomerBloc.bookingDetailsResponse.listen((value) async {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {

        setState(() {

          carNameBrand = '${value.data?.bookingDetails?.vehicle?.brand}';
          carNameModel = '${value.data?.bookingDetails?.vehicle?.model}';
          carPlateNumber = '${value.data?.bookingDetails?.vehicle?.plateNo}';
          carColor = '${value.data?.bookingDetails?.vehicle?.color}';

          Repository().getCurrentWorldTime("Nairobi").then((value01) => {

            currentDateTime = value01.datetime!.millisecondsSinceEpoch.toString(),

            print("dateConverter(timeNow!) >>> ${currentDateTime}"),
            callOnFcmApiSendPushNotifications(value)

          });

          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");

        });
      }
    });

  }

  Future<void> callOnFcmApiSendPushNotifications(BookingDetailsMdl? detailsMdl) async {
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
        "screen": "IncomingJobOfferScreen",
        "customerCurrentTime": currentDateTime,
        "mechanicCurrentTime" : "",
        "bookingId" : bookingIdEmergency,
        "serviceName" : "${widget.mechanicListData?.mechanicService[0].service?.serviceName}",
        "serviceTime" : "${widget.mechanicListData?.mechanicService[0].time.split(':').first}",
        "serviceCost" :"${widget.mechanicListData?.mechanicService[0].fee}",
        "serviceId" : "${widget.mechanicListData?.mechanicService[0].service?.id}",
        "serviceList" : yourItemList.toString(),
        "carName" : "$carNameBrand [$carNameModel]",
        "carPlateNumber" : carPlateNumber,
        "carColor" : carColor,
        "customerName" : userName,
        "customerAddress" : widget.customerAddress,
        "customerLatitude" : widget.latitude,
        "customerLongitude" : widget.longitude,
        "customerFcmToken" : "$token",
        "mechanicName" : "${widget.mechanicListData?.firstName}",
        "mechanicID" : widget.mechanicId,
        "customerID" : "${detailsMdl!.data!.bookingDetails!.customerId}",
        "mechanicPhone" :"${detailsMdl.data!.bookingDetails!.mechanic!.phoneNo}",
        "customerPhone" : "${detailsMdl.data!.bookingDetails!.customer!.phoneNo}",
        "mechanicProfileUrl" : "${detailsMdl.data!.bookingDetails!.mechanic!.mechanic![0].profilePic}",                  ///----detailsMdl.data!.bookingDetails!.mechanic.profileurl
        "customerProfileUrl" : "${detailsMdl.data!.bookingDetails!.customer!.customer![0].profilePic}",
        "mechanicEmail" : "${detailsMdl.data!.bookingDetails!.mechanic!.emailId}",
        "customerEmail" : "${detailsMdl.data!.bookingDetails!.customer!.emailId}",
        "mechanicAddress" : "",
        "mechanicLatitude" : widget.latitude,
        "mechanicLongitude" : widget.longitude,
        "latitude" : widget.latitude,
        "longitude" : widget.longitude,
        "mechanicFcmToken" :  "${widget.mechanicListData?.fcmToken}",
        "mechanicArrivalState": "0",
        "mechanicDiagonsisState": "0",
        "customerDiagonsisApproval": "0",
        "requestFromApp" : "0",
        "paymentStatus" : "0",
        "totalTimeTakenByMechanic": "0",
        "isPaymentRequested" : "0",
        "isPaymentAccepted" : "0",
        "extendedTime" : "0",
        "customerFromPage" : "0",
        "mechanicFromPage" : "0",
        "updatedServiceCost" : "${widget.mechanicListData?.mechanicService[0].fee}",
        "updatedServiceList" : "",
        "updatedServiceTime" : "${widget.mechanicListData?.mechanicService[0].time.split(':').first}",
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
     //'to':'${_mechanicDetailsMdl?.data?.mechanicDetails?.fcmToken}'
      'to':'${widget.mechanicListData?.fcmToken}'
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
          _showMechanicAcceptanceDialog(context);                                 /// -------------- show after postMechanicOrderStatusUpdateRequest response
          _mechanicOrderStatusUpdateBloc.postMechanicOrderStatusUpdateRequest(    /// -------------- Doubt --------------
              authToken, bookingIdEmergency, "0");

        });
      } else {
        setState(() {
          print('notification sending failed');

        });
      }
    } catch (e) {
      print('exception $e');
    }
  }


  Future<void> updateToCloudFirestoreDB() async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. $yourItemList');
     yourItemList.add({
      "serviceName" : "${widget.mechanicListData?.mechanicService[0].service?.serviceName}",
      "serviceTime" : "${widget.mechanicListData?.mechanicService[0].time.split(':').first}",
      "serviceCost" :"${widget.mechanicListData?.mechanicService[0].fee}",
      "serviceId" : "${widget.mechanicListData?.mechanicService[0].service?.id}",
      "isDefault":  '1',
    });

     _firestore
        .collection("ResolMech")
        .doc(bookingIdEmergency)
        .update({
            "serviceModel" : FieldValue.arrayUnion([{
            "serviceName" : "${widget.mechanicListData?.mechanicService[0].service?.serviceName}",
            "serviceTime" : "${widget.mechanicListData?.mechanicService[0].time.split(':').first}",
            "serviceCost" :"${widget.mechanicListData?.mechanicService[0].fee}",
            "serviceId" : "${widget.mechanicListData?.mechanicService[0].service?.id}",
            "isDefault":  '1',
          }]),
          "updatedServiceList": FieldValue.arrayUnion(yourItemList),
          "customerAddress": widget.customerAddress,
          "customerFromPage": "MechanicTrackingScreen",

    })
        .then((value) => print("ToCloudFirestoreDB - row - created"))
        .catchError((error) =>
        print("Failed to add row: $error"));

  }


  _listenNotification(BuildContext context){
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("onMessage recieved from onMessage");
      print("onMessage event.notification!.data " + event.data.toString());

      String screen = event.data['screen'];
      if(screen.toString() == "MechanicTrackingScreen"){

        NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(event.data);
        print('${notificationPayloadMdl.id.toString()} >>>>>>>>onMessage');

        //final provider = Provider.of<LocaleProvider>(context,listen: false);

        //provider.setPayload(notificationPayloadMdl);

        //Navigator.pop(context);

        if(notificationPayloadMdl.requestFromApp == "0")
        {
          print("requestFromApp ${notificationPayloadMdl.requestFromApp}");
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
          });
        }
        else
        {
          print("requestFromApp ${notificationPayloadMdl.requestFromApp}");
          await updateToCloudFirestoreDB();
          setState(() {
            updateToCloudFirestoreDB();
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>   MechanicTrackingScreen(latitude: widget.latitude,
                      longitude:  widget.longitude,bookingId: "${notificationPayloadMdl.bookingId}",)
                )).then((value){
            });
          });
        }
      }else{
        print("Notification onMessage catch at MechanicProfileViewScreen");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    //_notificationListener.listenNotification(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBarCustomUi(size),
              profileImageAndKmAndReviewCount(size),
              timeAndLocationUi(size),

              _mechanicDetailsMdl == null
                  ? Container()
                  : reviewsUi(size),
              selectedServiceDetailsUi(size),
              acceptAndSendRequestButton( size,context) ,
              // Accept $ Send Request - Emergency service
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Stack(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              '${widget.mechanicListData?.firstName}',
              textAlign: TextAlign.center,
              style: Styles.appBarTextBlack,
            ),
            Spacer(),

          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'experience',
                    textAlign: TextAlign.center,
                    style: Styles.experienceTextBlack,
                  ),
                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          color: CustColors.metallic_blue,
                          child: CustomPaint(
                            painter: CurvePainter(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.mechanicListData?.mechanic[0].yearExp != null
                                ? '${widget.mechanicListData?.mechanic[0].yearExp} Year'
                                : '0 Year',
                            textAlign: TextAlign.center,
                            style: Styles.badgeTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileImageAndKmAndReviewCount(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,10),
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedGray.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Text('${widget.mechanicListData?.distance}',
                          style: Styles.appBarTextBlack17,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,110,155,0),
                        child: Text('Away',
                          style: Styles.awayTextBlack,),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90,10,0,0),
                    child: Container(
                      width: 125.0,
                      height: 125.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:Container(
                              child:CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child:
                                      widget.mechanicListData?.mechanic[0].profilePic != null
                                          && widget.mechanicListData?.mechanic[0].profilePic != ""
                                          ?
                                      Image.network(
                                        '${widget.mechanicListData?.mechanic[0].profilePic.toString()}',
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                          :
                                      SvgPicture.asset('assets/image/CustomerType/profileAvathar.svg')
                                  )))

                      ),
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,0,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedWhite.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,10,0),
                        child: Text('Reviews',
                          style: Styles.appBarTextBlack17,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,110,10,0),
                        child: RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: double.parse('${widget.mechanicListData!.mechanicReview}'),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: CustColors.blue,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget timeAndLocationUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child:Row(
          children: [
            Row(
              children: [
                Icon(Icons.lock_clock, color: CustColors.light_navy,size: 35,),
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Text('${widget.mechanicListData?.duration}',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: Styles.textLabelTitle_10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      Text('${widget.mechanicListData?.mechanic[0].address}',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: Styles.textLabelTitle_10,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.location_on_rounded, color: CustColors.light_navy,size: 35,),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewsUi(Size size) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,0),
              child: Container(
                child: Text('Reviews',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: Styles.appBarTextBlack,
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                itemCount:reviewLength,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index,) {
                  return Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,5,10,0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: CustColors.whiteBlueish,
                              borderRadius: BorderRadius.circular(11.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child:Container(
                                            child:CircleAvatar(
                                                radius: 50,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                  child:
                                                  _mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?[index].bookings!.customer!.customer?[0].profilePic != null
                                                      &&
                                                      _mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?[index].bookings!.customer!.customer?[0].profilePic != ""
                                                      ?
                                                  Image.network(
                                                    '${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?[index].bookings!.customer!.customer?[0].profilePic.toString()}',
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  )
                                                      :
                                                  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                                )))

                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?[index].bookings?.customer?.firstName} ${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?[index].bookings?.customer?.lastName}',
                                            style: Styles.textLabelTitle12,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?[index].feedback}',
                                            style: Styles.textLabelTitle12,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  reviewLength = int.parse('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length}');
                  print('reviewLength $reviewLength');
                  print('reviewLength ${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length}');
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 1,
                    width: 110,
                    color: CustColors.greyText,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Load more',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_10,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 110,
                    color: CustColors.greyText,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectedServiceDetailsUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,0),
              child: Container(
                child: Text('Selected Service',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: Styles.appBarTextBlack,
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                itemCount:widget.mechanicListData?.mechanicService.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index,) {
                  return GestureDetector(
                    onTap:(){

                    },
                    child: Container(
                      child:  Padding(
                        padding: const EdgeInsets.fromLTRB(10,10,10,10),
                        child: Container(
                          alignment: Alignment.center,
                          child:Row(
                            children: [
                              Row(
                                children: [
                                  Text('${widget.mechanicListData?.mechanicService[index].service?.serviceName}',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_10,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text('${widget.mechanicListData?.mechanicService[index].fee}',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,0),
              child: Row(
                children: [
                  Row(
                    children: const [
                      Text('Total Amount',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: Styles.appBarTextBlack17,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text('${widget.mechanicListData?.totalAmount}',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: Styles.appBarTextBlack17,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget acceptAndSendRequestButton(Size size, BuildContext context) {
    return InkWell(
      onTap: () async {
        print(">>>>>>>>>> Latitude  ${widget.latitude}");
        print(">>>>>>>>>> Longitude  ${widget.longitude}");
        print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
        print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
        print(">>>>>>>>>> ServiceId  ${widget.serviceIds}");

        if(serviceIdEmergency.toString().trim() == widget.serviceIds )
        {
          print('serviceIdEmergency>>>>>>>>000000  ' + serviceIdEmergency.toString());
          _homeCustomerBloc.postUpdateMechanicsBookingIDRequest(
              authToken,
              bookingIdEmergency,
              mechanicIdEmergency);
        }
        else
        {
          print('serviceIdEmergency>>>>>>>>11111 ' + serviceIdEmergency.toString());

          _homeCustomerBloc.postMechanicsEmergencyServiceBookingIDRequest(
            authToken,
            '${_homeCustomerBloc.dateConvert(DateTime.now())}',
            '${_homeCustomerBloc.timeConvert(DateTime.now())}',
            widget.latitude,
            widget.longitude,
            widget.serviceIds,
            widget.mechanicListData!.mechanicService[0].fee,
            '${widget.mechanicListData?.id}',
            '1',
            '${widget.mechanicListData?.totalAmount}',
            '1',
            '${_homeCustomerBloc.timeConvertWithoutAmPm(DateTime.now())}',);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Spacer(),
            Container(
              height: 45,
              width:200,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 8, bottom: 6,left: 20,right: 20),
              //padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: CustColors.light_navy,
                border: Border.all(
                  color: CustColors.blue,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Accept & send request",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showMechanicAcceptanceDialog(BuildContext context) async {
    Future.delayed(const Duration(seconds: 40), () {

      setState(() {
        print('_showMechanicAcceptanceDialog');

        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).pop();

      });

    });
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter mechanicAcceptance1) {
            mechanicAcceptance = mechanicAcceptance1;
            return AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(left: 20, right: 20),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius. circular(10))),
                contentPadding: const EdgeInsets.all(20),
                content: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Wait for few minutes !",
                            style: Styles.waitingTextBlack17,
                          ),
                          Text(
                            "Wait for the response from ${widget.mechanicListData?.firstName}!",
                            style: Styles.awayTextBlack,
                          ),
                          Container(
                            height: 150,
                              child: SvgPicture.asset(
                                  'assets/image/mechanicProfileView/waitForMechanic.svg',
                                height: 200,
                                fit: BoxFit.cover,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          });
        });


  }










}
