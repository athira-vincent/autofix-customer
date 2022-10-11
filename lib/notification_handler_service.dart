
import 'dart:convert';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'Notification',
  description: 'notifications from Your App Name.',
  importance: Importance.high,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
          goToNextScreen(data);
        }
      }
      /*onDidReceiveNotificationResponse: (NotificationResponse notificationResponse){
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          Map<String, dynamic> data = json.decode(payload);
          goToNextScreen(data);
        }
      },*/

    //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  //When the app is terminated, i.e., app is neither in foreground or background.
  FirebaseMessaging.instance.getInitialMessage().then((value){
    Fluttertoast.showToast(
        msg:
        "get initial message");
    //Its compulsory to check if RemoteMessage instance is null or not.
    if(value != null){
      goToNextScreen(value.data);
    }
  });

  //When the app is in the background, but not terminated.
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Fluttertoast.showToast(
        msg:
        "Notification on message opened 02");
    goToNextScreen(event.data);
  },
    cancelOnError: false,
    onDone: () {},
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {

    String screen = remoteMessage.data['screen'];
    if(screen.toString() == "IncomingJobOfferScreen"){
      _showTimeoutNotification(remoteMessage);
      // NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(remoteMessage.data);
      //
      // String bookingId = remoteMessage.data['bookingId'];
      // print("bookingId >>>>> " + bookingId );
      // notificationNavigatorKey.currentState!.pushNamed('/IncomingJobRequestScreen',arguments: notificationPayloadMdl);
    }
    else{
      Fluttertoast.showToast(
          msg:
          "Notification on message listen 03");
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;
      if (notification != null && android != null) {
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
                ),
                iOS: IOSNotificationDetails()
            ),
            payload: json.encode(remoteMessage.data),
          );
        }
      }
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

Future<void> goToNextScreen(Map<String, dynamic> data) async {
  Fluttertoast.showToast(
      msg: "goToNextScreen",
      timeInSecForIosWeb: 15
  );
  SharedPreferences _shdPre = await SharedPreferences.getInstance();
  String? _token = _shdPre.getString(SharedPrefKeys.token.toString());
  String? userType = _shdPre.getString(SharedPrefKeys.userType);
  print(' $userType ============= ');

  if (data['click_action'] != null) {

    /*Fluttertoast.showToast(
        msg: "Notification hit on change screen",
      timeInSecForIosWeb: 15
    );*/
    String screen = data['screen'];
    if(screen.toString() == "IncomingJobOfferScreen"){
      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(data);

      String bookingId = data['bookingId'];
      print("bookingId >>>>> " + bookingId );
      notificationNavigatorKey.currentState!.pushNamed('/IncomingJobRequestScreen',arguments: notificationPayloadMdl);
    } else if(userType.toString() == TextStrings.user_customer){
      notificationNavigatorKey.currentState!.pushNamed('/custNotificationList',);
    }else if (userType.toString() == TextStrings.user_mechanic){
      notificationNavigatorKey.currentState!.pushNamed('/mechNotificationList',);
    }else{
      /*Fluttertoast.showToast(
        msg: "Notification hit on change screen",
      timeInSecForIosWeb: 15
    );*/
    }
    /*switch (data['click_action']) {
      case "first_screen":
        navigatorKey.currentState.pushNamed(FirstScreen.routeName,);
        break;
      case "second_screen":
        navigatorKey.currentState.pushNamed(SecondScreen.routeName,);
        break;
      case "sample_screen":
        navigatorKey.currentState.pushNamed(SampleScreen.routeName,);
    }*/
    return;
  }
  Fluttertoast.showToast(
      msg:
      "Notification else part");
  //If the payload is empty or no click_action key found then go to Notification Screen if your app has one.
  //navigatorKey.currentState.pushNamed(NotificationPage.routeName,);
}

Future<String> _base64encodedImage(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  final String base64Data = base64Encode(response.bodyBytes);
  return base64Data;
}

Future<void> showNotificationWithChronometer(RemoteMessage remoteMessage) async {

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
}

showSimpleNotification(RemoteMessage remoteMessage) async {

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
}

Future<void> _showTimeoutNotification(RemoteMessage remoteMessage) async {
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
}

