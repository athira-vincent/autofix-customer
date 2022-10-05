import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_fix/DestinationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LocalNotifications extends StatefulWidget {

  String title;

  LocalNotifications({required this.title});

  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Notification',
    description: 'notifications from Your App Name.',
    importance: Importance.high,
  );

  @override
  void initState() {
    super.initState();
    requestPermissions();
    var androidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: ( notificationResponse){
          final String? payload = notificationResponse;
          if (notificationResponse != null) {
            print('notification payload: $payload');
            if (payload != null) {
              Map<String, dynamic> data = json.decode(payload);
              onClickNotification(payload);
            }
            Fluttertoast.showToast(
                msg: "Notification onDidReceiveNotificationResponse");

          }
        });

  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future onClickNotification(String payload) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DestinationScreen(
        payload: payload,
      );
    }));
  }

  showSimpleNotification() async {
    var androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        priority: Priority.high,
        importance: Importance.max
    );
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = new NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Simple Notification',
        platformDetails, payload: 'Destination Screen (Simple Notification)');
  }

  Future<void> showScheduleNotification() async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
    var androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      icon: 'mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    );
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.schedule(0, 'Flutter Local Notification', 'Flutter Schedule Notification',
        scheduledNotificationDateTime, platformDetails, payload: 'Destination Screen(Schedule Notification)');
  }

  Future<void> showPeriodicNotification() async {
     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: 'Channel Description'
    );
    var iOSDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Flutter Local Notification', 'Flutter Periodic Notification',
        RepeatInterval.everyMinute, notificationDetails, payload: 'Destination Screen(Periodic Notification)');
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("cover_image"),
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      contentTitle: 'Flutter Big Picture Notification Title',
      summaryText: 'Flutter Big Picture Notification Summary Text',
    );

    var androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        styleInformation: bigPictureStyleInformation);
    var iOSDetails = IOSNotificationDetails();
    var platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Big Picture Notification',
        platformDetails, payload: 'Destination Screen(Big Picture Notification)');
  }

  Future<void> showBigTextNotification() async {
    const BigTextStyleInformation bigTextStyleInformation =
    BigTextStyleInformation(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
          'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor '
          'in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt '
          'mollit anim id est laborum.',
      htmlFormatBigText: true,
      contentTitle: 'Flutter Big Text Notification Title',
      htmlFormatContentTitle: true,
      summaryText: 'Flutter Big Text Notification Summary Text',
      htmlFormatSummaryText: true,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'high_importance_channel', 'Channel Name',
        channelDescription: 'Channel Description',
        styleInformation: bigTextStyleInformation);
    var iOSDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails,iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Big Text Notification',
        notificationDetails, payload: 'Destination Screen(Big Text Notification)');
  }

  Future<void> showInsistentNotification() async {
    const int insistentFlag = 4;
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    var iOSDetails = IOSNotificationDetails();
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Insistent Notification',
        notificationDetails, payload: 'Destination Screen(Insistent Notification)');
  }

  Future<void> showOngoingNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'high_importance_channel', 'Channel Name',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        autoCancel: false);
    const iOSDetails = IOSNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter Local Notification', 'Flutter Ongoing Notification',
        notificationDetails, payload: 'Destination Screen(Ongoing Notification)');
  }

  Future<void> showProgressNotification() async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: i);
        var iOSDetails = IOSNotificationDetails();
        final NotificationDetails notificationDetails = NotificationDetails(
            android: androidNotificationDetails, iOS: iOSDetails);
        await flutterLocalNotificationsPlugin.show(0,
            'Flutter Local Notification', 'Flutter Progress Notification',
            notificationDetails, payload: 'Destination Screen(Progress Notification)');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('Simple Notification'),
                onPressed: () => showSimpleNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Schedule Notification'),
                onPressed: () => showScheduleNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Periodic Notification'),
                onPressed: () => showPeriodicNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Big Picture Notification'),
                onPressed: () => showBigPictureNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Big Text Notification'),
                onPressed: () => showBigTextNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Insistent Notification'),
                onPressed: () => showInsistentNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('OnGoing Notification'),
                onPressed: () => showOngoingNotification(),
              ),
              SizedBox(height: 15),
              RaisedButton(
                child: Text('Progress Notification'),
                onPressed: () => showProgressNotification(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
