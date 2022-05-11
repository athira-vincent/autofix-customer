import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  //late Locale _locale;

  //Locale get locale => _locale;

  NotificationPayloadMdl? _payloadMdl;

  NotificationPayloadMdl get payloadMdl => _payloadMdl!;



  // void setLocale(Locale locale) {
  //   if (!L10n.all.contains(locale)) return;
  //
  //   _locale = locale;
  //   notifyListeners();
  // }
  //
  // void clearLocale() {
  //  // _locale = null;
  //   notifyListeners();
  // }

  void setPayload(NotificationPayloadMdl notificationPayloadMdl) {
    // if (!L10n.all.contains(locale)) return;
    //
    // _locale = locale;
    _payloadMdl=notificationPayloadMdl;
    print('_payloadMdl OnMessege ${_payloadMdl?.serviceName}');
    notifyListeners();
  }


}
