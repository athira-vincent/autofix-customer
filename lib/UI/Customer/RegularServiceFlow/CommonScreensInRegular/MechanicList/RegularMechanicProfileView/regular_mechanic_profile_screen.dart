import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/mechanicBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_details_model/mechanicDetailsMdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/BookingSuccessScreen/booking_success_screen.dart';

import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceStatusUpdate/service_status_update_bloc.dart';
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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as json;
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart' as category;



class RegularMechanicProfileViewScreen extends StatefulWidget {

  final String mechanicId;
  final String authToken;
  final bool isEmergency;
  Datum? mechanicListData;
  //final String serviceModel;
  final String latitude;
  final String longitude;
  final String serviceIds;
  final String customerAddress;
  final String serviceDate;
  final String serviceTime;
  final String regularServiceType;
  final List<category.Service> selectedService;
  final String serviceType;


  RegularMechanicProfileViewScreen({
    required this.mechanicId,
    required this.authToken,
    required this.customerAddress,
    required this.mechanicListData,
    required this.isEmergency,
   // required this.serviceModel,
    required this.latitude,
    required this.longitude,
    required this.serviceIds,
    required this.serviceDate,
    required this.serviceTime,
    required this.regularServiceType,
    required this.selectedService,
    required this.serviceType,
  });

  @override
  State<StatefulWidget> createState() {
    return _RegularMechanicProfileViewScreenState();
  }
}

class _RegularMechanicProfileViewScreenState extends State<RegularMechanicProfileViewScreen> {

  MechanicDetailsMdl? _mechanicDetailsMdl;

  String serverToken = 'AAAADMxJq7A:APA91bHrfSmm2qgmwuPI5D6de5AZXYibDCSMr2_qP9l3HvS0z9xVxNru5VgIA2jRn1NsXaITtaAs01vlV8B6VjbAH00XltINc32__EDaf_gdlgD718rluWtUzPwH-_uUbQ5XfOYczpFL';
  late final FirebaseMessaging    _messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;

  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc = MechanicOrderStatusUpdateBloc();
  //final ServiceStatusUpdateBloc _serviceStatusUpdateBloc = ServiceStatusUpdateBloc();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List yourItemList = [];

  int? reviewLength = 0;
  bool _isLoading = false;
  double height = 0;
  String selectedState = "";
  double totalFees = 0.0;
  bool isExpanded = false;
  String? FcmToken="";
  String authToken="";
  String userName="", userId = "";

  String serviceIdEmergency="";
  String mechanicIdEmergency="";

  String carNameBrand="";
  String carNameModel="";

  String carPlateNumber="";
  int totalAmount = 0;

