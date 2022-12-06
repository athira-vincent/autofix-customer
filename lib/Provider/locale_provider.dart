import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  late Locale _locale;/*=L10n.all.elementAt(0);*/

  Locale get locale{
    //getLocaleFromSettings();
    return _locale;
  }

  // NotificationPayloadMdl? _payloadMdl;
  //
  // NotificationPayloadMdl get payloadMdl => _payloadMdl!;

  void setLocale(Locale locale) {

    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    //_locale = null;
    notifyListeners();
  }

   getLocaleFromSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString(SharedPrefKeys.userLanguageCode)??"en";
    Locale newLocale = Locale(code);
    if(code == 'en') {
      _locale = Locale('en');
    } else if(code == 'ig'){
      _locale = Locale('ig');
    } else if(code == 'ha'){
      _locale = Locale('ha');
    }else if(code == 'yo'){
      _locale = Locale('yo');
    }
    print("getLocaleFromSettings >>> $_locale");
  }

  // void setPayload(NotificationPayloadMdl notificationPayloadMdl) {
  //   // if (!L10n.all.contains(locale)) return;
  //   //
  //   // _locale = locale;
  //   _payloadMdl=notificationPayloadMdl;
  //   print('_payloadMdl OnMessege ${_payloadMdl?.serviceName}');
  //   notifyListeners();
  // }


}
