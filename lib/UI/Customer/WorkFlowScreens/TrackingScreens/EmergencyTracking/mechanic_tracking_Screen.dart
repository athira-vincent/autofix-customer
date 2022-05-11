import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_work_progress_screen.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;


class MechanicTrackingScreen extends StatefulWidget {

  MechanicTrackingScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicTrackingScreenState();
  }
}

class _MechanicTrackingScreenState extends State<MechanicTrackingScreen> {



  List<LatLng> polylineCoordinates = [];


  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyA1s82Y0AiWYbzXwfppyvKLNzFL-u7mArg";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(37.778259000, -122.391386000);
  LatLng endLocation = LatLng(37.778259000, -122.390942000);

  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";

  String CurrentLatitude ="37.778259000";
  String CurrentLongitude ="-122.391386000";
  String location ='Null, Press Button';

  String? _mapStyle;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rootBundle.loadString('assets/map_style/map_style.json').then((string) {
      _mapStyle = string;
    });



    Timer.periodic(Duration(seconds: 15), (Timer t) {
          _getCurrentCustomerLocation();
          getDirections();

          print('getDirections 00000 + ${endLocation.latitude}     ++ ${startLocation.latitude}' );


          print('>>>>>>>>>>>>>>>> Timer');

    });




  }

  Future<void> _getCurrentCustomerLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {

      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();

      endLocation = LatLng(position.latitude, position.longitude);
    });
    print(location);
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
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }





  void changeScreen(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  MechanicWorkProgressScreen(workStatus: "1",)));
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

                GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 9, //initial zoom level
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
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20,20,20,50),
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
                ),

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