  late StateSetter mechanicAcceptance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i = 0; i<= widget.selectedService.length - 1 ; i++){
      yourItemList.add({
        "serviceCategoryId": '${widget.selectedService[i].categoryId}',
        "serviceId" : '${widget.selectedService[i].id}',
        "serviceName" : '${widget.mechanicListData!.mechanicService[i].service!.serviceName}',
        "serviceCost" : '${widget.mechanicListData!.mechanicService[i].fee}'
      });
      totalAmount = totalAmount + int.parse(widget.mechanicListData!.mechanicService[i].fee);
    }
    /*yourItemList.add({
        "serviceCategoryId": '${widget.selectedService[i].categoryId}',
        "serviceId" : '${widget.selectedService[i].id}',
        "serviceName" : '${widget.selectedService[i].serviceName}',
        "serviceCost" : '${widget.selectedService[i].maxPrice}'
      });*/

    print(' >>>>>>>>>>>>>> yourItemList \n $yourItemList >>>_RegularMechanicProfileViewScreenState yourItemList');

    print(' >>>>>>>>>>>>>> mechanicListData \n ${widget.mechanicListData} >>>>>>>_RegularMechanicProfileViewScreenState mechanicListData');

    getSharedPrefData();
    _isLoading = true;
    _listen();

    //_listenNotification(context);
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
      userId = shdPre.getString(SharedPrefKeys.userID).toString();

      print('authToken>>>>>>>>>_RegularMechanicProfileViewScreenState ' + authToken.toString());
      print('serviceIdEmergency>>>>>>>>_RegularMechanicProfileViewScreenState ' + serviceIdEmergency.toString());
      print('mechanicIdEmergency>>>>>>>_RegularMechanicProfileViewScreenState ' + mechanicIdEmergency.toString());

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
          _isLoading = false;
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {
          _isLoading = false;
          _mechanicDetailsMdl = value;
          reviewLength = int.parse('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length}') >= 2 ? 2 : _mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length;
          print(">>>> ${_mechanicDetailsMdl!.data!.mechanicDetails!.mechanicReviewsData}");
          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");
        });
      }
    });
    _homeCustomerBloc.mechanicsRegularBookingIDResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {

          print("mechanicsRegularBookingIDResponse success >>>");
          print("mechanicsRegularBookingIDResponse success booking id >>> " + '${value.data!.mechanicBooking!.id.toString()}' );

          //_serviceStatusUpdateBloc.postStatusUpdateRequest(authToken, value.data!.mechanicBooking!.id, "0");

          if(widget.regularServiceType == TextStrings.txt_pick_up){
            updateToCloudFirestoreDBPickUp(value.data!.mechanicBooking!.id, value.data!.mechanicBooking);
          }else if(widget.regularServiceType == TextStrings.txt_mobile_mechanic){
            updateToCloudFirestoreDBMobileMech(value.data!.mechanicBooking!.id, value.data!.mechanicBooking);
          }else{
            updateToCloudFirestoreDBTakeVehicle(value.data!.mechanicBooking!.id, value.data!.mechanicBooking);
          }
          //callOnFcmApiSendPushNotifications(value.data!.mechanicBooking!.id, value.data!.mechanicBooking);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingSuccessScreen(
                    bookingDate: _homeCustomerBloc.dateMonthConverter(value.data!.mechanicBooking!.bookedDate!).toString(),
                  )));

          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");
        });
      }
    });
  }

  Future<void> updateToCloudFirestoreDBPickUp(int bookingId, [MechanicBooking? mechanicBooking]) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. $yourItemList');

    String? token;
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      setState(() {
        FcmToken = value;
      });
      print("Instance ID Fcm Token: +++++++++ +++++ +++++ minnu " + token.toString());
    });

    _firestore
        .collection("Regular-PickUp")
        .doc('${bookingId}')
        .set({
        "bookingId" : "${bookingId}",
        "bookingDate": "${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
        "bookingTime": "${DateFormat("hh:mm a").format(DateTime.now())}",
        "scheduledDate": "${widget.serviceDate}",
        "scheduledTime" : "${widget.serviceTime}",
        "customerId": "${userId}",
        "customerName" : "${userName}",
        "customerLatitude" : "${widget.latitude}",
        "customerLongitude": "${widget.longitude}",
        "customerAddress" : "${widget.customerAddress}",
        "customerFcmToken" : "${token}",
        "mechanicPhone" : "${mechanicBooking!.mechanic!.phoneNo}",
        "customerPhone" : "${mechanicBooking.customer!.phoneNo}",
        "mechanicProfileUrl" : "${mechanicBooking.mechanic!.mechanic![0].profilePic}",
        "customerProfileUrl" : "${mechanicBooking.customer!.customer![0].profilePic}",
        "mechanicId": "${widget.mechanicId}",
        "mechanicName": "${widget.mechanicListData!.firstName}",
        "mechanicLatitude": "${widget.mechanicListData!.mechanicStatus[0].latitude}",
        "mechanicLongitude": "${widget.mechanicListData!.mechanicStatus[0].longitude}",
        "mechanicAddress" : "",
        "mechanicFcmToken" : "${widget.mechanicListData!.fcmToken}",
        "serviceList" : FieldValue.arrayUnion(yourItemList),
        "serviceTotalAmount" : '${totalAmount}',
        "vehicleId": "${mechanicBooking.vehicle!.id}",
        "vehicleName": "${mechanicBooking.vehicle!.brand} [ ${mechanicBooking.vehicle!.model} ]",
        "vehiclePlateNumber" : "${mechanicBooking.vehicle!.plateNo}",
        "vehicleColor" : "${mechanicBooking.vehicle!.color}",
        'isStartedFromLocation': "-1",
        'isArrived': "-1",
        "isBookedDate" : "-1",
        'isPickedUpVehicle': "-1",
        'isReachedServiceCenter': "-1",
        'isWorkStarted': "-1",
        'isWorkFinished': "-1",
        'isStartedFromLocationForDropOff': "-1",
        'isDropOff': "-1",
        'isPayment': "-1",
        'isPaymentRequested': "-1",
        'isPaymentRequestedTime': "",
        'latitude': '${widget.latitude}',
        'longitude': '${widget.longitude}'
      })
        .then((value) => print("ToCloudFirestoreDB - row - created"))
        .catchError((error) =>
        print("Failed to add row: $error"));

  }

  Future<void> updateToCloudFirestoreDBMobileMech(int bookingId, [MechanicBooking? mechanicBooking]) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. $yourItemList');

    String? token;
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      setState(() {
        FcmToken = value;
      });
      print("Instance ID Fcm Token: +++++++++ +++++ +++++ minnu " + token.toString());
    });

    _firestore
        .collection("${TextStrings.firebase_mobile_mech}")
        .doc('${bookingId}')
        .set({
      "bookingId" : "${bookingId}",
      "bookingDate": "${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
      "bookingTime": "${DateFormat("hh:mm a").format(DateTime.now())}",
      "scheduledDate": "${widget.serviceDate}",
      "scheduledTime" : "${widget.serviceTime}",
      "customerId": "${userId}",
      "customerName" : "${userName}",
      "customerLatitude" : "${widget.latitude}",
      "customerLongitude": "${widget.longitude}",
      "customerAddress" : "${widget.customerAddress}",
      "customerFcmToken" : "${token}",
      "mechanicPhone" : "${mechanicBooking!.mechanic!.phoneNo}",
      "customerPhone" : "${mechanicBooking.customer!.phoneNo}",
      "mechanicProfileUrl" : "${mechanicBooking.mechanic!.mechanic![0].profilePic}",
      "customerProfileUrl" : "${mechanicBooking.customer!.customer![0].profilePic}",
      "mechanicId": "${widget.mechanicId}",
      "mechanicName": "${widget.mechanicListData!.firstName}",
      "mechanicLatitude": "${widget.mechanicListData!.mechanicStatus[0].latitude}",
      "mechanicLongitude": "${widget.mechanicListData!.mechanicStatus[0].longitude}",
      "mechanicAddress" : "",
      "mechanicFcmToken" : "${widget.mechanicListData!.fcmToken}",
      "serviceList" : FieldValue.arrayUnion(yourItemList),
      "serviceTotalAmount" : '${totalAmount}',
      "vehicleId": "${mechanicBooking!.vehicle!.id}",
      "vehicleName": "${mechanicBooking.vehicle!.brand} [ ${mechanicBooking.vehicle!.model} ]",
      "vehiclePlateNumber" : "${mechanicBooking.vehicle!.plateNo}",
      "vehicleColor" : "${mechanicBooking.vehicle!.color}",
      "latitude" : "",
      "longitude" : "",
      "isBookedDate" : "-1",
      "isDriveStarted" : "-1",
      "isDriveStartedTime" : "",
      "isArrived": "-1",
      "isArrivedTime": "",
      "isWorkStarted" : "-1",
      "isWorkStartedTime" : "",
      "isWorkFinished" : "-1",
      "isWorkFinishedTime" : "",
      'isPaymentRequested': "-1",
      'isPaymentRequestedTime': "",
      "isPayment": "-1",
      "isPaymentTime": "",
    })
        .then((value) => print("ToCloudFirestoreDB - row - created"))
        .catchError((error) =>
        print("Failed to add row: $error"));
  }

  Future<void> updateToCloudFirestoreDBTakeVehicle(int bookingId, [MechanicBooking? mechanicBooking]) async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. $yourItemList');

    String? token;
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      setState(() {
        FcmToken = value;
      });
      print("Instance ID Fcm Token: +++++++++ +++++ +++++ minnu " + token.toString());
    });

    _firestore
        .collection("Regular-TakeVehicle")
        .doc('${bookingId}')
        .set({
      "bookingId" : "${bookingId}",
      "bookingDate": "${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
      "bookingTime": "${DateFormat("hh:mm a").format(DateTime.now())}",
      "scheduledDate": "${widget.serviceDate}",
      "scheduledTime" : "${widget.serviceTime}",
      "customerId": "${userId}",
      "customerName" : "${userName}",
      "customerLatitude" : "${widget.latitude}",
      "customerLongitude": "${widget.longitude}",
      "customerAddress" : "${widget.customerAddress}",
      "customerFcmToken" : "${token}",
      "mechanicPhone" : "${mechanicBooking!.mechanic!.phoneNo}",
      "customerPhone" : "${mechanicBooking.customer!.phoneNo}",
      "mechanicProfileUrl" : "${mechanicBooking.mechanic!.mechanic![0].profilePic}",
      "customerProfileUrl" : "${mechanicBooking.customer!.customer![0].profilePic}",
      "mechanicId": "${widget.mechanicId}",
      "mechanicName": "${widget.mechanicListData!.firstName}",
      "mechanicLatitude": "${widget.mechanicListData!.mechanicStatus[0].latitude}",
      "mechanicLongitude": "${widget.mechanicListData!.mechanicStatus[0].longitude}",
      "mechanicAddress" : "",
      "mechanicFcmToken" : "${widget.mechanicListData!.fcmToken}",
      "serviceList" : FieldValue.arrayUnion(yourItemList),
      "serviceTotalAmount" : '${totalAmount}',
      "vehicleId": "${mechanicBooking!.vehicle!.id}",
      "vehicleName": "${mechanicBooking.vehicle!.brand} [ ${mechanicBooking.vehicle!.model} ]",
      "vehiclePlateNumber" : "${mechanicBooking.vehicle!.plateNo}",
      "vehicleColor" : "${mechanicBooking.vehicle!.color}",
      "isDriveStarted" : "-1",
      "isArrived" : "-1",
      "isBookedDate" : "-1",
      "isReachedServiceCenter": "-1",
      "isReceivedVehicle" : "-1",
      "isWorkStarted" : "-1",
      "isWorkFinished" : "-1",
      "isPickedUpVehicle": "-1",
      'isPaymentRequested': "-1",
      'isPaymentRequestedTime': "",
      "isPayment": "-1",
      "paymentRecieved" : "-1",
      "completed" : "-1",
    })
        .then((value) => print("ToCloudFirestoreDB - row - created"))
        .catchError((error) =>
        print("Failed to add row: $error"));

  }

  Future<void> callOnFcmApiSendPushNotifications(int bookingId, [MechanicBooking? mechanicBooking]) async {
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
        'body': 'You have new Regular Service booking',
        'title': 'Notification',
        'sound': 'alarmw.wav',
      },
      'priority': 'high',
      'data': {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "bookingId" : "$bookingId",
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              _isLoading
                  ? Visibility(
                    visible: true,
                    child: Container(
                      height: size.height,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustColors.light_navy),
                        ),
                      ),
                    ),
                  )
                  : Column(
                children: [
                  appBarCustomUi(size),
                  profileImageAndKmAndReviewCount(size),
                  timeAndLocationUi(size),

                  /*_mechanicDetailsMdl == null
                    ? Container()
                    : reviewsUi(size),*/

                  _mechanicDetailsMdl!.data!.mechanicDetails!.mechanicReviewsData.toString() == '[]'
                      ? Container()
                      : reviewsUi(size),
                  selectedServiceDetailsUi(size),
                  acceptAndSendRequestButton( size,context)
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
                            widget.mechanicListData?.mechanic?[0].yearExp != null
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
                                    width: 70.0,
                                    height: 70.0,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child:Container(
                                            child:CircleAvatar(
                                                radius: 40,
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
                                          padding: const EdgeInsets.all(3),
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

                  if(!isExpanded){
                    reviewLength = int.parse('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length}');
                    isExpanded = true;
                  }else{
                    reviewLength = int.parse('${_mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length}') >= 2 ? 2 : _mechanicDetailsMdl?.data?.mechanicDetails?.mechanicReviewsData?.length;
                    isExpanded = false;
                  }

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( isExpanded ? 'Show less' : 'Load more',
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
                itemCount:widget.mechanicListData?.mechanicService?.length,
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
                                  Text('${widget.mechanicListData?.mechanicService?[index].fee}',
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
                    children: [
                      Text('Total Amount',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                        style: Styles.appBarTextBlack17,
                      ),
                    ],
                  ),
                  Spacer(),
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

          print('serviceIdEmergency>>>>>>>>11111 ' + serviceIdEmergency.toString());

          _homeCustomerBloc.postMechanicsRegularServiceBookingIDRequest(
            authToken,
            '${widget.serviceDate}',
            '${widget.serviceTime}',
            //'${widget.serviceTime}',
            '${widget.latitude}',
            '${widget.longitude}',
            '['+'${widget.serviceIds}'+']',
            '${widget.mechanicListData?.id}',
            "2",
            widget.regularServiceType == TextStrings.txt_pick_up
                ? '1'
                : widget.regularServiceType == TextStrings.txt_mobile_mechanic
                ? '2' : '3',
            '${totalAmount}',
            '1',
            '${_homeCustomerBloc.timeConvertWithoutAmPm(DateTime.now())}',);

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
    Future.delayed(const Duration(seconds: 35), () {


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
                            "Wait few minutes !",
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
