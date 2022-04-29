import 'dart:async';
import 'dart:developer';

import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_fix/Constants/cust_colors.dart';

import 'package:flutter/services.dart' show rootBundle;

import '../../../../../../Constants/cust_colors.dart';
import '../../../../../../Constants/styles.dart';



class PickUpCustomerLocationScreen extends StatefulWidget {

  final String serviceModel;

  PickUpCustomerLocationScreen({required this.serviceModel});

  @override
  State<StatefulWidget> createState() {
    return _PickUpCustomerLocationScreenState();
  }
}

class _PickUpCustomerLocationScreenState extends State<PickUpCustomerLocationScreen> {


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  double _setValue(double value) {
    return value * per + value;
  }


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
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 10.0,
                    ),
                    mapType: _currentMapType,
                    markers: markers.values.toSet(),
                    polylines:_polyline,
                  ),
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
                                          "Toyota Corolla Silver",
                                          style: Styles.appBarTextBlack17,
                                        ),
                                        Text(
                                          "Service Id :Vien232",
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
                                        height: size.height * 5 / 100,
                                        width: size.width * 7 / 100,
                                        child: Image.asset(
                                          'assets/image/ic_profile_blue.png',
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
                                                "Elenjikkal house,Residency Empyreal Garden Anchery P.o Thrissur-680006",
                                                style: Styles.awayTextBlack,
                                                textAlign: TextAlign.start,
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Container(
                                                height: 35,
                                                width: 140,
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
                                            SizedBox(
                                              width: size.width * 15 / 100,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: MaterialButton(
                                                onPressed: () {

                                                },
                                                child: Container(
                                                  height: 30,
                                                  child: Center(
                                                    child: Text(
                                                      'Arrived',
                                                      textAlign: TextAlign.center,
                                                      style: Styles.textButtonLabelSubTitle,
                                                    ),
                                                  ),
                                                ),
                                                color: CustColors.cloudy_blue_02,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        _setValue(10))),
                                              ),
                                            ),
                                          ],
                                        ),
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
                            color: CustColors.light_navy,
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
                                      Container(
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
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,20,20,50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
