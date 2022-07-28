import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class ChangeLocationScreen extends StatefulWidget {

  final String latitude;
  final String longitude;

  ChangeLocationScreen({
    required this.latitude,required this.longitude,
  });

  @override
  State<StatefulWidget> createState() {
    return _ChangeLocationScreenState();
  }
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {

  GoogleMapController? mapController;
  TextEditingController _locationChangeController = new TextEditingController();

  String googleAPiKey = "AIzaSyA1s82Y0AiWYbzXwfppyvKLNzFL-u7mArg";
  String? _mapStyle;
  Set<Marker> markers = Set();
  BitmapDescriptor? customerIcon;
  /*CameraPosition? _kGooglePlex = CameraPosition(
    target: LatLng(37.778259000,
      -122.391386000,),
    zoom: 25,
  );*/

  CameraPosition? _kGooglePlex ;


  String waitingMechanic="1";
  late LatLng selectedLatLng ;

  String authToken = "";
  String locationAddress = "";
  String Address = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getSharedPrefData();
    locationAddress = "Location";
    selectedLatLng = LatLng(double.parse(widget.latitude.toString()),double.parse(widget.longitude.toString()));
    mapStyling();
    customerMarker (double.parse(widget.latitude.toString()),double.parse(widget.longitude.toString()));
    getGoogleMapCameraPosition(LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
    GetAddressFromLatLong(LatLng(double.parse(widget.latitude), double.parse(widget.longitude)));
  }

  mapStyling() {
    print('latlong from another screen ${widget.latitude} ${widget.longitude}');
    rootBundle.loadString('assets/map_style/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  customerMarker(double lat, double long) {
    LatLng latLng = LatLng(lat, long);
    getBytesFromAsset('assets/image/mechanicTracking/carMapIcon.png', 150).then((onValue) {
      customerIcon = BitmapDescriptor.fromBytes(onValue);
      markers.add(Marker( //add start location marker
        markerId: MarkerId('customerMarkerId'),
        position: latLng, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'vehicle location',
          //snippet: 'customer location',
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
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> GetAddressFromLatLong(LatLng position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
     Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      locationAddress = '${place.locality}';//${place.name},
    });
    print(" displayAddress >>>>>> " + locationAddress);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: _kGooglePlex!,
                  markers: markers, //markers to show on map
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      controller.setMapStyle(_mapStyle);
                      mapController = controller;
                    });
                  },
                  onLongPress: (result){
                    setState(() {
                      selectedLatLng = result;
                      print("Print Val >>> " + result.toString());
                      customerMarker(result.latitude, result.longitude);
                      ///----------------------- address change here
                      //locationAddress = result
                      mapController!.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: LatLng(
                                      result.latitude,
                                      result.longitude,),
                                zoom: 13)
                          )
                      );
                      GetAddressFromLatLong(result);

                      //getGoogleMapCameraPosition(LatLng(result.latitude, result.longitude));
                    });
                  },
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
                                          /*TextFormField(
                                            controller: _locationChangeController,
                                          ),*/
                                          Text(
                                            "${locationAddress}",
                                            textAlign: TextAlign.start,
                                            style: Styles.waitingTextBlack17,
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*TextFormField(
                                            controller: _locationChangeController,
                                          ),*/
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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //Navigator.of(context).pop();
              SharedPreferences shdPre = await SharedPreferences.getInstance();
              shdPre.setString(SharedPrefKeys.preferredLatitude, selectedLatLng.latitude.toString());
              shdPre.setString(SharedPrefKeys.preferredLongitude, selectedLatLng.longitude.toString());
              shdPre.setString(SharedPrefKeys.preferredAddress, Address);
              Navigator.pop(context,selectedLatLng);
            },
            backgroundColor: CustColors.light_navy,
            child: const Icon(Icons.done),
          ),
        ),
      ),
    );
  }
}
