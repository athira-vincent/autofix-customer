
import 'package:auto_fix/Common/NotificationPayload/notification_mdl.dart';
import 'package:flutter/material.dart';

class JobRequestNotifyProvider extends ChangeNotifier {

  NotificationPayloadMdl? notificationPayloadMdl;

  NotificationPayloadMdl get getNotificationPayloadMdl{
    return notificationPayloadMdl!;
  }

  void setJobRequestNotifyProvider(NotificationPayloadMdl notificationPayloadMdl) {
    this.notificationPayloadMdl = notificationPayloadMdl;
    notifyListeners();
  }

}
