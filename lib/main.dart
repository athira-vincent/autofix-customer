// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/LocalNotifications.dart';
import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/Provider/chat_provider.dart';
import 'package:auto_fix/Provider/jobRequestNotifyProvider/job_request_notify_provider.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Common/LocalizationDelegates/ha_intl_ios.dart';
import 'package:auto_fix/UI/Common/LocalizationDelegates/ha_intl_material.dart';
import 'package:auto_fix/UI/Common/LocalizationDelegates/ig_intl_ios.dart';
import 'package:auto_fix/UI/Common/LocalizationDelegates/ig_intl_material.dart';
import 'package:auto_fix/UI/Common/LocalizationDelegates/yo_intl_ios.dart';
import 'package:auto_fix/UI/Common/LocalizationDelegates/yo_intl_material.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/CustomerNotifications/cust_notification_list.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyWallet/customer_wallet_bloc.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MechanicNotifications/mech_notification_list.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cust_rating_bloc/cust_rating_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_oder_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/placeallorderbloc/place_oder_all_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';

import 'package:auto_fix/UI/WelcomeScreens/Splash/splash_screen.dart';
import 'package:auto_fix/UI/chat/chat.dart';
import 'package:auto_fix/notification_handler_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Provider/locale_provider.dart';
import 'package:provider/provider.dart';

import 'UI/SpareParts/MyCart/new_checkout_bloc/new_checkout_bloc.dart';
import 'l10n/l10n.dart';

String langCode;
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
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    langCode = prefs.getString(SharedPrefKeys.userLanguageCode) ?? 'en';

    runApp(MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

final GlobalKey<NavigatorState> notificationNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp>  with WidgetsBindingObserver{

  Locale _locale = Locale.fromSubtags(languageCode: langCode ?? 'en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    bool haveActiveServiceRequest = false;
    print("fjfghfjfhjhkhklj 0001112222 ");
    Duration time;
    switch(state) {
      case AppLifecycleState.resumed:
        print("fjfghfjfhjhkhklj 000111 ");

        haveActiveServiceRequest = _shdPre.getBool(SharedPrefKeys.haveActiveServiceRequest);

        print("fjfghfjfhjhkhklj 000111 a $haveActiveServiceRequest");
        if(haveActiveServiceRequest == true){
          print("fjfghfjfhjhkhklj 000111 b");
          String haveActiveServiceRequestData = _shdPre.getString(SharedPrefKeys.activeServiceRequestData);
          Map<String,dynamic> userMap = jsonDecode(haveActiveServiceRequestData) as Map<String, dynamic>;
          print("fjfghfjfhjhkhklj 000111 c ${userMap}");
          NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(userMap);

          Repository().getCurrentWorldTime("Kolkata").then((value01) => {

            time = DateTime.fromMillisecondsSinceEpoch( int.parse(notificationPayloadMdl.customerCurrentTime)).
            difference(DateTime.fromMillisecondsSinceEpoch(int.parse(value01.datetime.millisecondsSinceEpoch.toString()))),
            print( "time difference >>> ${time.inSeconds}"),
            print( "time difference >>> ${time.inSeconds}"),
            if(time.inSeconds > -30){
              print("fjfghfjfhjhkhklj 000111 d ${notificationPayloadMdl.id}"),
              print("fjfghfjfhjhkhklj 000111 e ${notificationPayloadMdl.customerCurrentTime}"),

              notificationNavigatorKey.currentState.pushNamed('/IncomingJobRequestScreen',arguments: notificationPayloadMdl)
            }else{
              Fluttertoast.showToast(msg: "Time Expired"),
              print("Time Expired"),
            }
          });
        }

      // Handle this case
        //work here
        break;
      case AppLifecycleState.inactive:
      // Handle this case
        print("fjfghfjfhjhkhklj 000222 ");
        break;
      case AppLifecycleState.paused:
        print("fjfghfjfhjhkhklj 000333 ");
      // Handle this case
        break;

      case AppLifecycleState.detached:
        print("fjfghfjfhjhkhklj 000444 ");
        break;
    }
  }

@override
  void dispose() {
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
  }
  @override
  void initState() {
    super.initState();
    requestPermissions();
    setupFcm();
    WidgetsBinding.instance.addObserver(this);
    //_locale = Provider.of<LocaleProvider>(context,).locale??L10n.all.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
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
           print(">>>>>> lang code ${_locale}");
          // locale = provider.locale ?? const Locale('en');
          print("kdfjkfhfkll ${_locale}");
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
              BlocProvider<PlaceOrderAllBloc>(
                create: (context) => PlaceOrderAllBloc(),
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
              BlocProvider<CustomerWalletBloc>(
                create: (context) => CustomerWalletBloc(),
              ),

              BlocProvider<NewCheckoutBloc>(
                create: (context) => NewCheckoutBloc(),
              ),
            ],
            child:
                 MaterialApp(
                  navigatorKey: notificationNavigatorKey,
                  routes: {
                    '/custNotificationList': (_) => CustNotificationList(),
                    '/mechNotificationList': (_) => MechanicNotificationList()
                  },
                  onGenerateRoute: (settings){
                    if (settings.name == '/IncomingJobRequestScreen') {
                      final value = settings.arguments ; // Retrieve the value.
                      return MaterialPageRoute(builder: (_) => IncomingJobRequestScreen(notificationPayloadMdl: value,)); // Pass it to BarPage.
                    }
                    return null;
                  },
                  debugShowCheckedModeBanner: false,
                  locale: _locale,
                  //L10n.all.elementAt(1),
                   localizationsDelegates: [
                     AppLocalizations.delegate,
                     GlobalMaterialLocalizations.delegate,
                     GlobalCupertinoLocalizations.delegate,
                     GlobalWidgetsLocalizations.delegate,
                     IgMaterialLocalizations.delegate,
                     IgCupertinoLocalizations.delegate,
                     YoMaterialLocalizations.delegate,
                     YoCupertinoLocalizations.delegate,
                     HaMaterialLocalizations.delegate,
                     HaCupertinoLocalizations.delegate
                   ],
                  supportedLocales: L10n.all,
                  title: 'ResolMech',
                  theme: ThemeData(
                    primaryColor: Colors.white,
                    primarySwatch: CustColors.materialBlue,
                  ),
                  home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }

  void requestPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

}
