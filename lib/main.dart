// @dart=2.9
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/HomeCustomer/customer_home.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/TrackingFlow/PickUpDropOffTracking/pickUp_dropOff_tracking_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/Tracking/FindYourCustomer/find_your_customer_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/Tracking/PickupDropOff/customer_location_screen.dart';
import 'package:auto_fix/UI/NewScreens/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/TrackingFlow/tracking_Flow_UI/mechanic_Arrived_Screen.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/TrackingFlow/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/SearchService/search_service_screen.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/cust_my_vehicles.dart';
import 'package:auto_fix/UI/Customer/customer_home_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Ui/mechanic_my_profile.dart';
import 'package:auto_fix/UI/NewScreens/booking_success_screen.dart';
import 'package:auto_fix/UI/NewScreens/direct_payment_screen.dart';
import 'package:auto_fix/UI/NewScreens/direct_payment_success_screen.dart';
import 'package:auto_fix/UI/NewScreens/mechanic_work_progress_screen.dart';
import 'package:auto_fix/UI/NewScreens/payment_failed_screen.dart';
import 'package:auto_fix/UI/NewScreens/payment_success_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/both_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'UI/WelcomeScreens/Splash/splash_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionHandleColor: Colors.white,
        ),
        primarySwatch: CustColors.materialBlue,
        unselectedWidgetColor: CustColors.borderColor,
      ),
      //home: AddCarScreen(userCategory:TextStrings.user_customer ,userType: TextStrings.user_category_individual),
      //home: MechanicWorkCompletedScreen(authToken: "",mechanicId: "",),
     //home: WorkSelectionScreen(userCategory: TextStrings.user_category_individual,userType: TextStrings.user_mechanic),
      home: PickUpCustomerLocationScreen(),
      //home: SplashScreen(),
    );
  }
}
