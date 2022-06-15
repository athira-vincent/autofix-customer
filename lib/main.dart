// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/ExtraDiagnosisScreen/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicWorkProgressScreen/mechanic_work_progress_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/PaymentScreens/mechanic_waiting_payment.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/RateMechanic/rate_mechanic_screen.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/cust_my_vehicles.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/CustomerApproved/customer_approved_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/MechanicStartService/mechanic_start_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/TrackingScreens/FindYourCustomer/find_your_customer_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/emergancy_service_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/work_selection_screen.dart';
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

import 'UI/Mechanic/BottomBar/AddPriceFault/add_price_fault.dart';


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
                  primaryColor: Colors.white,
                ),
                 home: WorkSelectionScreen(userType: TextStrings.user_mechanic,userCategory: "2",),
                // home: DirectPaymentScreen(isMechanicApp: false,isPaymentFailed: false,),
                // home: FindYourCustomerScreen(latitude: "38.2345",longitude: "74.323",),
                // home: AddCarScreen(userType: TextStrings.user_mechanic , userCategory: "0",fromPage: "0",),
                //home: SplashScreen(),
              );
            },
          );
        });
  }

}
