
import 'dart:async';
import 'dart:convert';
import 'package:auto_fix/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'Notification',
  description: 'notifications from Your App Name.',
  importance: Importance.high,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  SharedPreferences _shdPre = await SharedPreferences.getInstance();
  String screen = message.data['screen'];
  if(screen.toString() == "IncomingJobOfferScreen") {
    //_showTimeoutNotification(message);
    //goToNextScreen_OnAppWorking(message.data);
    NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(message.data);
    _shdPre.setBool(SharedPrefKeys.haveActiveServiceRequest, true);
    _shdPre.setString(SharedPrefKeys.activeServiceRequestData, jsonEncode(notificationPayloadMdl));
    print('===> ${_shdPre.getBool(SharedPrefKeys.haveActiveServiceRequest)} ============= 01');
    print('===> ${_shdPre.getString(SharedPrefKeys.activeServiceRequestData)} ============= 01');

  }
  print('Handling a background message ${message.messageId}');
}

Future<void> setupFcm() async {
  Fluttertoast.showToast(
      msg: "setupFcm");
  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOs = const IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOs,
  );

  //when the app is in foreground state and you click on notification.
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload){
        Fluttertoast.showToast(
            msg:
            "Notification onselect notification01", timeInSecForIosWeb: 15);
        if (payload != null) {
          Map<String, dynamic> data = json.decode(payload);
          goToNextScreen_OnClickNotification(data);
        }
      }
    //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  //When the app is terminated, i.e., app is neither in foreground or background.
  FirebaseMessaging.instance.getInitialMessage().then((value){
    Fluttertoast.showToast(
        msg: "get initial message");
    //Its compulsory to check if RemoteMessage instance is null or not.
    if(value != null){

      goToNextScreen_OnClickNotification(value.data);
    }
  });

  //When the app is in the background, but not terminated.
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Fluttertoast.showToast(
        msg:
        "Notification on message opened 02");
    goToNextScreen_OnClickNotification(event.data);
  },
    cancelOnError: false,
    onDone: () {},
  );
  FirebaseMessaging.onBackgroundMessage((message) {
    return firebaseMessagingBackgroundHandler(message) ;
  }
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {

    print(">>>> message listn 06 ${remoteMessage.messageId}");

    String screen = remoteMessage.data['screen'];
    if(screen.toString() == "IncomingJobOfferScreen"){
      Fluttertoast.showToast(
          msg:
          "Notification on message listen 10");
      goToNextScreen_OnAppWorking(remoteMessage.data);
    }
    else{
      Fluttertoast.showToast(
          msg:
          "Notification on message listen 03");
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;
      if (notification != null && android != null) {
        print(">>>> message listn 03");
        if (remoteMessage.notification?.android!.imageUrl != null
            && remoteMessage.notification!.android!.imageUrl!.trim().isNotEmpty) {
          final String largeIcon = await _base64encodedImage(
            remoteMessage.notification!.android!.imageUrl!,
          );
          print(">>>> message listn 02");
          final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            contentTitle: remoteMessage.notification!.title,
            htmlFormatContentTitle: true,
            summaryText: remoteMessage.notification!.body,
            htmlFormatSummaryText: true,
            hideExpandedLargeIcon: true,
          );

          flutterLocalNotificationsPlugin.show(
            remoteMessage.hashCode,
            remoteMessage.notification!.title,
            remoteMessage.notification!.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                //channel.id,
                "5",
                channel.name,
                channelDescription: channel.description,
                icon: 'mipmap/ic_launcher',
                importance: Importance.max,
                priority: Priority.high,
                largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
                styleInformation: bigPictureStyleInformation,
              ),
            ),
            payload: json.encode(remoteMessage.data),
          );
        }
        else {
          print(">>>> message listn 04");
          flutterLocalNotificationsPlugin.show(
            remoteMessage.hashCode,
            remoteMessage.notification!.title,
            remoteMessage.notification!.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  "5",
                  channel.name,
                  channelDescription: channel.description,
                  importance: Importance.max,
                  priority: Priority.high,
                ),
                iOS: IOSNotificationDetails()
            ),
            payload: json.encode(remoteMessage.data),
          );

        }

      }
      print(">>>> message listn 05");
      await flutterLocalNotificationsPlugin.cancel(5);
    }
  });
}

