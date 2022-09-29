
import 'dart:convert';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

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

void setupFcm() {

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
            "Notification onselect notification", timeInSecForIosWeb: 15);
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
        "Notification on message opened");
    goToNextScreen(event.data);
  },
    cancelOnError: false,
    onDone: () {},
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    Fluttertoast.showToast(
        msg:
        "Notification on message listen");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      if (android.imageUrl != null && android.imageUrl!.trim().isNotEmpty) {
        final String largeIcon = await _base64encodedImage(
          android.imageUrl!,
        );

        final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(largeIcon),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
          contentTitle: notification.title,
          htmlFormatContentTitle: true,
          summaryText: notification.body,
          htmlFormatSummaryText: true,
          hideExpandedLargeIcon: true,
        );

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              //icon: '',
              color: CustColors.cloudy_blue,
              importance: Importance.max,
              priority: Priority.high,
              largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
              styleInformation: bigPictureStyleInformation,
            ),
          ),
          payload: json.encode(message.data),
        );
      }
      else {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              //icon: 'assets/images/work.png',
              color: CustColors.cloudy_blue,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: json.encode(message.data),
        );
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
  String? userTypeId = _shdPre.getString(SharedPrefKeys.userType.toString());
  print(' $_token ============= ');

  if (data['click_action'] != null) {

    Fluttertoast.showToast(
        msg: "Notification hit on change screen",
      timeInSecForIosWeb: 15
    );
    if(userTypeId.toString() == TextStrings.user_customer){
      navigatorKey.currentState!.pushNamed('/custNotificationList',);
    }else{
      navigatorKey.currentState!.pushNamed('/mechNotificationList',);
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


