import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MechanicProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MechanicProfileScreenState();
  }
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  var _kGooglePlex;
  Completer<GoogleMapController> _controller = Completer();
  LatLng dest_location = LatLng(10.1964, 76.3879);
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  // Position currentPosition;
  // var geoLocator = Geolocator();
  // var locationOptions = LocationOptions(
  //     accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  // void getCurrentPosition() async {
  //   currentPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  // }

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(10.1964, 76.3879),
      zoom: 14,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontFamily: '', fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 16),
                    child: Image.network(
                      'https://picsum.photos/200',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: '',
                              fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                        ),
                        Text(
                          '4.8 Rating',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: '',
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      '1.2 KM',
                      style: TextStyle(
                          color: Colors.black, fontFamily: '', fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 170,
                margin: EdgeInsets.all(10),
                child: GoogleMap(
                  //zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  polylines: Set<Polyline>.of(polylines.values),
                  markers: Set<Marker>.of(markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    ///controller.setMapStyle(Utils.mapStyles);
                    _controller.complete(controller);
                    mapController = controller;
                    _getPolyline();
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Address',
                  style: TextStyle(
                      color: Colors.black, fontFamily: '', fontSize: 16),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Address Address Address ',
                  style: TextStyle(
                      color: Colors.black, fontFamily: '', fontSize: 16),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  '+91 123455677',
                  style: TextStyle(
                      color: Colors.black, fontFamily: '', fontSize: 16),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                      color: Colors.black, fontFamily: '', fontSize: 16),
                ),
              ),
              ListView.builder(
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return _reviewsListItem();
                  }),
              Container(
                margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Amount Details',
                  style: TextStyle(
                      color: Colors.black, fontFamily: '', fontSize: 16),
                ),
              ),
              ListView.builder(
                  itemCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return _serviceListItem();
                  }),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Amount',
                        style: TextStyle(
                            color: Colors.black, fontFamily: '', fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$ 350',
                        style: TextStyle(
                            color: Colors.black, fontFamily: '', fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustColors.blue),
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: '',
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustColors.blue),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: '',
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _reviewsListItem() {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10, right: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: CustColors.blue),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 16),
            child: Image.network(
              'https://picsum.photos/200',
              width: 60,
              height: 60,
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fast Service',
                    style: TextStyle(
                        color: Colors.white, fontFamily: '', fontSize: 16),
                  ),
                  Text(
                    'Fast ServiceFast ServiceFast ServiceFast ServiceFast ServiceFast ServiceFast Service',
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white, fontFamily: '', fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceListItem() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fast Service',
            style: TextStyle(color: Colors.black, fontFamily: '', fontSize: 16),
          ),
          Text(
            '\$ 200',
            style: TextStyle(color: Colors.black, fontFamily: '', fontSize: 16),
          ),
        ],
      ),
    );
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    /// add origin marker origin marker
    _addMarker(
      LatLng(10.1964, 76.3879),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(dest_location.latitude, dest_location.longitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDaoUiBbmno0IX3xxz7xjarbEX1GCr7Wuw",
      PointLatLng(10.184909, 76.375305),
      PointLatLng(dest_location.latitude, dest_location.longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
