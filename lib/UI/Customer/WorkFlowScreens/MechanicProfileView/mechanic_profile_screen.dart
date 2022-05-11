import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/MobileMechTracking/mobile_mechanic_tracking_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/PickUpDropOffTracking/pickUp_dropOff_tracking_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/booking_success_screen.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/listeners/NotificationListener.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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



  MechanicProfileViewScreen({
    required this.mechanicId,
    required this.authToken,
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



  String serverToken = 'AAAADMxJq7A:APA91bHrfSmm2qgmwuPI5D6de5AZXYibDCSMr2_qP9l3HvS0z9xVxNru5VgIA2jRn1NsXaITtaAs01vlV8B6VjbAH00XltINc32__EDaf_gdlgD718rluWtUzPwH-_uUbQ5XfOYczpFL';
  late final FirebaseMessaging    _messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;

  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  final NotificationListenerCall _notificationListener = NotificationListenerCall();



  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  double totalFees = 0.0;
  String authToken="";

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  //  _listenNotification();
    getSharedPrefData();
    _listen();

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
      totalFees = totalFees + double.parse('${widget.mechanicListData?.mechanicService?[0].fee.toString()}');
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
          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");
        });
      }
    });
    _homeCustomerBloc.mechanicsBookingIDResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {
          callOnFcmApiSendPushNotifications(1);

          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");

        });
      }
    });

  }

  _listenNotification(BuildContext context){
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {

      print("onMessage recieved from onMessage");
      print("onMessage event.notification!.data " + event.data.toString());


      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(event.data);

      print('${notificationPayloadMdl.id.toString()} >>>>>>>>onMessage');

      final provider = Provider.of<LocaleProvider>(context,listen: false);

      provider.setPayload(notificationPayloadMdl);





      /* String bookingId = event.data['bookingId']; // here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      //String notificationMessage = message.data['YOUR_KEY'];// here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      print("bookingId >>>>> " + bookingId );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>   MechanicTrackingScreen()
          )).then((value){
      });*/


    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print("onMessageOpenedApp recieved");
      print("event.notification!.data " + event.data.toString());






     /* //var data = message['data'] ?? message;
      String bookingId = event.data['bookingId']; // here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      //String notificationMessage = message.data['YOUR_KEY'];// here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      print("bookingId >>>>> " + bookingId );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  MechanicTrackingScreen()
          )).then((value){
      });*/


    });

    /*FirebaseMessaging.onBackgroundMessage((message) {

    });*/

    /*FirebaseMessaging.onMessageOpenedApp.listen((message) {
      setState(() {
        _counter += _counter;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  IncomingJobRequestScreen(serviceModel: "0",)
          )).then((value){
      });

      print('onMessageOpenedApp - Message clicked!');
      print("event.notification!.body " + message.notification!.body.toString());
      print("event.notification!.title " + message.notification!.title.toString());

      print("event.notification!.data " + message.data.toString());
      //var data = message['data'] ?? message;
      String bookingId = message.data['bookingId']; // here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      //String notificationMessage = message.data['YOUR_KEY'];// here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      print("bookingId >>>>> " + bookingId );

    });*/

  }


  @override
  Widget build(BuildContext context) {
    //_listenNotification(context);
    _notificationListener.listenNotification(context);
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomUi(size),
                profileImageAndKmAndReviewCount(size),
                timeAndLocationUi(size),
                reviewsUi(size),
                selectedServiceDetailsUi(size),
                widget.isEmergency ? acceptAndSendRequestButton( size,context) : acceptAndContinueButton(size, context),
              ],
            ),
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
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [

                        Container(
                          height: 60,
                          width: 60,
                          color: Colors.white,
                          child: CustomPaint(
                            painter: CurvePainter(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.mechanicListData?.mechanic?[0].yearExp} Year',
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
                                    child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
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
                          initialRating: 0,
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
                      Text('${widget.mechanicListData?.mechanic?[0].address}',
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
                itemCount:widget.mechanicListData?.mechanicReviewsData?.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index,) {
                  return GestureDetector(
                    onTap:(){

                    },
                    child:Column(
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
                                                    child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
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
                                            child: Text('Christopher',
                                              style: Styles.textLabelTitle12,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.visible,),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Text('${widget.mechanicListData?.mechanicReviewsData?[index].feedback}',
                                              style: Styles.textLabelTitle12,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.visible,),
                                          ),

                                          /*Row(
                                            children: [
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(top:8),
                                                child: Text('Read More',
                                                  style: Styles.textLabelTitle12,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,),
                                              ),
                                            ],
                                          ),*/
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
                    ),
                  );
                },
              ),
            ),
            Row(
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
                                  Text('${widget.mechanicListData?.mechanicService?[index].service?.serviceName}',
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
      onTap: (){

       /* Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  MechanicTrackingScreen()));*/

        print(">>>>>>>>>> Latitude  ${widget.latitude}");
        print(">>>>>>>>>> Longitude  ${widget.longitude}");
        print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
        print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
        print(">>>>>>>>>> ServiceId  ${widget.serviceIds}");

        callOnFcmApiSendPushNotifications(1);

        /*_homeCustomerBloc.postMechanicsBookingIDRequest(
           authToken,
          '${_homeCustomerBloc.dateConvert(DateTime.now())}',
          '${_homeCustomerBloc.timeConvert(DateTime.now())}',
          '${widget.latitude}',
          '${widget.longitude}',
          ' ${widget.serviceIds}',
          '${widget.mechanicListData?.id}',
          '2',
          '${widget.mechanicListData?.totalAmount}',
          '1',
          '${_homeCustomerBloc.timeConvertWithoutAmPm(DateTime.now())}',);*/

       /* launchMapsUrl(
            '10.5276',
            '76.2144',
            '10.0718',
            '76.5488');*/

        _showMechanicAcceptanceDialog(context);

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

  Widget acceptAndContinueButton(Size size, BuildContext context) {
    return InkWell(
      onTap: (){
        print("on press acceptAndContinueButton");
        if(widget.serviceModel == "Pick up & Drop off"){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PickUpDropOffTrackingScreen()));
        }
        if(widget.serviceModel == "Mobile Mechanic"){
          _showMechanicAcceptanceDialog(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MobileMechTrackingScreen()));
        }
        if(widget.serviceModel == "Take Vehicle to Mechanic"){
          _showMechanicAcceptanceDialog(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingSuccessScreen()));
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
                "Accept & continue",
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
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(left: 20, right: 20),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            "Wait for the response from George Dola!",
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


  Future<void> callOnFcmApiSendPushNotifications(int length) async {

    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("Instance ID Fcm Token: +++++++++ +++++ +++++ minnu " + token.toString());
    });


    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    // print('userToken>>>${appData.fcmToken}'); //alp dec 28

    final data = {
      'notification': {
        'body': 'You have $length new booking',
        'title': 'Maria',
        'sound': 'alarmw.wav',
      },
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
        'screen': 'screenA',
        "bookingId" : '60',
        "serviceName" : 'time Belt',
        "serviceId" : '1',
        "carPlateNumber" : 'KLmlodr876',
        "customerName" : 'Minnukutty',
        "customerAddress" : 'Elenjikkal House Empyreal Garden',
        "requestFromApp" : "0",
        'paymentStatus' : '0',
        'message': 'ACTION'
      },
      'apns': {
        'headers': {'apns-priority': '5', 'apns-push-type': 'background'},
        'payload': {
          'aps': {'content-available': 1, 'sound': 'alarmw.wav'}
        }
      },
      'to':'dlmPibElQV6AvuAshQbcZX:APA91bHtlcldalttox-Gb6G3s99YJX-MCv3d0QtQVd4uGgznm5VZVmZEqbPWzOBe_akZodjwNdb7Fz7tP2p7KUOVhSdfTlMHZGUhNlgN-25DT-iqGAORYUq3Vs60iJXSTp2jLzz3SHph'
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
      } else {
        print('notification sending failed');
      }
    } catch (e) {
      print('exception $e');
    }
  }

  void registerNotification() async {
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }





  Future<void> getPushNotification() async {

    initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    /*flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);*/

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print foreground message here.
      print(' onMessage Handling a foreground message ${message.messageId}');
      print('NotificationPayload : ${message.notification?.title}');
      print('NotificationPayload Message: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      // showNotification(' ${message.notification?.title}',' ${message.notification?.title}');

    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print foreground message here.
      print('onMessageOpenedApp Handling a foreground message ${message.messageId}');
      print('NotificationPayload : ${message.notification?.title}');
      print('NotificationPayload Message: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      else
        {
          print('Message not contained a notification:');

        }
      //showNotification(' ${message.notification?.title}',' ${message.notification?.title}');

    });


  }


  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name',
        playSound: true,
        showProgress: true,
        ticker: 'Kindersteps');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }


  static void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  }


}
