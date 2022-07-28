
import 'package:auto_fix/Provider/jobRequestNotifyProvider/job_request_notify_provider.dart';
import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/IncomingJobRequestScreen/incoming_job_request_screen.dart';
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
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    child = widget.child;
    if(mounted){
      setState(() {
        _listenNotification(context);
      });
    }
  }


  _listenNotification(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(">>>message received onMessage");

      print("event.notification!.data " + event.data.toString());
      _serialiseAndNavigate(event, _scaffold.currentContext!);
    });

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
      // final provider = Provider.of<JobRequestNotifyProvider>(context1, listen: false);
      // provider.setJobRequestNotifyProvider(notificationPayloadMdl);

      String bookingId = message.data['bookingId'];
      print("bookingId >>>>> " + bookingId );

      final provider1 = Provider.of<LocaleProvider>(_scaffold.currentContext!,listen: false);
      setState(() {

        provider1.setPayload(notificationPayloadMdl);
        print("provider data >>>> "+  provider1.payloadMdl.screen);

      });
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IncomingJobRequestScreen()),
        );
      });

      /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context1) =>  IncomingJobRequestScreen()
          )).then((value){
      });*/

      //Navigator.of(context).pushNamed("/IncomingJobRequestScreen");
      //----------
    }
    /*Navigator.push(
      context,
      MaterialPageRoute(
          builder: (newcontext) =>
          ChangeNotifierProvider<YourModel>.value(
            value: Provider.of<YourModel>(context),
            child: newView,
          )
      ),
    );*/
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
   // _listenNotification(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant NotificationHandler oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
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
