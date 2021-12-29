import 'dart:async';
import 'dart:math';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_mdl.dart';
import 'package:auto_fix/Widgets/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class MeachanicWaitingScreen extends StatefulWidget {
  final String id;
  final String serviceId;
  const MeachanicWaitingScreen({Key? key, required this.id,required this.serviceId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MeachanicWaitingScreenState();
  }
}

class _MeachanicWaitingScreenState extends State<MeachanicWaitingScreen> {


  double per = .10;
  bool _isLoading = false;
  double km = 0;
  var _kGooglePlex;
  Set<Marker> markers = Set();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  BitmapDescriptor? pinLocationIcon;

  List<Datum> mechanicListData = [];
  Datum? mechanicListDataVal;
  bool fail = false;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(10.184909, 76.375305),
      zoom: 10,
    );
    /*Future.delayed(Duration.zero, () {
      createMarker(context);
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 36, top: 26, bottom: 10),
              child: Image.asset(
                'assets/images/back.png',
                width: 11,
                height: 19.2,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Container(
            margin: EdgeInsets.only(top: 22),
            child: Text(
              TextStrings.waiting_for_mechanic,
              style: TextStyle(
                  fontSize: 17,
                  color: CustColors.blue,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Corbel_Regular'),
            ),
          ),
        ),
        body: Container(
              margin:
              EdgeInsets.only(top: 80),
              alignment: Alignment.topCenter,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(

                                width: double.infinity,
                                height: _setValue(200),
                                margin: EdgeInsets.only(
                                    left: _setValue(34),
                                    right: _setValue(34),
                                    top: _setValue(10.1)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(_setValue(14.3)),
                                  child: GoogleMap(
                                    zoomControlsEnabled: false,
                                    myLocationButtonEnabled: true,
                                    myLocationEnabled: true,
                                    initialCameraPosition: _kGooglePlex,
                                    markers: markers,
                                    onMapCreated: (GoogleMapController controller) {
                                      ///controller.setMapStyle(Utils.mapStyles);
                                      _controller.complete(controller);
                                      mapController = controller;
                                      _getPolyline();
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                child: Image.asset(
                                  "assets/images/waitingMchanicGif.gif",
                                  height: 150.0,
                                  width: 150.0,
                                ),
                              ),
                              Container(
                                child: Image.asset(
                                  "assets/images/mechanic_search.png",
                                  height: 35.0,
                                  width: 35.0,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: _setValue(170.9),
                                left: _setValue(53),
                                right: _setValue(53)),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffbcbcbc),
                                    spreadRadius: 0,
                                    blurRadius: 6.5,
                                    offset: Offset(0, .8),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(_setValue(15.8))),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: _setValue(16.5)),
                                  child: Text(
                                    'Wait a minute!!',
                                    style: TextStyle(
                                        color: CustColors.black01,
                                        fontFamily: 'Corbel_Bold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.5),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: _setValue(11.8), bottom: _setValue(17.5)),
                                    child: Text(
                                      fail
                                          ? "Try again"
                                          : _isLoading
                                          ? "You can choose mechanic"
                                          : """waiting for a response from 
Mr.Eric""",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Color(0xff848484),
                                          fontFamily: 'Corbel_Light',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/images/waitingMechanic.png",
                              height: 200.0,
                              width: 200.0,
                            ),
                          ),
                        ],
                      ),


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {


                              });
                            },
                            child: Container(
                              width: _setValue(74.3),
                              height: _setValue(24),
                              margin: EdgeInsets.only(
                                  right: _setValue(31.8),
                                  top: _setValue(5.9),
                                  bottom: _setValue(20.4)),
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.3),
                                  color: CustColors.blue),
                              child: Center(
                                child: Text(
                                  TextStrings.proceed,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Corbel_Regular',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }


  createMarker(context) async {
    if (pinLocationIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      // pinLocationIcon =
      //     await getBytesFromAsset('assets/images/customer_marker.png', 22, 49)
      //         as BitmapDescriptor?;
      // setState(() {});
      pinLocationIcon = await getBitmapDescriptorFromAssetBytes(
          "assets/images/mechanic_search.png", 150, 150);

      // BitmapDescriptor.fromAssetImage(
      //         configuration, 'assets/images/customer_marker.png')
      //     .then((icon) {
      //   setState(() {
      //     pinLocationIcon = icon;
      //   });
      // });
    }
  }

  void _getPolyline() async {
    /// add origin marker origin marker
    var icon = BitmapDescriptor.defaultMarker;
    _addMarker(
      LatLng(10.1964, 76.3879),
      "origin",
      pinLocationIcon != null ? pinLocationIcon! : icon,
    );
  }


  Widget buildShimmerWidget() {
    return Container(
      margin: EdgeInsets.only(
          left: _setValue(33.5), right: _setValue(33.5), top: _setValue(16.8)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xffdddddd),
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: Offset(0, .8),
            ),
          ],
          borderRadius: BorderRadius.circular(_setValue(15.8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: _setValue(11.5),
                    right: _setValue(11.5),
                    top: _setValue(4.8),
                    bottom: _setValue(4.8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    _setValue(52.5),
                  ),
                  child: ShimmerWidget.circular(
                      width: _setValue(52.5), height: _setValue(52.5)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(
                    height: 14.5,
                    width: 100,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _setValue(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerWidget.rectangular(
                          height: _setValue(7.5),
                          width: _setValue(7.5),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _setValue(4)),
                        ),
                        ShimmerWidget.rectangular(
                          height: _setValue(7.5),
                          width: _setValue(7.5),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _setValue(4)),
                        ),
                        ShimmerWidget.rectangular(
                          height: _setValue(7.5),
                          width: _setValue(7.5),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _setValue(4)),
                        ),
                        ShimmerWidget.rectangular(
                          height: _setValue(7.5),
                          width: _setValue(7.5),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: _setValue(4)),
                        ),
                        ShimmerWidget.rectangular(
                          height: _setValue(7.5),
                          width: _setValue(7.5),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: ShimmerWidget.rectangular(
                      height: _setValue(12),
                      width: _setValue(100),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: _setValue(24.6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ShimmerWidget.rectangular(
                  height: _setValue(14.5),
                  width: _setValue(50),
                ),
                Container(
                  margin: EdgeInsets.only(top: _setValue(5)),
                  child: ShimmerWidget.rectangular(
                    height: _setValue(14.5),
                    width: _setValue(50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(
      String path, int width, int height) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width, int height) async {
    final Uint8List imageData = await getBytesFromAsset(path, width, height);
    setState(() {});
    _addMarker(
      LatLng(10.1964, 76.3879),
      "origin",
      BitmapDescriptor.fromBytes(imageData),
    );
    return BitmapDescriptor.fromBytes(imageData);
  }



// This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    //markers[markerId] = marker;
    markers.add(marker);
  }

}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}