Future<void> deleteFcmToken() async {
  return await FirebaseMessaging.instance.deleteToken();
  
}

Future<String> getFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  return Future.value(token);
}

Future<void> goToNextScreen_OnClickNotification(Map<String, dynamic> data) async {
  Fluttertoast.showToast(
      msg: "goToNextScreen",
      timeInSecForIosWeb: 15
  );
  SharedPreferences _shdPre = await SharedPreferences.getInstance();
  String? userType = _shdPre.getString(SharedPrefKeys.userType);
  print(' $userType ============= 01');
  Duration time;

  if (data['click_action'] != null) {
    print(">>>> message listn 02");

    String screen = data['screen'];
    if(screen.toString() == "IncomingJobOfferScreen"){

      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(data);

      Repository().getCurrentWorldTime("Nairobi").then((value01) => {

        time = DateTime.fromMillisecondsSinceEpoch( int.parse(notificationPayloadMdl.customerCurrentTime)).
        difference(DateTime.fromMillisecondsSinceEpoch(int.parse(value01.datetime!.millisecondsSinceEpoch.toString()))),

        if(time.inSeconds > -30){

          Timer(const Duration(seconds: 4), () {
            String bookingId = data['bookingId'];
            print("bookingId >>>>> " + bookingId);
            notificationNavigatorKey.currentState!.pushNamed(
            '/IncomingJobRequestScreen', arguments: notificationPayloadMdl);
          })

        }else{
          Fluttertoast.showToast(msg: "Time Expired"),
          print("Time Expired"),
          _shdPre.setBool(SharedPrefKeys.haveActiveServiceRequest, false),
          _shdPre.setString(SharedPrefKeys.activeServiceRequestData, "")
        }
      });

    } else if(userType.toString() == TextStrings.user_customer){
      Timer(const Duration(seconds: 4), () {
        notificationNavigatorKey.currentState!.pushNamed(
          '/custNotificationList',);
      });
    }else if (userType.toString() == TextStrings.user_mechanic){
      Timer(const Duration(seconds: 4), ()
      {
        notificationNavigatorKey.currentState!.pushNamed(
          '/mechNotificationList',);
      });
    }else{
      Fluttertoast.showToast(
          msg: "Notification else part");
    }
    return;
  }
  //If the payload is empty or no click_action key found then go to Notification Screen if your app has one.
  //navigatorKey.currentState.pushNamed(NotificationPage.routeName,);
}

Future<void> goToNextScreen_OnAppBackground(Map<String, dynamic> data) async {
  Fluttertoast.showToast(
      msg: "goToNextScreen_OnAppBackground",
      timeInSecForIosWeb: 15
  );

    String screen = data['screen'];
    if(screen.toString() == "IncomingJobOfferScreen"){
      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(data);

      String bookingId = data['bookingId'];
      print("bookingId >>>>> " + bookingId );
      notificationNavigatorKey.currentState!.pushNamed('/IncomingJobRequestScreen',arguments: notificationPayloadMdl);
    } else{

    }
}

Future<void> goToNextScreen_OnAppWorking(Map<String, dynamic> data) async {
  Fluttertoast.showToast(
      msg: "goToNextScreen_OnAppWorking",
      timeInSecForIosWeb: 15
  );

  String screen = data['screen'];
  if(screen.toString() == "IncomingJobOfferScreen"){
    NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(data);

    String bookingId = data['bookingId'];
    print("bookingId >>>>> " + bookingId );
    print("current Time >>>>>  ${notificationPayloadMdl.customerCurrentTime}");
    notificationNavigatorKey.currentState!.pushNamed('/IncomingJobRequestScreen',arguments: notificationPayloadMdl);
  } else{
    Fluttertoast.showToast(
        msg: "Notification hit on change screen",
      timeInSecForIosWeb: 15
    );
  }
}

