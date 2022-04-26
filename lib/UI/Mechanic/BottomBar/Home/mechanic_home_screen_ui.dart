import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicHomeUIScreen extends StatefulWidget {

  MechanicHomeUIScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeUIScreenState();
  }
}

class _MechanicHomeUIScreenState extends State<MechanicHomeUIScreen> {


  late final FirebaseMessaging  _messaging = FirebaseMessaging.instance;
  String authToken="";
  String location ='Null, Press Button';
  String CurrentLatitude ="10.506402";
  String CurrentLongitude ="76.244164";
  String Address = 'search';

  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    callOnFcmApiSendPushNotifications(1);

    _getCurrentCustomerLocation();
    _listenApiResponse();

  }


  void registerNotification() async {
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }


  Future<void> callOnFcmApiSendPushNotifications(int length) async {

    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("Instance ID: +++++++++ +++++ +++++ minnu " + token.toString());
    });


    /* final postUrl = 'https://fcm.googleapis.com/fcm/send';
    // print('userToken>>>${appData.fcmToken}'); //alp dec 28

    final data = {
      'notification': {
        'body': 'You have $length new order',
        'title': 'New Orders',
        'sound': 'alarmw.wav',
      },
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
        'screen': 'screenA',
        'message': 'ACTION'
      },
      'apns': {
        'headers': {'apns-priority': '5', 'apns-push-type': 'background'},
        'payload': {
          'aps': {'content-available': 1, 'sound': 'alarmw.wav'}
        }
      },
      'to': 'eCBxvR1ZSNWWUqyqlQPtgO:APA91bFDwk8N-bxpVLVrhylF_gG4ota7JnHJKQErONodQbE9ppf8t0LWd7sYNt6RgRTysPTlW2GI2yIbRg76tjJ1MSgmhaeLIHr0dJuFbDEt42lNLGjGwz6glPHpuq6DjfmRoehcWk9L',
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
      'key=$serverToken'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);

      if (response.statusCode == 200) {
        print('notification sending success');
      } else {
        print('notification sending failed');
      }
    } catch (e) {
      print('exception $e');
    }*/
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
      //_homeCustomerBloc.postEmergencyServiceListRequest("$authToken", "1");

    });
  }

  _listenApiResponse() {

  }


  Future<void> _getCurrentCustomerLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {
      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();
    });
    print(location);
    GetAddressFromLatLong(position);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.yellow,
            child: Center(
              child: Text(
                  "Mechanic Home UI Screen"
              ),
            ),
          ),
        ),
      ),
    );
  }

}