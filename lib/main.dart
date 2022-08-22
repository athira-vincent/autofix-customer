// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/Provider/jobRequestNotifyProvider/job_request_notify_provider.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicProfileView/mechanic_profile_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/MobileMechanicFlow/MobileMechTracking/mobile_mechanic_tracking_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/emergencyServices.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:auto_fix/UI/SpareParts/SparePartsList/spare_parts_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/emergancy_service_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/both_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/regular_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/work_selection_screen.dart';

import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'Provider/locale_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHiveForFlutter();
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCnxRej1WXDW1kiBap9xmYR9IXBTcturMY',
          appId: '1:54966987696:android:96f910e016709a2ca84475',
          messagingSenderId: '54966987696',
          authDomain: 'autofix-336509.firebaseapp.com',
          projectId: 'autofix-336509',
        ),
      );
    } else {
      //WidgetsFlutterBinding.ensureInitialized();
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

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
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
    //_listenNotification(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor:
          CustColors.light_navy, //or set color with: Color(0xFF0000FF)
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LocaleProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProfileDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: JobRequestNotifyProvider(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AddCartBloc>(
                create: (context) => AddCartBloc(),
              ),
              BlocProvider(
                create: (context) =>
                ShowCartPopBloc()..add(FetchShowCartPopEvent()),
              ),
              BlocProvider<DeleteCartBloc>(
                create: (context) => DeleteCartBloc(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: _locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              title: 'ResolMech',
              theme: ThemeData(
                primaryColor: Colors.white,
                primarySwatch: CustColors.materialBlue,
              ),
              //home: SparePartsListScreen(modelname: "TIGUAN"),
              //home: WorkSelectionScreen(userType: "mechanic", userCategory: "individual"),
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
