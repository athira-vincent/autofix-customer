import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleToMechTrackingScreen extends StatefulWidget {
  VehicleToMechTrackingScreen();

  @override
  State<StatefulWidget> createState() {
    return _VehicleToMechTrackingScreenState();
  }
}

class _VehicleToMechTrackingScreenState extends State<VehicleToMechTrackingScreen> {
  String authToken = "";

  String? _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(12.988827, 77.472091);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  Map<PolylineId, Polyline> polylines = {};

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller){
                      print("$_mapStyle  >>>>>>>>>>>>>>>>>>>_mapStyle");

                      controller.setMapStyle(_mapStyle);
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    // mapType: _currentMapType,
                    markers: _markers,
                    onCameraMove: _onCameraMove,
                    polylines: Set<Polyline>.of(polylines.values),
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

                          Container(
                            margin: EdgeInsets.only(
                              left: size.width * 5 / 100,
                              top: size.height * 3 / 100,
                            ),
                            child: Text("Start your journey .. mechanic 18 Km near you",
                              style: Styles.waitingTextBlack17,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,15,20,20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      color: CustColors.pale_grey,
                                      padding: EdgeInsets.all(5.5),
                                      child: SvgPicture.asset(
                                        'assets/image/ic_services_blue.svg',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Services choose",
                                            style: Styles.waitingTextBlack17,
                                          ),
                                          Text(
                                            "Car spray",
                                           // "Car spray \nAC / Heating \nSteering",
                                            style: Styles.awayTextBlack,
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 3.5 / 100
                                  ),
                                  child: FDottedLine(
                                    color: CustColors.blue,
                                    height: 40.0,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      color: CustColors.pale_grey,
                                      padding: EdgeInsets.all(5.5),
                                      child: Image.asset(
                                        'assets/image/ic_location_blue.png',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 7
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mechanic address",
                                            style: Styles.waitingTextBlack17,
                                          ),
                                          Text(
                                            "Savannah estate, plot 176",
                                            style: Styles.awayTextBlack,
                                            textAlign: TextAlign.start,
                                            maxLines: 3,
                                          ),
                                        ],
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
                                              'Reached',
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
                                              "Mechanic location",
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

                ]))),
      ),
    );
  }

}
