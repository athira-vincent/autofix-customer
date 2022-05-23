// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/PaymentScreens/direct_payment_success_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/EmergencyTracking/mechanic_To_CustomerLocation_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/TrackingScreens/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_waiting_payment.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_work_progress_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/TrackingScreens/FindYourCustomer/find_your_customer_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/customer_approved_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:auto_fix/l10n/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'Provider/locale_provider.dart';
import 'UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  await initHiveForFlutter();
  await runZonedGuarded(() async {
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCnxRej1WXDW1kiBap9xmYR9IXBTcturMY',
        appId: '1:54966987696:android:96f910e016709a2ca84475',
        messagingSenderId: '54966987696',
        authDomain: 'autofix-336509.firebaseapp.com',
        projectId: 'autofix-336509',
      ),
    );
    //FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}


/*void main() async {

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

}*/

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
                title: 'ResolMech',
                theme: ThemeData(
                  //brightness: Brightness.light,
                  primaryColor: Colors.white,
                ),

                home: SplashScreen(),

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
