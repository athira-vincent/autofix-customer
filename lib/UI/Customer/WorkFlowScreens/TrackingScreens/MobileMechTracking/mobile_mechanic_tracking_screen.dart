import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_work_progress_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MobileMechTrackingScreen extends StatefulWidget {


  MobileMechTrackingScreen();

  @override
  State<StatefulWidget> createState() {
    return _MobileMechTrackingScreenState();
  }
}

class _MobileMechTrackingScreenState extends State<MobileMechTrackingScreen> {

  String authToken = "";

  MapType _currentMapType = MapType.terrain;
  GoogleMapController? _controller ;
  static const LatLng _center = const LatLng(10.0265, 76.3086);
  String? _mapStyle;
  Map<MarkerId, Marker> markers = {};
  final Set<Polyline>_polyline={};
  LatLng _lastMapPosition = _center;
  List<LatLng> latlng = [];
  LatLng _new = LatLng(10.506402, 76.244164);
  LatLng _news = LatLng(10.0265, 76.3086);

  void _onMapCreated(GoogleMapController controller) {

    setState(() {
      _controller = controller;
      _controller!.setMapStyle(_mapStyle).whenComplete(() {
        print(">>>>>>>>>>>>>>>>>+++++++++++++++++  =true");
      });
      //_controller.complete(controller);
      final marker = Marker(
        markerId: MarkerId('place_name'),
        position: LatLng(10.506402, 76.244164),
        icon:  BitmapDescriptor.defaultMarker,
      );
      markers[MarkerId('place_name')] = marker;
    });
    latlng.add(_new);
    latlng.add(_news);
    _polyline.add(Polyline(
      polylineId: PolylineId(_lastMapPosition.toString()),
      visible: true,
      points: latlng,
      color: CustColors.cherry,
    ));
  }

  String CurrentLatitude ="10.506402";
  String CurrentLongitude ="76.244164";
  String location ='Null, Press Button';
  String Address = 'search';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentCustomerLocation();

    rootBundle.loadString('assets/map_style/map_style.json').then((string) {
      _mapStyle = string;
    });
    /*DefaultAssetBundle.of(context).loadString('assets/map_style/map_style.json').then((string) {
      this._mapStyle = string;
    }).catchError((error) {
      log(error.toString());
    });*/

    Timer(const Duration(seconds: 5), () {
      changeScreen();
    });

  }

  void changeScreen(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MechanicWorkProgressScreen(workStatus: "5",)));
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

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }


  @override
  Widget build(BuildContext context) {

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
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 10.0,
                      ),
                      mapType: _currentMapType,
                      markers: markers.values.toSet(),
                      polylines:_polyline,
                    ),

                    CurvedBottomSheetContainer(
                        percentage: 0.55,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: size.width * 6 / 100,
                                      top: size.height * 2.5 / 100,
                                      //bottom: size.height * 5.5 / 100,
                                    ),
                                    child: Text("Wait for 3 Minutes mechanic on the way!",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Samsung_SharpSans_Medium',
                                          letterSpacing: .4,
                                          wordSpacing: .3,
                                          height: 1.7
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 6 / 100,
                                    right: size.width * 6 / 100,
                                    top: size.height * .7 / 100,
                                    //bottom: size.height * 5.5 / 100,
                                  ),
                                  decoration: BoxDecoration(
                                      color: CustColors.white_03,
                                      //color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(15),
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
                                        padding: const EdgeInsets.fromLTRB(20,12,20,12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 18,
                                                  width: 18,
                                                  child: SvgPicture.asset(
                                                    'assets/image/mechanicProfileView/directionMechnanicTracking.svg',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 12,right: 5,top: 5,bottom: 5),
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
                                                height: 32.0,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 18,
                                                  width: 18,
                                                  child: SvgPicture.asset(
                                                    'assets/image/mechanicProfileView/clockMechnanicTracking.svg',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 12,right: 5,top: 5,bottom: 5),
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
                                          color: CustColors.light_navy,
                                          borderRadius: BorderRadius.only(
                                              bottomRight:   Radius.circular(15),
                                              bottomLeft:  Radius.circular(15)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    //Icon(Icons.phone, color: Colors.white),
                                                    Container(
                                                      //color: Colors.purpleAccent,
                                                      //height: size.height * 5 / 100,
                                                      width: size.width * 7.3 / 100,
                                                      child: Image.asset(
                                                        'assets/image/ic_call_blue_white.png',
                                                      ),
                                                    ),
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
                                                    Container(
                                                      //color: Colors.purpleAccent,
                                                      //height: size.height * 5 / 100,
                                                      width: size.width * 7.3 / 100,
                                                      child: Image.asset(
                                                        'assets/image/ic_chat_blue_white.png',
                                                      ),
                                                    ),
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
                                                    Container(
                                                      //color: Colors.purpleAccent,
                                                      //height: size.height * 5 / 100,
                                                      width: size.width * 7.3 / 100,
                                                      child: Image.asset(
                                                        'assets/image/ic_in_app_blue_white.png',
                                                      ),
                                                    ),
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
                                Container(
                                  margin: EdgeInsets.only(
                                      top: size.height * .3 / 100
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/img_waiting_mech_bg.svg',
                                    height: size.height * 18 / 100,
                                    width: size.width * 32 / 100,fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ]
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
                            borderRadius: BorderRadius.circular(10),
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
                  ]
              ),
            ),
          )
        ),
    );
  }



}