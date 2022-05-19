import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_diagnose_test_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:auto_fix/Constants/cust_colors.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../Constants/cust_colors.dart';
import '../../../../../../Constants/styles.dart';
import 'dart:ui' as ui;



class FindYourCustomerScreen extends StatefulWidget {

  final String latitude;
  final String longitude;

  FindYourCustomerScreen({
    required this.latitude,required this.longitude,

  });

  @override
  State<StatefulWidget> createState() {
    return _FindYourCustomerScreenState();
  }
}

class _FindYourCustomerScreenState extends State<FindYourCustomerScreen> {

  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  bool _isLoadingPage = true;

  String googleAPiKey = "AIzaSyA1s82Y0AiWYbzXwfppyvKLNzFL-u7mArg";
  String? _mapStyle;
  Set<Marker> markers = Set(); //markers for google map
  BitmapDescriptor? customerIcon;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Widget? _googleMap;
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  LatLng startLocation = LatLng(10.0159, 76.3419);
  LatLng endLocation = LatLng(10.0443, 10.0443);
  late BitmapDescriptor mechanicIcon;
  CameraPosition? _kGooglePlex = CameraPosition(
    target: LatLng(37.778259000,
      -122.391386000,),
    zoom: 25,
  );
  double totalDistance = 0.0;
  String? _placeDistance;

  double speedOfMechanic = 0.0;

  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc = MechanicOrderStatusUpdateBloc();

  double _setValue(double value) {
    return value * per + value;
  }


  GoogleMapController? _controller ;
  static const LatLng _center = const LatLng(10.0159, 76.3419);
  //Map<MarkerId, Marker> markers = {};
  final Set<Polyline>_polyline={};
  LatLng _lastMapPosition = _center;
  List<LatLng> latlng = [];

  //String CurrentLatitude ="10.506402";
  //String CurrentLongitude ="76.244164";
  String location ='Null, Press Button';
  String Address = 'search';
  String authToken="", bookingId = "", carName = "", customerAddress = "", plateNumber = "";
  bool isArrived = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mapStyling();
    customerMarker (LatLng(double.parse(
        widget.latitude.toString()), double.parse(widget.longitude.toString())));
    getGoogleMapCameraPosition(LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
    _getCurrentLocation();

    Timer.periodic(Duration(seconds: 20), (Timer t) {
      print('Timer ++++++');
      _getCurrentLocation();
    });

    getSharedPrefData();
    _listenServiceListResponse();
    Timer(const Duration(seconds: 15), () {
      setState(() {
        isArrived = true;
      });
    });
  }

  mapStyling() {
    print('latlong from another screen ${widget.latitude} ${widget.longitude}');

    rootBundle.loadString('assets/map_style/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  customerMarker(LatLng latLng) {
    getBytesFromAsset('assets/image/mechanicTracking/carMapIcon.png', 150).then((onValue) {
      customerIcon =BitmapDescriptor.fromBytes(onValue);
      markers.add(Marker( //add start location marker
        markerId: MarkerId('customerMarkerId'),
        position: latLng, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'customer location',
          snippet: 'customer location',
        ),
        icon: customerIcon!, //Icon for Marker
      ));
    });

  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  getGoogleMapCameraPosition(LatLng latLng) {
    _kGooglePlex = CameraPosition(
      target:latLng,
      zoom: 12,
    );
  }

  _getCurrentLocation()  {
    print('Timer ++++++   00');
    _getGeoLocationPosition();
  }

  _listenServiceListResponse() {

    _mechanicOrderStatusUpdateBloc.MechanicOrderStatusUpdateResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoadingPage = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          _isLoadingPage = false;

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MechanicStartServiceScreen()));

