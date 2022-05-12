import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_work_progress_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:location/location.dart' as loc;
class CustomerTracking1Screen extends StatefulWidget {

  final String latitude;
  final String longitude;
  final String bookingId;


  CustomerTracking1Screen({
    required this.latitude,
    required this.longitude,
    required this.bookingId,});

  @override
  State<StatefulWidget> createState() {
    return _CustomerTracking1ScreenState();
  }

}

class _CustomerTracking1ScreenState extends State<CustomerTracking1Screen> {

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
  LatLng startLocation = LatLng(37.778259000, -122.391386000);
  LatLng endLocation = LatLng(37.778259000, -122.390942000);
  late BitmapDescriptor mechanicIcon;
  CameraPosition? _kGooglePlex = CameraPosition(
    target: LatLng(37.778259000,
      -122.391386000,),
    zoom: 25,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    mapStyling();
    customerMarker (LatLng(double.parse(widget.latitude.toString()), double.parse(widget.longitude.toString())));
    getGoogleMapCameraPosition(LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
    _getCurrentLocation();
    //LocationService();
    Timer.periodic(Duration(seconds: 20), (Timer t) {
      print('Timer ++++++');
      _getCurrentLocation();
    });


  }

  LocationService() {
    var location = loc.Location();
    // Request permission to use location
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == loc.PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged.listen((locationData) {
          print("onLocationChanged 001 ");
          if (locationData != null) {

            _getCurrentLocation();
          }
        });
      }
    });
  }

  mapStyling() {
    print('latlong from another screen ${widget.latitude} ${widget.longitude}');

    rootBundle.loadString('assets/map_style/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  customerMarker(LatLng latLng) {
    getBytesFromAsset('assets/image/mechanicTracking/mechanicMapIcon.png', 150).then((onValue) {
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

  mechanicMarker(LatLng latLng) {
    print('Current latitude ${latLng.latitude}  Current longitude ${latLng.longitude}');
    getBytesFromAsset('assets/image/mechanicTracking/carMapIcon.png', 150).then((onValue) {
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

  }

  _getGeoLocationPosition() async {
    print('_getGeoLocationPosition ++++++   01');
    Position? value1;
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
      var value1 = event;

      print('getPositionStream ++++++   02');

      setState(() {
        _firestore
            .collection("ResolMech")
            .doc('${widget.bookingId}')
            .set({
          'latitude': value1.latitude.toString(),
          'longitude': value1.longitude.toString()
        })
            .then((value) => print("Location Added"))
            .catchError((error) =>
            print("Failed to add Location: $error"));
      });
      print("value1 $value1");
      LatLng latLng=LatLng(double.parse(value1!.latitude.toString()), double.parse(value1.longitude.toString()));
      print("latLng 001 ${latLng.latitude}");
      mechanicMarker (latLng);

    });
    //return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
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
    print('PolylineResult 01 + ${result.points}' );
    print('PolylineResult 00 + ${endLocation.latitude}     ++ ${startLocation.latitude}' );


    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('PolylineResult + ${result.errorMessage}' );
    }
    addPolyLine(polylineCoordinates);
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: customerIcon!, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: mechanicIcon, //Icon for Marker
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
    _googleMap=_googleMapIntegrate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _googleMap!=null?_googleMap!:CircularProgressIndicator(),
                // GoogleMap( //Map widget from google_maps_flutter package
                //   zoomGesturesEnabled: true, //enable Zoom in, out on map
                //   initialCameraPosition: _kGooglePlex!,
                //   markers: markers, //markers to show on map
                //   polylines: Set<Polyline>.of(polylines.values), //polylines
                //   mapType: MapType.normal, //map type
                //   onMapCreated: (controller) { //method called when map is created
                //     setState(() {
                //       controller.setMapStyle(_mapStyle);
                //
                //       mapController = controller;
                //     });
                //   },
                // ),

                /*Padding(
                  padding: const EdgeInsets.fromLTRB(20,20,20,100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20),
                        boxShadow: [new BoxShadow(
                          color: CustColors.roseText1,
                          blurRadius: 10.0,
                        ),]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,20,20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Departed",
                                          style: Styles.waitingTextBlack17,
                                        ),
                                        Text(
                                          "Mechanic Departed from his location.",
                                          style: Styles.awayTextBlack,
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: FDottedLine(
                                  color: CustColors.blue,
                                  height: 40.0,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                      'assets/image/mechanicProfileView/clockMechnanicTracking.svg',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                ),*/

                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,20,20,50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: CustColors.roseText1,
                          blurRadius: 10.0,
                        ),],
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
                                    Container(
                                      child: Icon(Icons.arrow_back, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0,15,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Mechanic on the way",
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


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  void changeScreen(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  MechanicWorkProgressScreen(workStatus: "1",)));
  }

}
