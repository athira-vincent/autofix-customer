// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/cust_my_vehicles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'Provider/locale_provider.dart';
import 'package:provider/provider.dart';

import 'UI/Customer/RegularServiceFlow/CommonScreensInRegular/ServiceDetailsScreens/cust_service_regular_details_screen.dart';
import 'UI/Customer/RegularServiceFlow/MobileMechanicFlow/cust_mobile_mech_track_screen.dart';
import 'UI/Mechanic/EmergencyServiceMechanicFlow/TrackingScreens/FindYourCustomer/find_your_customer_screen.dart';

void main() async {
  await initHiveForFlutter();
  await runZonedGuarded(() async {
   WidgetsFlutterBinding.ensureInitialized();
   if(Platform.isAndroid)
     {
       await Firebase.initializeApp(
         options: const FirebaseOptions(
           apiKey: 'AIzaSyCnxRej1WXDW1kiBap9xmYR9IXBTcturMY',
           appId: '1:54966987696:android:96f910e016709a2ca84475',
           messagingSenderId: '54966987696',
           authDomain: 'autofix-336509.firebaseapp.com',
           projectId: 'autofix-336509',
         ),
       );
     }
   else
     {
       await Firebase.initializeApp();
     }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        runApp(MyApp());
      }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {

   Locale _locale = Locale.fromSubtags(languageCode: 'en');

   void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: CustColors.light_navy, //or set color with: Color(0xFF0000FF)
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LocaleProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProfileDataProvider(),),
      ],
      child:Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: _locale,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  title: 'ResolMech',
                  theme: ThemeData(
                    primaryColor: Colors.white,
                  ),
                  home: SplashScreen(),
                  //home:ServiceRegularDetailsScreen(),
                );
              },
            ),
    );
  }
}
