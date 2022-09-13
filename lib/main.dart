// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/Provider/chat_provider.dart';
import 'package:auto_fix/Provider/jobRequestNotifyProvider/job_request_notify_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_bloc.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/EmergencyTracking/mechanic_tracking_Screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicProfileView/mechanic_profile_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/RateMechanic/rate_mechanic_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularRateMechanic/regular_rate_mechanic_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/MobileMechanicFlow/MobileMechTracking/mobile_mechanic_tracking_screen.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/emergencyServices.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cust_rating_bloc/cust_rating_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_oder_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:auto_fix/UI/SpareParts/SparePartsList/spare_parts_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/emergancy_service_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/both_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/regular_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/work_selection_screen.dart';

import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:auto_fix/UI/chat/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
              BlocProvider<SparePartListBloc>(
                create: (context) => SparePartListBloc(),
              ),
              BlocProvider(
                create: (context) =>
                    ShowCartPopBloc()..add(FetchShowCartPopEvent()),
              ),
              BlocProvider<DeleteCartBloc>(
                create: (context) => DeleteCartBloc(),
              ),
              BlocProvider<AddressBloc>(
                create: (context) => AddressBloc(),
              ),
              BlocProvider<AddAddressBloc>(
                create: (context) => AddAddressBloc(),
              ),
              BlocProvider<EditAddressBloc>(
                create: (context) => EditAddressBloc(),
              ),
              BlocProvider<DeleteAddressBloc>(
                create: (context) => DeleteAddressBloc(),
              ),
              BlocProvider<PlaceOrderBloc>(
                create: (context) => PlaceOrderBloc(),
              ),
              BlocProvider<OrderListBloc>(
                create: (context) => OrderListBloc(),
              ),
              BlocProvider<CancelOrderBloc>(
                create: (context) => CancelOrderBloc(),
              ),
              BlocProvider<CodBloc>(
                create: (context) => CodBloc(),
              ),
              BlocProvider<CustRatingBloc>(
                create: (context) => CustRatingBloc(),
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
              home: SplashScreen(),
              //home: ChatScreen(peerId: "123"),
            ),
          );
        },
      ),
    );
  }
}
