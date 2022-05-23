// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
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
    //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    await Firebase.initializeApp();
    //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  //await Firebase.initializeApp();
  await initHiveForFlutter();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /*runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    // Pass all uncaught errors from the framework to Crashlytics.
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });*/
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

    //initialise firebase and crashlytics
   /* Future<void> _initializeFirebase() async {
      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }*/

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

                home: SplashScreen(),
                //home: MechanicStartServiceScreen(),

                // home: MechanicWorkCompletedScreen(),

                 // home: MechanicStartServiceScreen(),

                 // home: CustomerApprovedScreen(),

                 // home: DirectPaymentSuccessScreen()

                 // home:   MechanicWorkProgressScreen(workStatus: "2",)

                // home: MechanicTrackingScreen(latitude: "10.0159", longitude: "76.3419",)


              );
            },
          );
        });
  }
}
