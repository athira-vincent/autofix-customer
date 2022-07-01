import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 class NotificationListenerCall {

  listenNotification(BuildContext context){

   FirebaseMessaging.onMessage.listen((RemoteMessage event) async {

    print("onMessage recieved from onMessage");
    print("onMessage event.notification!.data " + event.data.toString());

    NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(event.data);
    print('${notificationPayloadMdl.id.toString()} >>>>>>>>onMessage');
    final provider = Provider.of<LocaleProvider>(context,listen: false);
    provider.setPayload(notificationPayloadMdl);


   });
  }


 }
