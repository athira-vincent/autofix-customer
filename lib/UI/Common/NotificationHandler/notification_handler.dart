
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Provider/jobRequestNotifyProvider/job_request_notify_provider.dart';
import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/ServiceDetailsScreens/cust_service_regular_details_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceDetailsScreen/mech_service_regular_details_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class NotificationHandler extends StatefulWidget {
  final Widget child;

  NotificationHandler({required this.child});

  @override
  State<StatefulWidget> createState() {
    return _NotificationHandlerState();
  }
}

class _NotificationHandlerState extends State<NotificationHandler> {
  final FirebaseMessaging fm = FirebaseMessaging.instance;
  late Widget child;
  GlobalKey<NavigatorState> _scaffold = new GlobalKey<NavigatorState>();
  //late JobRequestNotifyProvider provider1;
  late NavigatorState _navigator;
  @override
  void initState() {
    super.initState();
    child = widget.child;
    if(mounted){
      setState(() {
      //  _listenNotification(context);
      });
    }
  }
  @override
  void didChangeDependencies() {
    // provider1 = Provider.of<JobRequestNotifyProvider>(context,listen: false);
     _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }
  _listenNotification(BuildContext context) {

    /*print("jgjgsjghgh  0002 ${context}");
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(">>>message received onMessage");
      print("jgjgsjghgh  0003 ${context} ");
      print("event.notification!.data " + event.data.toString());
      _serialiseAndNavigate(event, context);
    });*/

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(">>>message received onMessageOpenedApp");
      _serialiseAndNavigate(event, _scaffold.currentContext!);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("onBackgroundMessage " + message.data.toString());

      print(">>>message.notification!.data " + message.data.toString());
      _serialiseAndNavigate(message, _scaffold.currentContext!);
    });
  }

  void _serialiseAndNavigate(RemoteMessage message, BuildContext context1){
    print(" >>>> _serialiseAndNavigate");

    String screen = message.data['screen'];
    print(">>>> Screen " + screen);
    if(screen.toString() == "IncomingJobOfferScreen"){
      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(message.data);

      String bookingId = message.data['bookingId'];
      print("bookingId >>>>> " + bookingId );
      print("nhjdkjhjk $context1");
      _navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => IncomingJobRequestScreen(notificationPayloadMdl: notificationPayloadMdl,)),
        );

    }else if(screen.toString() == "mechanicServiceDetails"){
      print( " >>> onBackgroundMessage mechanicServiceDetails");
      _navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => MechServiceRegularDetailsScreen(
          bookingId: message.data['bookingId'],
          firebaseCollection: message.data['regularType'].toString()  == "1"
              ?
          TextStrings.firebase_pick_up
          : message.data['regularType'].toString()  == "2" ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle ,
        )),
      );
    }else if(screen.toString() == "customerServiceDetails"){
      print( " >>> onBackgroundMessage customerServiceDetails");
      _navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => CustServiceRegularDetailsScreen(
          bookingId: message.data['bookingId'],
          firebaseCollection: message.data['regularType'].toString()  == "1"
              ?
          TextStrings.firebase_pick_up
              : message.data['regularType'].toString()  == "2" ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle ,
        )),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    print("jgjgsjghgh  0001 ");
    if(mounted) {
      print("jgjgsjghgh  0005 ");
      _listenNotification(context);
    }
    //_listenNotification(context);
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    return Scaffold(
      key: _scaffold,
      body: child,)
      ;
  }

/*  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("onBackgroundMessage " + message.data.toString());

    print(">>>message.notification!.data " + message.data.toString());
    _serialiseAndNavigate(message,);

    print("Handling a background message: ${message.messageId}");
    print(message.data);
  }*/


}