Future<String> _base64encodedImage(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  final String base64Data = base64Encode(response.bodyBytes);
  return base64Data;
}

/*Future<void> showNotificationWithChronometer(RemoteMessage remoteMessage) async {

  print("showNotificationWithChronometer");
  Fluttertoast.showToast(
      msg: "showNotificationWithChronometer",
      timeInSecForIosWeb: 25
  );

  if (remoteMessage.notification?.android!.imageUrl != null
      && remoteMessage.notification!.android!.imageUrl!.trim().isNotEmpty) {
    final String largeIcon = await _base64encodedImage(
      remoteMessage.notification!.android!.imageUrl!,
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(largeIcon),
      largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
      contentTitle: remoteMessage.notification!.title,
      htmlFormatContentTitle: true,
      summaryText: remoteMessage.notification!.body,
      htmlFormatSummaryText: true,
      hideExpandedLargeIcon: true,
    );
    flutterLocalNotificationsPlugin.show(
      remoteMessage.hashCode,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            styleInformation: bigPictureStyleInformation,
            when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
            usesChronometer: true,
            ongoing: true,
            autoCancel: false,
            color: const Color.fromARGB(255, 255, 0, 0),
            ledColor: const Color.fromARGB(255, 255, 0, 0),
            ledOnMs: 1000,
            ledOffMs: 500
          // color: Color.fromARGB(0, 50, 0, 0),
          // colorized: true,
        ),
      ),
      payload: json.encode(remoteMessage.data),
    );
  }
  else {
    flutterLocalNotificationsPlugin.show(
      remoteMessage.hashCode,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.high,
              when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
              usesChronometer: true,
              ongoing: true,
              autoCancel: false,
              color: const Color.fromARGB(255, 255, 0, 0),
              ledColor: const Color.fromARGB(255, 255, 0, 0),
              ledOnMs: 1000,
              ledOffMs: 500
          ),
          iOS: IOSNotificationDetails()
      ),
      payload: json.encode(remoteMessage.data),
    );
  }
}*/

/*showSimpleNotification(RemoteMessage remoteMessage) async {

  if (remoteMessage.notification?.android!.imageUrl != null
      && remoteMessage.notification!.android!.imageUrl!.trim().isNotEmpty) {
    final String largeIcon = await _base64encodedImage(
      remoteMessage.notification!.android!.imageUrl!,
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(largeIcon),
      largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
      contentTitle: remoteMessage.notification!.title,
      htmlFormatContentTitle: true,
      summaryText: remoteMessage.notification!.body,
      htmlFormatSummaryText: true,
      hideExpandedLargeIcon: true,
    );
    flutterLocalNotificationsPlugin.show(
      remoteMessage.notification.hashCode,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'mipmap/ic_launcher',
          color: CustColors.cloudy_blue,
          importance: Importance.max,
          priority: Priority.high,
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
          styleInformation: bigPictureStyleInformation,
        ),
      ),
      payload: json.encode(remoteMessage.data),
    );
  }
  else {
    flutterLocalNotificationsPlugin.show(
          remoteMessage.notification.hashCode,
          remoteMessage.notification!.title,
          remoteMessage.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'mipmap/ic_launcher',
              color: CustColors.cloudy_blue,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: json.encode(remoteMessage.data),
        );
  }
}*/

///-------- method to show notification with time out ---------------
/*Future<void> _showTimeoutNotification(RemoteMessage remoteMessage) async {
  //Map<String, dynamic> data = json.decode(remoteMessage.data[0]);

  print("_showTimeoutNotification data >>>> ${json.encode(remoteMessage.data)}");
  Fluttertoast.showToast(
      msg: "Notification onSelect notification 04", timeInSecForIosWeb: 15);
   AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      timeoutAfter: 50000,
      styleInformation: DefaultStyleInformation(true, true));
   NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      remoteMessage.hashCode,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,
      notificationDetails,
    payload: json.encode(remoteMessage.data),
  );
}*/

