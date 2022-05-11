
import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/MechanicProfileView/mechanic_profile_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;


class FindMechanicListScreen extends StatefulWidget {

  final String latitude;
  final String longitude;
  final String authToken;
  final String serviceIds;
  final String serviceType;


  FindMechanicListScreen({required this.authToken,required this.serviceIds,required this.serviceType,required this.latitude,required this.longitude});

  @override
  State<StatefulWidget> createState() {
    return _FindMechanicListScreenState();
  }
}

class _FindMechanicListScreenState extends State<FindMechanicListScreen> {

  String authToken="";
  String waitingMechanic="-1";
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";

  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(12.988827, 77.472091);
  String? _mapStyle;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle(_mapStyle);
  }

  Set<Polyline> lines = {};


  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  // Starting point latitude
  double _originLatitude = 6.5212402;
// Starting point longitude
  double _originLongitude = 3.3679965;
// Destination latitude
  double _destLatitude = 6.849660;
// Destination Longitude
  double _destLongitude = 3.648190;
// Markers to show points on the map
  Map<MarkerId, Marker> markers = {};

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

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
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "YOUR API KEY HERE",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();
    _listenServiceListResponse();

    /// add origin marker origin marker
    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
      _homeCustomerBloc.postFindMechanicsListEmergencyRequest(
          "$authToken",
          "0",
          "200",
          widget.latitude,
          widget.longitude,
          widget.serviceIds,
          "emergency");

    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.findMechanicsListEmergencyResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          waitingMechanic = "0";
        });

      } else {

        setState(() {

          if(value.data?.mechanicList?.data?.length==0)
            {
              waitingMechanic = "0";
            }
          else
            {
              waitingMechanic = "1";
            }

          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");

        });
      }
    });

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

                CurvedBottomSheetContainer(
                  percentage: 0.60,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        waitingMechanic=="-1"
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 70,
                            width: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                              Radius.circular(10),
                              ),
                              color: CustColors.pale_grey,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Wait a minute!!",
                                  style: TextStyle(
                                      color: CustColors.light_navy,
                                      fontFamily: "Samsung_SharpSans_Medium",
                                      fontSize: 13.3
                                  ),
                                ),
                                Text("Finding mechanic near you \n Almost  there…..",
                                  style: TextStyle(
                                      color: CustColors.warm_grey03,
                                      fontFamily: "Samsung_SharpSans_Regular",
                                      fontSize: 10
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : Container(),

                        Container(
                          child: Column(
                            children: [
                              waitingMechanic=="0" ||  waitingMechanic=="-1"
                              ? Container()
                              : Padding(
                                padding: const EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text("Mechanic found",
                                      style: TextStyle(
                                        fontFamily: "Samsung_SharpSans_Medium",
                                        fontSize: 16.7,
                                        color: CustColors.black_04,
                                      ),),
                                  ),
                                ),
                              ),

                              waitingMechanic=="0"
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(15,20,15,15),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(15,0,15,15),
                                                    child: Container(
                                                      height: 100,
                                                      width: 260,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        color: CustColors.pale_grey,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text("Oops!! Mechanic not found!",
                                                              style: Styles.oopsmechanicNotFoundStyle,
                                                            ),
                                                            Text("No mechanic in your region",
                                                              style: Styles.smallTitleStyle1,
                                                            ),
                                                            Text("Try after sometime!",
                                                              style: Styles.TryAfterSomeTimetyle,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    height: 120,
                                                    child: SvgPicture.asset(
                                                      'assets/image/mechanicProfileView/mechanicNotFound.svg',
                                                      height: 120,
                                                      fit: BoxFit.cover,
                                                    )
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: StreamBuilder(
                                              stream:  _homeCustomerBloc.findMechanicsListEmergencyResponse,
                                              builder: (context, AsyncSnapshot<MechanicListMdl> snapshot) {
                                                print("${snapshot.hasData}");
                                                print("${snapshot.connectionState}");
                                                switch (snapshot.connectionState) {
                                                  case ConnectionState.waiting:
                                                    return progressBarLightRose();
                                                  default:
                                                    return
                                                      snapshot.data?.data?.mechanicList?.data?.length != 0 && snapshot.data?.data?.mechanicList?.data?.length != null
                                                       ? ListView.builder(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                            scrollDirection: Axis.vertical,
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount:snapshot.data?.data?.mechanicList?.data?.length,
                                                            itemBuilder: (context, index) {
                                                                  return InkWell(
                                                                    onTap: (){
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                                  builder: (context) =>  MechanicProfileViewScreen(
                                                                                    mechanicId: "${snapshot.data?.data?.mechanicList?.data![index].id.toString()}",
                                                                                    authToken: '$authToken',
                                                                                    mechanicListData: snapshot.data?.data?.mechanicList?.data![index],
                                                                                    isEmergency: true,
                                                                                    serviceModel: "",
                                                                                    serviceIds: widget.serviceIds,
                                                                                    longitude: widget.longitude,
                                                                                    latitude: widget.latitude,
                                                                                  )));
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.fromLTRB(10,5,10,0),
                                                                      child: Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                            color: CustColors.whiteBlueish,
                                                                            borderRadius: BorderRadius.circular(11.0)
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(0),
                                                                          child: Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                                                                child: Container(
                                                                                  width: 80.0,
                                                                                  height: 80.0,
                                                                                  child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                                      child:Container(
                                                                                          child:CircleAvatar(
                                                                                              radius: 50,
                                                                                              backgroundColor: Colors.white,
                                                                                              child: ClipOval(
                                                                                                child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                                                                              )))

                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(2),
                                                                                        child: Text(
                                                                                          '${snapshot.data?.data?.mechanicList?.data?[index].firstName}',
                                                                                          style: Styles.mechanicNameStyle,
                                                                                          maxLines: 1,
                                                                                          textAlign: TextAlign.start,
                                                                                          overflow: TextOverflow.visible,),
                                                                                      ),

                                                                                      Container(
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [

                                                                                            Padding(
                                                                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                                                              child: RatingBar.builder(
                                                                                                initialRating: 0,
                                                                                                minRating: 1,
                                                                                                direction: Axis.horizontal,
                                                                                                allowHalfRating: true,
                                                                                                itemCount: 5,
                                                                                                itemSize: 12,
                                                                                                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                                                                                                itemBuilder: (context, _) => Icon(
                                                                                                  Icons.star,
                                                                                                  color: CustColors.blue,
                                                                                                ),
                                                                                                onRatingUpdate: (rating) {
                                                                                                  print(rating);
                                                                                                },
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                                                              child: Text('${snapshot.data?.data?.mechanicList?.data?[index].reviewCount} Reviews',
                                                                                                style: Styles.smallTitleStyle1,),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 100,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                                                            child: Text('${snapshot.data?.data?.mechanicList?.data?[index].distance}',
                                                                                              style: Styles.smallTitleStyle1,),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                                                            child: Text('${snapshot.data?.data?.mechanicList?.data?[index].duration}',
                                                                                              style: Styles.smallTitleStyle1,),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(0,3,0,3),
                                                                                            child: Text('₦ ${snapshot.data?.data?.mechanicList?.data?[index].totalAmount}',
                                                                                              style: Styles.totalAmountStyle,),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                            },
                                                          )
                                                       : Padding(
                                                        padding: const EdgeInsets.fromLTRB(15,0,15,15),
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Align(
                                                                    alignment: Alignment.center,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.fromLTRB(15,0,15,15),
                                                                      child: Container(
                                                                        height: 100,
                                                                        width: 260,
                                                                        decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(10),
                                                                          ),
                                                                          color: CustColors.pale_grey,
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(10),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text("Oops!! Mechanic not found!",
                                                                                style: Styles.oopsmechanicNotFoundStyle,
                                                                              ),
                                                                              Text("No mechanic in your region",
                                                                                style: Styles.smallTitleStyle1,
                                                                              ),
                                                                              Text("Try after sometime!",
                                                                                style: Styles.TryAfterSomeTimetyle,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      height: 120,
                                                                      child: SvgPicture.asset(
                                                                        'assets/image/mechanicProfileView/mechanicNotFound.svg',
                                                                        height: 120,
                                                                        fit: BoxFit.cover,
                                                                      )
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                }

                                              }),
                                        ),
                                      ],
                                    ),
                                  )
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
                                    InkWell(
                                      onTap:()
                                      {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        child: Icon(Icons.arrow_back, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0,15,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Finding mechanic near you",
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


  Widget progressBarDarkBlue() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarLightRose() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarTransparent() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.transparent),
          )),
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









