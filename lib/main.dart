// @dart=2.9
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Common/add_more_service_list_screen.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/mechaniclist_for_services_Mdl.dart';
import 'package:auto_fix/UI/Customer/PaymentScreens/direct_payment_success_screen.dart';
import 'package:auto_fix/UI/Customer/PaymentScreens/payment_success_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/EmergencyFindMechanicList/find_mechanic_list_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/MechanicProfileView/mechanic_profile_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_work_progress_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/schedule_regular_service_screen.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/customer_approved_screen.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/picked_up_vehicle_screen.dart';
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

   List<MechaniclistForService> mechanicListForServices = [
     MechaniclistForService(id: "1",
         userCode: "012",firstName: "athira",
         lastName: "a",phoneNo: "123454676",emailId: "athira@gmail.com",
         state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
         mechanicService: [new MechanicService(id: "1",status: 1, fee: "2000", serviceId: 1, userId: 1)],
         mechanicVehicle: [new MechanicVehicle(status: 1, id: "1", makeId: 1)]
     ),
     MechaniclistForService(id: "12",
         userCode: "014",firstName: "Ammu",
         lastName: "a",phoneNo: "123454676",emailId: "ammu@gmail.com",
         state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
         mechanicService: [new MechanicService(id: "2",status: 1, fee: "2010", serviceId: 2, userId: 12)],
         mechanicVehicle: [new MechanicVehicle(status: 1, id: "3", makeId: 2)]
     ),
     MechaniclistForService(id: "12",
         userCode: "014",firstName: "BBB",
         lastName: "a",phoneNo: "123454676",emailId: "ammu@gmail.com",
         state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
         mechanicService: [new MechanicService(id: "2",status: 1, fee: "2010", serviceId: 2, userId: 12)],
         mechanicVehicle: [new MechanicVehicle(status: 1, id: "3", makeId: 2)]
     ),
     MechaniclistForService(id: "12",
         userCode: "014",firstName: "CCCCCC",
         lastName: "a",phoneNo: "123454676",emailId: "ammu@gmail.com",
         state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
         mechanicService: [new MechanicService(id: "2",status: 1, fee: "2010", serviceId: 2, userId: 12)],
         mechanicVehicle: [new MechanicVehicle(status: 1, id: "3", makeId: 2)]
     ),
   ];

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
      /*home: MechanicProfileViewScreen(
        authToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTAsInVzZXJUeXBlSWQiOjEsImlhdCI6MTY1MTA1MTU4NSwiZXhwIjoxNjUxMTM3OTg1fQ.44G0n2QgaAaZlO4A6XbpCB9FqH9Y9pczWyHzE77gNaY',
        isEmergency: true,
        mechaniclistForService: mechanicListForServices[0],
        mechanicId: "1",
      ),*/
      home: SplashScreen(),
      //home: MechanicHomeScreen(),
      //home: CustomerApprovedScreen(serviceModel: "0"),
      //home: CustomerHomeScreen(),
    );
  }
}