          /*if(widget.serviceModel == "0"){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicStartServiceScreen(serviceModel: "",)));
          }
          else if(widget.serviceModel == "1"){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicDiagnoseTestScreen(serviceModel: "",)));
          }
          else if(widget.serviceModel == "2" || widget.serviceModel == "3"){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicDiagnoseTestScreen(serviceModel: "",)));
          }*/
        });
      }
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('userFamilyId'+authToken.toString());
      print('userFamilyId'+bookingId.toString());
      _firestore.collection("ResolMech").doc('$bookingId').snapshots().listen((event) {

        carName = event.get('carName');
        customerAddress = event.get('customerAddress');
        plateNumber =  event.get('carPlateNumber');

       // mechanicName = event.get('mechanicName');
        print('_firestoreData>>>>>>>>> ' + event.get('serviceName'));

      });
    });
  }

  _getGeoLocationPosition() async {
    print('_getGeoLocationPosition ++++++   01');
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print('serviceEnabled ++++++   03');
    if (!serviceEnabled) {
      print('serviceEnabled ++++++   04');

      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print('Timer ++++++   05');

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Timer ++++++   06');

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

    Geolocator.getPositionStream(locationSettings:LocationSettings(accuracy: LocationAccuracy.lowest, distanceFilter: 6)).listen((event) {

      speedOfMechanic= event.speed;
      print('speedOfMechanic ++++++   000==== $speedOfMechanic');

      var value1 = event;

      print('getPositionStream ++++++   02');

      setState(() {
        _firestore
            .collection("ResolMech")
            .doc('${bookingId}')
            .update({
            'latitude': value1.latitude.toString(),
            'longitude': value1.longitude.toString()
        })
            .then((value) => print("Location Added"))
            .catchError((error) =>
            print("Failed to add Location: $error"));
      });
      print("value1 $value1");
      LatLng latLng=LatLng(double.parse(value1.latitude.toString()), double.parse(value1.longitude.toString()));
      print("latLng 001 ${latLng.latitude}");
      mechanicMarker (latLng);

    });
    //return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  mechanicMarker(LatLng latLng) {
    print('Current latitude ${latLng.latitude}  Current longitude ${latLng.longitude}');
    getBytesFromAsset('assets/image/mechanicTracking/mechanicMapIcon.png', 150).then((onValue) {
      print("getBytesFromAsset 001");
      mechanicIcon =BitmapDescriptor.fromBytes(onValue);
      markers.add(Marker( //add start location marker
        markerId: MarkerId('mechanicMarkerId'),
        position: latLng, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'mechanic location',
          snippet: 'mechanic location',
        ),
        icon: mechanicIcon, //Icon for Marker
      ));
      setState(() {
        print("markers ${markers.length}");
        setPolyline(LatLng(double.parse(widget.latitude.toString()), double.parse(widget.longitude.toString())), latLng,);
      });

    });

  }

  setPolyline(LatLng startlatLng, LatLng endlatLng,) async {
    List<LatLng> polylineCoordinates = [];
    polylinePoints = PolylinePoints();

    if (polylines.isNotEmpty)
      polylines.clear();
    if (polylineCoordinates.isNotEmpty)
      polylineCoordinates.clear();
    print("polylineCoordinates ${polylines.length}");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startlatLng.latitude, startlatLng.longitude),
      PointLatLng(endlatLng.latitude, endlatLng.longitude),
      travelMode: TravelMode.driving,
    );
    // log('getDirections + ${result?.points}' );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('PolylineResult + ${result.errorMessage}' );
    }
    addPolyLine(polylineCoordinates);

    distanceCalculation(polylineCoordinates);

  }

  distanceCalculation(List<LatLng> polylineCoordinates) {
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

    setState(() {
      _placeDistance = totalDistance.toStringAsFixed(2);
      print('DISTANCE ===== : $_placeDistance km');
    });
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getDirections() async {

    List<LatLng> polylineCoordinates = [];

    polylinePoints = PolylinePoints();
    if (markers.isNotEmpty) markers.clear();
    if (polylines.isNotEmpty)
      polylines.clear();
    if (polylineCoordinates.isNotEmpty)
      polylineCoordinates.clear();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );
    print('getDirections 01 + ${result.points}' );
    print('getDirections 00 + ${endLocation.latitude}     ++ ${startLocation.latitude}' );


    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('getDirections + ${result.errorMessage}' );
    }
    addPolyLine(polylineCoordinates);
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
    _googleMap = _googleMapIntegrate();
  }

  Widget _googleMapIntegrate() {
    return GoogleMap( //Map widget from google_maps_flutter package
      zoomGesturesEnabled: true, //enable Zoom in, out on map
      initialCameraPosition: _kGooglePlex!,
      markers: markers, //markers to show on map
      polylines: Set<Polyline>.of(polylines.values), //polylines
      mapType: MapType.normal, //map type
      onMapCreated: (controller) { //method called when map is created
        setState(() {
          controller.setMapStyle(_mapStyle);
          mapController = controller;
        });
      },
    );
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }

  void updateToCloudFirestoreDB() {

    _firestore
        .collection("ResolMech")
        .doc('${bookingId}')
        .update({
        'mechanicArrivalState': "1",
        "customerFromPage" : "MechanicWorkProgressScreen(workStatus: '1')",
        "mechanicFromPage" : "MechanicStartServiceScreen",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }
  /*void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("${bookingId}");
    reference.snapshots().listen((querySnapshot) {
      setState(() {
        carName = querySnapshot.get("carName");

        print('carName  ++++ $carName');

      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<LocaleProvider>(context,listen: false);
    //provider.setPayload(notificationPayloadMdl);
    //print("provider >>>>>>>>>>> " + provider.toString());
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                Expanded(
                  child: _googleMap != null ? _googleMap! : CircularProgressIndicator(),
                  /*child: GoogleMap( //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition( //innital position in map
                      target: startLocation, //initial position
                      zoom: 15, //initial zoom level
                    ),
                    markers: markers, //markers to show on map
                    polylines: Set<Polyline>.of(polylines.values), //polylines
                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      setState(() {
                        controller.setMapStyle(_mapStyle);

                        mapController = controller;
                      });
                    },
                  ),*/
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,10,20,10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,5,5,10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          carName,
                                          //"Toyota Corolla Silver",
                                          style: Styles.appBarTextBlack17,
                                        ),
                                        Text(
                                          //"Service Id :Vien232",
                                          "Service Id : " + plateNumber,
                                          style: Styles.SelectLanguageWalkThroughStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [

                                  Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        child: SvgPicture.asset(
                                          'assets/image/mechanicProfileView/directionMechnanicTracking.svg',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: FDottedLine(
                                          color: CustColors.blue,
                                          height: 60.0,
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        child: SvgPicture.asset(
                                          'assets/image/mechanicProfileView/clockMechnanicTracking.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          height: 60,
                                          width: 200,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Address",
                                                style: Styles.waitingTextBlack17,
                                              ),
                                              Text(
                                                customerAddress,
                                                //"Elenjikkal house,Residency Empyreal Garden Anchery P.o Thrissur-680006",
                                                style: Styles.awayTextBlack,
                                                textAlign: TextAlign.start,
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              height: 40,
                                              width: 150,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "3 mintues",
                                                    style: Styles.waitingTextBlack17,
                                                  ),
                                                  Text(
                                                    "Arrival time.",
                                                    style: Styles.awayTextBlack,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,

                                            child: MaterialButton(
                                              onPressed: () {

                                                _isLoadingPage = false;
                                                updateToCloudFirestoreDB();
                                                _mechanicOrderStatusUpdateBloc.postMechanicOrderStatusUpdateRequest(
                                                    authToken, bookingId, "3");

                                              },
                                              child: Container(
                                                height: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Arrived',
                                                      textAlign: TextAlign.center,
                                                      style: Styles.textButtonLabelSubTitle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              color: isArrived ? CustColors.light_navy :  CustColors.greyText,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      _setValue(10))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: CustColors.blue,
                            borderRadius: BorderRadius.only(
                                bottomRight:   Radius.circular(20),
                                bottomLeft:  Radius.circular(20)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.phone, color: Colors.white),
                                      Text(
                                        "Call",
                                        style: Styles.popUPTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child:  Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.chat, color: Colors.white),
                                      Text(
                                        "Chat",
                                        style: Styles.popUPTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child:  Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.smartphone_sharp, color: Colors.white),
                                      Text(
                                        "Call via ResolMech",
                                        style: Styles.popUPTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,20,20,50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,10,10,10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    /*Container(
                                      child: Icon(Icons.arrow_back, color: Colors.black),
                                    ),*/
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0,15,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Find your customer",
                                            textAlign: TextAlign.start,
                                            style: Styles.waitingTextBlack17,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showProductTourDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(left: 20, right: 20),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: const EdgeInsets.all(20),
                content: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Wait few minutes !",
                            style: Styles.waitingTextBlack17,
                          ),
                          Text(
                            "Wait for the response from George Dola!",
                            style: Styles.awayTextBlack,
                          ),
                          Container(
                              height: 150,
                              child: SvgPicture.asset(
                                'assets/image/mechanicProfileView/waitForMechanic.svg',
                                height: 200,
                                fit: BoxFit.cover,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          });
        });


  }


}
