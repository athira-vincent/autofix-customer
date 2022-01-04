import 'dart:async';
import 'dart:math';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicWaitingAndPayment/mechanic_waiting_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class MechanicProfileScreen extends StatefulWidget {
  final String id;
  final String serviceId;
  const MechanicProfileScreen({Key? key, required this.id,required this.serviceId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MechanicProfileScreenState();
  }
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  var _kGooglePlex;
  Completer<GoogleMapController> _controller = Completer();
  LatLng dest_location = LatLng(10.1964, 76.3879);
  Set<Marker> markers = Set();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  bool loadMore = false;
  BitmapDescriptor? pinLocationIcon;
  BitmapDescriptor? pinLocationIcon1;
  MechanicProfileBloc _mechanicProfileBloc = MechanicProfileBloc();
  double per = .10;
  late MechanicData _mechanicData;
  List<ServiceData> serviceDataList = [];
  bool _isLoading = false;
  double km = 0;
  String totalAmount = "";

  double _setValue(double value) {
    return value * per + value;
  }

  // Position currentPosition;
  // var geoLocator = Geolocator();
  // var locationOptions = LocationOptions(
  //     accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  // void getCurrentPosition() async {
  //   currentPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  // }
  _getViewVehicle() async {
    _mechanicProfileBloc.postViewMechanicDetails.listen((value) {
      if (value.status == "error") {
        setState(() {
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
          print("errrrorr 01");
          _isLoading = true;
          serviceDataList = value.data!.mechanicDetails!.serviceData!;
          _mechanicData = value.data!.mechanicDetails!.mechanicData!;
          totalAmount = value.data!.mechanicDetails!.totalAmount.toString();
          _kGooglePlex = CameraPosition(
            target: LatLng(_mechanicData.latitude, _mechanicData.longitude),
            zoom: 11,
          );
          Future.delayed(Duration.zero, () {
            createMarker(context);
          });
          km = calculateDistance(10.1964, 76.3879, _mechanicData.latitude,
                  _mechanicData.longitude)
              .roundToDouble();
          // value.data.mechanicList.mechanicListData[0].id;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _mechanicProfileBloc.postMechanicDetailsRequest(widget.id,widget.serviceId);
    _getViewVehicle();
  }

  @override
  void dispose() {
    super.dispose();
    _mechanicProfileBloc.dispose();
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
              'Profile',
              style: TextStyle(
                  fontSize: 17,
                  color: CustColors.blue,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Corbel_Regular'),
            ),
          ),
        ),
        body: _isLoading
            ? Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IntrinsicHeight(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                IntrinsicHeight(
                                  child: Stack(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(top: 18.6),
                                          child: Image.asset(
                                              'assets/images/rotate_rectangle.png')),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              _setValue(60)),
                                          child: Image.network(
                                            'https://picsum.photos/200',
                                            width: _setValue(103.1),
                                            height: _setValue(103.1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: _setValue(6.6)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _mechanicData.mechanicName.toString(),
                                    style: TextStyle(
                                        color: CustColors.black01,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Corbel_Bold',
                                        fontSize: 17),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: _setValue(4.4)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/active_star.png',
                                        width: _setValue(7.5),
                                        height: _setValue(7.5),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: _setValue(4)),
                                      ),
                                      Image.asset(
                                        'assets/images/active_star.png',
                                        width: _setValue(7.5),
                                        height: _setValue(7.5),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: _setValue(4)),
                                      ),
                                      Image.asset(
                                        'assets/images/active_star.png',
                                        width: _setValue(7.5),
                                        height: _setValue(7.5),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: _setValue(4)),
                                      ),
                                      Image.asset(
                                        'assets/images/active_star.png',
                                        width: _setValue(7.5),
                                        height: _setValue(7.5),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: _setValue(4)),
                                      ),
                                      Image.asset(
                                        'assets/images/deactive_star.png',
                                        width: _setValue(7.5),
                                        height: _setValue(7.5),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: _setValue(3)),
                                  child: Text(
                                    '21  Reviews',
                                    style: TextStyle(
                                        color: Color(0xffc1c1c1),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Corbel_Light',
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: Text(
                                      '$km KM',
                                      style: TextStyle(
                                          color: Color(0xff373232),
                                          fontFamily: 'Corbel_Bold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      'Away',
                                      style: TextStyle(
                                          color: Color(0xffc1c1c1),
                                          fontFamily: 'Corbel_Light',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: _setValue(151),
                            margin: EdgeInsets.only(
                                left: _setValue(34),
                                right: _setValue(34),
                                top: _setValue(10.1)),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(_setValue(14.3)),
                              child: GoogleMap(
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                initialCameraPosition: _kGooglePlex,
                                polylines: Set<Polyline>.of(polylines.values),
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
                            margin: EdgeInsets.only(
                                top: _setValue(130.9),
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
                                borderRadius:
                                    BorderRadius.circular(_setValue(15.8))),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: _setValue(16.5)),
                                  child: Text(
                                    'Indus Motors ',
                                    style: TextStyle(
                                        color: CustColors.black01,
                                        fontFamily: 'Corbel_Bold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.5),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: _setValue(11.8),
                                      bottom: _setValue(17.5)),
                                  child: Text(
                                    """406 Garki Abuja-FCT, Nigeria.""",
                                    style: TextStyle(
                                        color: Color(0xff848484),
                                        fontFamily: 'Corbel_Light',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.5),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            top: _setValue(13.8), left: _setValue(39.3)),
                        child: Text(
                          'Reviews',
                          style: TextStyle(
                              color: CustColors.blue,
                              fontFamily: 'Corbel_Regular',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.5),
                        ),
                      ),
                      ListView.builder(
                          itemCount: loadMore ? 5 : 5 - (5 - 2),
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _reviewsListItem();
                          }),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              loadMore = !loadMore;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _setValue(74.3),
                            height: _setValue(24),
                            margin: EdgeInsets.only(top: _setValue(7.9)),
                            decoration: BoxDecoration(
                                color: CustColors.blue,
                                borderRadius:
                                    BorderRadius.circular(_setValue(12.3))),
                            child: Text(
                              loadMore ? 'Show Less' : 'Load More',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Corbel_Regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.5),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: _setValue(17.8),
                          left: _setValue(39.3),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Selected Service',
                          style: TextStyle(
                              color: CustColors.blue,
                              fontFamily: 'Corbel_Regular',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.5),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: _setValue(2.2)),
                        child: ListView.builder(
                            itemCount: serviceDataList.length,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return _serviceListItem(serviceDataList[index]);
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: _setValue(31.1),
                          left: _setValue(39.3),
                          right: _setValue(39.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total Amount',
                                style: TextStyle(
                                    color: CustColors.black01,
                                    fontFamily: 'Corbel_Regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.5),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 15, bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                totalAmount,
                                style: TextStyle(
                                    color: CustColors.black01,
                                    fontFamily: 'Corbel_Regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {

                           Navigator.pop(context);
                           Navigator.push(
                           context,
                           MaterialPageRoute(
                           builder: (context) => MeachanicWaitingScreen(
                            id:'1',
                            serviceId: '1',
                            )));

                          });
                        },
                        child: Container(
                          width: _setValue(74.3),
                          height: _setValue(24),
                          margin: EdgeInsets.only(
                              right: _setValue(31.8),
                              top: _setValue(23.9),
                              bottom: _setValue(26.4)),
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.3),
                              color: CustColors.blue),
                          child: Center(
                            child: Text(
                              'Next',
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
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }

  Widget _reviewsListItem() {
    return Container(
      margin: EdgeInsets.only(
          left: _setValue(34),
          bottom: _setValue(9.8),
          top: _setValue(18),
          right: _setValue(34)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              _setValue(52.5),
            ),
            child: Image.network(
              'https://picsum.photos/200',
              width: _setValue(52.5),
              height: _setValue(52.5),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: _setValue(7.8)),
              padding: EdgeInsets.symmetric(
                  vertical: _setValue(14.8), horizontal: _setValue(17.8)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffbcbcbc),
                      spreadRadius: 0,
                      blurRadius: 1.5,
                      offset: Offset(0, .8),
                    ),
                  ],
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fast Service',
                    style: TextStyle(
                        color: CustColors.black01,
                        fontFamily: 'Corbel_Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _setValue(7.3)),
                    child: Text(
                      'Fast ServiceFast ServiceFast ServiceFast ServiceFast ServiceFast ServiceFast Service',
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                          color: Color(0xff848484),
                          fontFamily: 'Corbel_Light',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceListItem(ServiceData serviceData) {
    return Container(
      margin: EdgeInsets.only(
          left: _setValue(39.3), right: _setValue(39.3), top: _setValue(18.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            serviceData.service!.serviceName.toString(),
            style: TextStyle(
                color: Color(0xff848484),
                fontWeight: FontWeight.w600,
                fontFamily: 'Corbel_Light',
                fontSize: 14.5),
          ),
          Text(
            '\$ ${serviceData.service!.fee}',
            style: TextStyle(
                color: CustColors.black01,
                fontFamily: 'Corbel_Regular',
                fontWeight: FontWeight.w600,
                fontSize: 14.5),
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
    //markers[markerId] = marker;
    markers.add(marker);
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
    var icon = BitmapDescriptor.defaultMarker;
    _addMarker(
      LatLng(10.1964, 76.3879),
      "origin",
      pinLocationIcon != null ? pinLocationIcon! : icon,
    );

    // Add destination marker
    _addMarker(
      LatLng(_mechanicData.latitude, _mechanicData.longitude),
      "destination",
      pinLocationIcon1 != null ? pinLocationIcon1! : icon,
    );

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCOijUnxSdUDHpQWIqJT5y-BklV9pI0Te0",
      PointLatLng(_mechanicData.latitude, _mechanicData.longitude),
      PointLatLng(10.1964, 76.3879),
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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void setCustomMapPin() async {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/location_hotel.png');
  }

  createMarker(context) async {
    if (pinLocationIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      // pinLocationIcon =
      //     await getBytesFromAsset('assets/images/customer_marker.png', 22, 49)
      //         as BitmapDescriptor?;
      // setState(() {});
      pinLocationIcon = await getBitmapDescriptorFromAssetBytes(
          "assets/images/customer_marker.png", 49);
      // BitmapDescriptor.fromAssetImage(
      //         configuration, 'assets/images/customer_marker.png')
      //     .then((icon) {
      //   setState(() {
      //     pinLocationIcon = icon;
      //   });
      // });
    }
    if (pinLocationIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      // pinLocationIcon =
      //     await getBytesFromAsset('assets/images/customer_marker.png', 22, 49)
      //         as BitmapDescriptor?;
      // setState(() {});
      pinLocationIcon1 = await getBitmapDescriptorFromAssetBytes(
          "assets/images/mechanic_marker.png", 100);
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }


}
