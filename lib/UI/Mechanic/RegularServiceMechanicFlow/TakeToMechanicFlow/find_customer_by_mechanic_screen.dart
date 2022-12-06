import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_fix/Constants/shared_pref_keys.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Constants/cust_colors.dart';
import '../../../../../../Constants/styles.dart';
import 'dart:ui' as ui;


class FindCustomerByMechanicScreen extends StatefulWidget {

  final String bookingId;
  final String latitude;
  final String longitude;

  FindCustomerByMechanicScreen({
    required this.bookingId,
    required this.latitude,
    required this.longitude,

  });

  @override
  State<StatefulWidget> createState() {
    return _FindCustomerByMechanicScreen();
  }
}

class _FindCustomerByMechanicScreen extends State<FindCustomerByMechanicScreen> {

  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  double distanceInMeters = 0.0;
  String googleAPiKey = "AIzaSyA1s82Y0AiWYbzXwfppyvKLNzFL-u7mArg";
  String? _mapStyle;
  Set<Marker> markers = Set(); //markers for google map
  BitmapDescriptor? customerIcon;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
  double speedOfMechanic = 0.0;

  static const LatLng _center = const LatLng(10.0159, 76.3419);
  List<LatLng> latlng = [];
  String location ='';
  String Address = '';
  String authToken="", bookingId = "", carName = "", customerAddress = "",
      plateNumber = "", vehicleColor = "";

  bool isArrived = false; bool isLoading = true;
  String userid="", myProfileUrl = "", mechanicProfileUrl = "",
      mechanicAddress = "", customerId = "", mechanicId = "", mechanicName = "", callPhoneNumber = "";

  String customerCurrentLat = "", customerCurrentLng = "", firebaseIsArrived = "-1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapStyling();
    mechanicMarker(LatLng(
        double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
    getGoogleMapCameraPosition(LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
    getSharedPrefData();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
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
        position: LatLng(
          double.parse(customerCurrentLat),
          double.parse(customerCurrentLng)
        ), //position of marker
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

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData FindYourCustomerScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userid=shdPre.getString(SharedPrefKeys.userID).toString();
      bookingId = widget.bookingId;

      print('userFamilyId FindYourCustomerScreen '+authToken.toString());
      print('bookingId FindYourCustomerScreen '+bookingId.toString());
      _firestore.collection("Regular-TakeVehicle").doc(widget.bookingId).snapshots().listen((event) {
        carName = event.get('vehicleName');
        customerAddress = event.get('customerAddress');
        plateNumber =  event.get('vehiclePlateNumber');
        vehicleColor =  event.get('vehicleColor');

        myProfileUrl = event.get('customerProfileUrl');
        mechanicProfileUrl = event.get('mechanicProfileUrl');
        mechanicAddress = event.get('mechanicAddress');
        customerId = event.get('customerId');
        mechanicId = event.get('mechanicId');
        mechanicName = event.get('mechanicName');
        callPhoneNumber = event.get('mechanicPhone');
        customerCurrentLat = event.get('latitude');
        customerCurrentLng = event.get('longitude');
        firebaseIsArrived = event.get('isArrived');
      });
      Timer.periodic(Duration(seconds: 5), (Timer t) {
        LatLng latLng=LatLng(double.parse(customerCurrentLat.toString()), double.parse(customerCurrentLng.toString()));
        customerMarker(latLng);
      });
      
      if(firebaseIsArrived.toString() == "0"){
        Navigator.pop(context);
      }
      
    });
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
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }

  void updateToCloudFirestoreDB() {
    _firestore
        .collection("Regular-TakeVehicle")
        .doc('${widget.bookingId}')
        .update({
      'isArrived': "0",
      'isArrivedTime': "${DateFormat("hh:mm a").format(DateTime.now())}",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading == true
            ?
        Container(
            width: size.width,
            height: size.height,
            child: Center(child: CircularProgressIndicator(color: CustColors.light_navy)))
            :
        Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [

              //_googleMap != null ? _googleMap! : CircularProgressIndicator(),

              GoogleMap( //Map widget from google_maps_flutter package
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
                                        "Plate No : " + plateNumber,
                                        style: Styles.SelectLanguageWalkThroughStyle,
                                      ),
                                      Text(
                                        //"Service Id :Vien232",
                                        "Vehicle Color : " + vehicleColor,
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
                                              mechanicAddress,
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
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  int.parse((distanceInMeters).toString().split('.').first) <= 500
                                                      ? "${(distanceInMeters).toStringAsFixed(2)} m"
                                                      : "${(distanceInMeters/1000).toStringAsFixed(2)} km",
                                                  style: Styles.waitingTextBlack17,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  "Away",
                                                  style: Styles.awayTextBlack,
                                                ),
                                              ],
                                            ),
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
                                          "Find your mechanic",
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
    );
  }

  void _callPhoneNumber(String phoneNumber) async {
    var url = 'tel://$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error Occurred';
    }
  }

  static void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  }


  @override
  void dispose() {
    super.dispose();
  }

}
