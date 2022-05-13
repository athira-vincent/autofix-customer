// @dart=2.9
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/EmergencyTracking/mechanic_To_CustomerLocation_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/TrackingScreens/FindYourCustomer/find_your_customer_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:auto_fix/l10n/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'Provider/locale_provider.dart';
import 'UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp();
  }
  //await Firebase.initializeApp();
  await initHiveForFlutter();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

}

class _MyAppState extends State<MyApp> {

   Locale _locale = Locale.fromSubtags(languageCode: 'en') ;

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


    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context,listen: false);

          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: _locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                title: 'Banqmart',

                theme: ThemeData(
                  //brightness: Brightness.light,
                  primaryColor: Colors.white,
                ),
                /*home:  MechanicToCustomerLocationScreen(latitude:
                "10.0159",
                  longitude:
                    "76.3419",
                  bookingId: "2022",)*/
                home: MechanicTrackingScreen(latitude:
                "38.92747367732227",
                longitude:
                "-77.02016168273985",
                bookingId: "2022",)

              );
            },
          );
        });
  }
}
