import 'dart:async';
import 'dart:typed_data';

import 'package:auto_fix/Common/chat/chat.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/HomeCustomer/customer_home.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicWorkProgressScreen/mechanic_work_progress_arrived_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicWorkProgressScreen/mechanic_work_progress_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:location/location.dart' as loc;
import 'dart:math' show cos, sqrt, asin;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class MechanicTrackingScreen extends StatefulWidget {

  final String latitude;
  final String longitude;
  final String bookingId;


  MechanicTrackingScreen({
    required this.latitude,
    required this.longitude,
    required this.bookingId
  });

  @override
  State<StatefulWidget> createState() {
    return _MechanicTrackingScreenState();
  }

}

class _MechanicTrackingScreenState extends State<MechanicTrackingScreen> {

  String googleAPiKey = TextStrings.googleAPiKey;
  String? _mapStyle;
  Set<Marker> markers = Set(); //markers for google map
  BitmapDescriptor? customerIcon;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  LatLng startLocation = LatLng(37.778259000, -122.391386000);
  LatLng endLocation = LatLng(37.778259000, -122.390942000);
  late BitmapDescriptor mechanicIcon;
  CameraPosition? _kGooglePlex = CameraPosition(
    target: LatLng(37.778259000,
      -122.391386000,),
    zoom: 25,
  );
  double totalDistance = 0.0;
  var _firestoreData ;
  double distanceInMeters = 0.0;
  var updatingLat = 0.0;
  String mechanicArrivalState = "0";
  String authToken="";
  String userName="";
  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";
  String callPhoneNumber = "";
  String customerId = "", mechanicId = "", mechanicName = "", mechanicProfileUrl = "", customerProfileUrl = "";
  Timer? locationTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    mapStyling();
    customerMarker (LatLng(double.parse(widget.latitude.toString()), double.parse(widget.longitude.toString())));
    getGoogleMapCameraPosition(LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
    listenToCloudFirestoreDB();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData MechanicTrackingScreen Customer App');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    if(mounted){
      setState(() {
        authToken = shdPre.getString(SharedPrefKeys.token).toString();
        userName = shdPre.getString(SharedPrefKeys.userName).toString();
        serviceIdEmergency = shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
        mechanicIdEmergency = shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
        bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
        _firestoreData = _firestore.collection("ResolMech").doc('${widget.bookingId}').snapshots();
        updateToCloudFirestoreMechanicCurrentScreenDB();
        print('authToken>>>>>>>>>MechanicTrackingScreen Customer App ' + authToken.toString());
        print('serviceIdEmergency>>>>>>>>MechanicTrackingScreen Customer App ' + serviceIdEmergency.toString());
        print('mechanicIdEmergency>>>>>>>MechanicTrackingScreen Customer App ' + mechanicIdEmergency.toString());
        print('bookingIdEmergency>>>>>>>>>MechanicTrackingScreen Customer App ' + bookingIdEmergency.toString());

      });
    }
  }

  void listenToCloudFirestoreDB() {
    print("listenToCloudFirestoreDB >>>>");

     _firestore.collection("ResolMech").doc('${widget.bookingId}').snapshots().listen((querySnapshot) {
       if(mounted){
         setState(() {
           customerId = querySnapshot.get('customerID');
           mechanicId = querySnapshot.get('mechanicID');
           mechanicName = querySnapshot.get('mechanicName');
           mechanicArrivalState = querySnapshot.get("mechanicArrivalState");
           mechanicProfileUrl = querySnapshot.get('mechanicProfileUrl');
           customerProfileUrl = querySnapshot.get('customerProfileUrl');
           callPhoneNumber = querySnapshot.get('mechanicPhone');
           print('mechanicArrivalState ++++ $mechanicArrivalState');
           if(mechanicArrivalState =="1")
           {
             locationTimer!.cancel();
             Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>  MechanicWorkProgressArrivedScreen(bookingId: widget.bookingId,) // Work status - 1
                 ));
           }
         });
       }
    });

  }

  void updateToCloudFirestoreMechanicCurrentScreenDB() {
    _firestore
        .collection("ResolMech")
        .doc('${bookingIdEmergency}')
        .update({
          "customerFromPage" : "C1",
        })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  mapStyling() {
    print('latlong from another screen ${widget.latitude} ${widget.longitude}');
    rootBundle.loadString('assets/map_style/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  customerMarker(LatLng latLng) {
    getBytesFromAsset('assets/image/mechanicTracking/carMapIcon.png', 150).then((onValue) {
      customerIcon =BitmapDescriptor.fromBytes(onValue);
      markers.add(Marker( //add start location marker
        markerId: MarkerId('customerMarkerId'),
        position: latLng, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'customer location',
          snippet: 'customer location',
        ),
        icon: customerIcon!, //Icon for Marker
      ));
    });

  }

  mechanicMarker(LatLng latLng) {
    print('Current latitude ${latLng.latitude}  Current longitude ${latLng.longitude}');
    getBytesFromAsset('assets/image/mechanicTracking/mechanicMapIcon.png', 150).then((onValue) {
      print("getBytesFromAsset 001");
      mechanicIcon =BitmapDescriptor.fromBytes(onValue);
      markers.add(Marker(
        visible: true,//add start location marker
        markerId: MarkerId('mechanicMarkerId'),
        position: latLng, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'mechanic location',
          snippet: 'mechanic location',
        ),
        icon: mechanicIcon, //Icon for Marker
      ));
      if(mounted){
        setState(() {
          print("markers ${markers.length}");
          setPolyline(LatLng(double.parse(widget.latitude.toString()), double.parse(widget.longitude.toString())), latLng,);
        });
      }
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

  setPolyline(LatLng startlatLng, LatLng endlatLng,) async {
    print('MechanicTrackingScreen setPolyline');
    List<LatLng> polylineCoordinates = [];
    polylinePoints = PolylinePoints();
    if (polylines.isNotEmpty)
      polylines.clear();
    if (polylineCoordinates.isNotEmpty)
      polylineCoordinates.clear();
    print("polylineCoordinates ${polylines.length}");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startlatLng.latitude, startlatLng.longitude),
      PointLatLng(endlatLng.latitude, endlatLng.longitude),
      travelMode: TravelMode.driving,
    );
    // log('getDirections + ${result?.points}' );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));

      });
    } else {
      print('PolylineResult + ${result.errorMessage}' );
    }

    addPolyLine(polylineCoordinates);

  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          Navigator.pushNamed(context, '/customerMainLandingScreen').then((_) => setState(() {}));
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _firestoreData,
                  builder: (_, snapshot) {

                    if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {

                      locationTimer = Timer(const Duration(seconds: 10), () {
                        print(">>> Firebase lat " + snapshot.data?.data()!['latitude']);
                        if(updatingLat != double.parse('${snapshot.data?.data()!['latitude']}'))
                        {
                          if(mounted){
                            setState(() {
                              distanceInMeters = Geolocator.distanceBetween(double.parse('${widget.latitude}'), double.parse('${widget.longitude}'), double.parse('${snapshot.data?.data()!['latitude']}'), double.parse('${snapshot.data?.data()!['longitude']}'));
                              print('DISTANCE distanceInMeters===== : ${distanceInMeters/1000} ');
                            });
                          }
                          updatingLat =  double.parse('${snapshot.data?.data()!['latitude']}');
                          mechanicMarker(LatLng(double.parse('${snapshot.data?.data()!['latitude']}'),double.parse('${snapshot.data?.data()!['longitude']}')));
                        }
                      });

                      return GoogleMap(

                        //Map widget from google_maps_flutter package
                        zoomGesturesEnabled: true, //enable Zoom in, out on map
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        initialCameraPosition: _kGooglePlex!,
                        markers: markers, //markers to show on map
                        polylines: Set<Polyline>.of(polylines.values), //polylines
                        mapType: MapType.normal, //map type
                        onMapCreated: (controller) { //method called when map is created
                          if(mounted){
                            setState(() {
                              controller.setMapStyle(_mapStyle);
                              mapController = controller;
                            });
                          }
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
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
                                    child: InkWell(
                                      onTap: (){
                                        //  updateToCloudFirestoreDB();
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            int.parse('${(distanceInMeters).toString().split('.').first}') <= 500
                                                ? "${(distanceInMeters).toStringAsFixed(2)} m"
                                                : "${(distanceInMeters/1000).toStringAsFixed(2)} km",
                                            // "${distanceInMeters/1000} km",
                                            style: Styles.waitingTextBlack17,
                                          ),
                                          Text(
                                            "Away",
                                            style: Styles.awayTextBlack,
                                          ),
                                        ],
                                      ),
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
                                bottomRight:   Radius.circular(20),
                                bottomLeft:  Radius.circular(20)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: InkWell(
                                    onTap: (){
                                      //String callPhoneNumber = "90488878777";
                                      _callPhoneNumber(callPhoneNumber);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height : 25,
                                            width: 25,
                                            child: Image.asset("assets/image/ic_call_blue_white.png")
                                        ),
                                        Text(
                                          "Call",
                                          style: Styles.popUPTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child:  Container(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                peerId: mechanicId,
                                                bookingId: '${bookingIdEmergency}',
                                                collectionName: 'ResolMech',
                                                currentUserId: customerId,
                                                peerName: mechanicName,
                                                myImageUrl: customerProfileUrl,
                                                peerImageUrl: mechanicProfileUrl,
                                              )));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height : 25,
                                            width: 25,
                                            child: Image.asset("assets/image/ic_chat_blue_white.png")
                                        ),
                                        Text(
                                          "Chat",
                                          style: Styles.popUPTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child:  Container(
                                  child: InkWell(
                                    onTap: (){
                                      Fluttertoast.showToast(msg: "mechanic is coming to your location");
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height : 25,
                                            width: 25,
                                            child: Image.asset("assets/image/ic_navigate_blue_white.png")
                                        ),
                                        Text(
                                          "Navigate",
                                          style: Styles.popUPTextStyle,
                                        ),
                                      ],
                                    ),
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
                                    /*Container(
                                        child: Icon(Icons.arrow_back, color: Colors.black),
                                      ),*/
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0,15,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Mechanic is on his way",
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

  void _callPhoneNumber(String phoneNumber) async {
    var url = 'tel://$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error Occurred';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }


}
