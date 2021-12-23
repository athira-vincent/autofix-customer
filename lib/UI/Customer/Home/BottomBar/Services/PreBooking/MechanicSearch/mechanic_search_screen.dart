import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_mdl.dart';
import 'package:auto_fix/Widgets/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class MechanicSearchScreen extends StatefulWidget {
  final String serviceID;
  const MechanicSearchScreen({Key? key, required this.serviceID})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MechanicSearchScreenState();
  }
}

class _MechanicSearchScreenState extends State<MechanicSearchScreen> {
  var _kGooglePlex;
  Set<Marker> markers = Set();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  BitmapDescriptor? pinLocationIcon;
  final MechanicListBloc _mechanicListBloc = MechanicListBloc();

  List<MechanicListData> mechanicListData = [];
  MechanicListData? mechanicListDataVal;
  bool fail = false;
  bool _isLoading = false;
  double per = .10;
  double km = 0;
  double _setValue(double value) {
    return value * per + value;
  }

  String token = "";

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
    _mechanicListBloc.postMechanicListRequest(token, 1, 10, widget.serviceID);
    //_allMakeBloc.postAllMakeRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
    _mechanicListBloc.dispose();
  }

  _getViewVehicle() async {
    _mechanicListBloc.postViewMechanicList.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("errrrorr 01");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
          fail = true;
        });
      } else {
        setState(() {
          print("Success 01");
          _isLoading = true;
          mechanicListData = value.data!.mechanicList!.mechanicListData!;
          km = calculateDistance(10.1964, 76.3879,
                  mechanicListData[0].latitude!, mechanicListData[0].longitude!)
              .roundToDouble();
          // value.data.mechanicList.mechanicListData[0].id;
        });
      }
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(10.184909, 76.375305),
      zoom: 11,
    );
    Future.delayed(Duration.zero, () {
      createMarker(context);
    });
    _addToken();
    _getViewVehicle();
  }

// This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    //markers[markerId] = marker;
    markers.add(marker);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Waiting for a mechanic',
            style: TextStyle(
                fontSize: 23.3,
                color: CustColors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Corbel_Bold'),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                        borderRadius: BorderRadius.circular(_setValue(15.8))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: _setValue(16.5)),
                          child: Text(
                            fail
                                ? "Something wrong"
                                : _isLoading
                                    ? "You can choose mechanic"
                                    : 'Wait a minute!!',
                            style: TextStyle(
                                color: CustColors.black01,
                                fontFamily: 'Corbel_Bold',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (fail) {
                              _isLoading = false;
                              setState(() {});
                              _mechanicListBloc.postMechanicListRequest(
                                  token, 1, 10, widget.serviceID);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: _setValue(11.8), bottom: _setValue(17.5)),
                            child: Text(
                              fail
                                  ? "Try again"
                                  : _isLoading
                                      ? "You can choose mechanic"
                                      : """Finding mechanic near you Almost  there…..""",
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
              Container(
                margin: EdgeInsets.only(
                    top: _setValue(36.5), left: _setValue(33.3)),
                alignment: Alignment.centerLeft,
                child: Text(
                  fail
                      ? "Oops !!    Mechanic not found!"
                      : _isLoading
                          ? ""
                          : 'Mechanic found',
                  style: TextStyle(
                      fontSize: 14.5,
                      color: CustColors.black01,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Corbel_Bold'),
                ),
              ),
              fail
                  ? Container(
                      margin: EdgeInsets.only(top: _setValue(22.3)),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/mechanic_search_fail.png",
                        width: _setValue(111.3),
                        height: _setValue(111.3),
                      ),
                    )
                  : _isLoading
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MechanicProfileScreen(
                                          id: mechanicListData[0].id.toString(),
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: _setValue(33.5),
                                right: _setValue(33.5),
                                top: _setValue(16.8)),
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
                                borderRadius:
                                    BorderRadius.circular(_setValue(15.8))),
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
                                        child: Image.network(
                                          'https://picsum.photos/200',
                                          width: _setValue(52.5),
                                          height: _setValue(52.5),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mechanicListData[0]
                                              .displayName
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14.5,
                                              color: CustColors.black01,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Corbel_Regular'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: _setValue(2)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/active_star.png',
                                                width: _setValue(7.5),
                                                height: _setValue(7.5),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: _setValue(4)),
                                              ),
                                              Image.asset(
                                                'assets/images/active_star.png',
                                                width: _setValue(7.5),
                                                height: _setValue(7.5),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: _setValue(4)),
                                              ),
                                              Image.asset(
                                                'assets/images/active_star.png',
                                                width: _setValue(7.5),
                                                height: _setValue(7.5),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: _setValue(4)),
                                              ),
                                              Image.asset(
                                                'assets/images/active_star.png',
                                                width: _setValue(7.5),
                                                height: _setValue(7.5),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: _setValue(4)),
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
                                          margin: EdgeInsets.only(top: 3),
                                          child: Text(
                                            '71  Reviews',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffc1c1c1),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Corbel_Light'),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: _setValue(24.6)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$km Km',
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            color: CustColors.black01,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Corbel_Bold'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: _setValue(5)),
                                        child: Text(
                                          '\$88',
                                          style: TextStyle(
                                              fontSize: 14.5,
                                              color: CustColors.black01,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Corbel_Bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : buildShimmerWidget(),
              fail
                  ? SizedBox(
                      width: 0,
                      height: 0,
                    )
                  : _isLoading
                      ? Container(
                          width: _setValue(89.6),
                          height: _setValue(24),
                          margin: EdgeInsets.only(
                            right: _setValue(33.5),
                            top: _setValue(33.5),
                          ),
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.3),
                              color: CustColors.blue),
                          child: Center(
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5),
                            ),
                          ),
                        )
                      : Container(
                          width: _setValue(89.6),
                          height: _setValue(24),
                          margin: EdgeInsets.only(
                            right: _setValue(33.5),
                            top: _setValue(33.5),
                          ),
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.3),
                              color: CustColors.blue),
                          child: ShimmerWidget.rectangular(
                            width: _setValue(89.6),
                            height: _setValue(24),
                          ),
                        ),
            ],
          ),
          Image.asset("assets/images/mechanic_search_bottom.png")
        ],
      ),
    );
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
}
