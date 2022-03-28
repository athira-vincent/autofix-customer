// @dart=2.9
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/rate_mechanic_screen.dart';
import 'package:auto_fix/UI/NewScreens/add_delivery_address_screen.dart';
import 'package:auto_fix/UI/NewScreens/change_delivery_address_screen.dart';
import 'package:auto_fix/UI/NewScreens/purchase_response_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'UI/Customer/BottomBar/Home/HomeCustomer/customer_home.dart';
import 'UI/SpareParts/FilterScreen/filter_screen.dart';
import 'UI/SpareParts/MyCart/my_cart_screen.dart';
import 'UI/SpareParts/SparePartsList/spare_parts_list_screen.dart';
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
      statusBarColor: CustColors.blue, //or set color with: Color(0xFF0000FF)
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
      home: SplashScreen(),
      //home: MyCartScreen(),
      //home: MechanicWorkCompletedScreen(authToken: "",mechanicId: "",),
      //home: MechanicStartServiceScreen(),
     // home: RateMechanicScreen(),
      //home: ChangeDeliveryAddressScreen(),
    );
  }
}
