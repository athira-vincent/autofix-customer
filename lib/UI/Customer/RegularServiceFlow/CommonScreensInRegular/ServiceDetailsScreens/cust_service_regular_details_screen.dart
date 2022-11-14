import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularRateMechanic/regular_rate_mechanic_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/MobileMechanicFlow/cust_mobile_mech_service_track_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/PickAndDropOffFlow/cust_pick_up_track_service_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/PickAndDropOffFlow/x_cust_pick_up_track_service_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/TakeToMechanicFlow/cust_take_vehicle_track_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceDetailsScreen/mech_service_mdl.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceDetailsScreen/mech_service_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Mechanic/mechanic_home_screen.dart';

class CustServiceRegularDetailsScreen extends StatefulWidget {

  final String bookingId;
  final String firebaseCollection;
  CustServiceRegularDetailsScreen({
    required this.bookingId,
    required this.firebaseCollection,
});

  @override
  State<StatefulWidget> createState() {
    return _CustServiceRegularDetailsScreen();
  }
}

class _CustServiceRegularDetailsScreen extends State<CustServiceRegularDetailsScreen> {

  String authToken = "", type = "",bookingId = "", userId = "", bookingDate = "";
  MechServiceDetailsReviewBloc _mechServiceDetailsReviewBloc = MechServiceDetailsReviewBloc();
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();

  bool isLoading = true;
  BookingDetails? _BookingDetails;
  String firebaseCollection = "";

  @override
  void initState() {
    super.initState();
    firebaseCollection = widget.firebaseCollection;
    bookingId = widget.bookingId;
    getSharedPrefData();
    _listenApiResponse();
    //_getLocation();
  }

  Future<void> getSharedPrefData()async{
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      _mechServiceDetailsReviewBloc.postGetMechServiceDetailsReviewRequest(
          authToken, bookingId
      );
    });
  }

  _listenApiResponse(){
    _mechServiceDetailsReviewBloc.mechServiceDetailsMdlResponse.listen((value) {
      if(value.data == "error"){
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.data.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }else{
        setState(() {
          isLoading = false;
          _BookingDetails = value.data!.bookingDetails;
          /*if(_BookingDetails!.regularType.toString() == "1"){
            firebaseCollection = TextStrings.firebase_pick_up;
          }else if(_BookingDetails!.regularType.toString() == "2"){
            firebaseCollection = TextStrings.firebase_mobile_mech;
          }else if(_BookingDetails!.regularType.toString() == "3"){
            firebaseCollection = TextStrings.firebase_take_vehicle;
          }*/
          listenToCloudFirestoreDB();
        });
      }
    });
  }

  void listenToCloudFirestoreDB() {
    //_firestoreData = _firestore.collection("ResolMech").doc('$bookingId').snapshots();
    _firestore.collection("${firebaseCollection}").doc('${widget.bookingId}').snapshots().listen((event) {

      setState(() {
        bookingDate = event.get("bookingDate");
      });
    });
  }

  _getLocation() async {
    Position position = await
    Geolocator.getCurrentPosition(desiredAccuracy:
    LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    List<Placemark> addresses = await
    placemarkFromCoordinates(position.latitude,position.longitude);

    var first = addresses.first;
    print("${first.name} : ${first..administrativeArea}");

    String address = '${first.street}, ${first.subLocality}, ${first.locality}';

    if(addresses.isNotEmpty){
      updateToCloudFirestoreDB(address);
    }

  }

  void updateToCloudFirestoreDB(String address) {
    _firestore
        .collection("${firebaseCollection}")
        .doc('${widget.bookingId}')
        .update({
      "customerAddress" : "$address",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: CustColors.light_navy,
        elevation: 0,
        title: Container(
          child: Text('Service details',
            style: TextStyle(
              fontFamily: 'SamsungSharpSans-Medium',
              fontSize: 16.7,
            ),),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: isLoading == true
              ? Container(
                width: size.width,
                height: size.height,
                child: Center(child: CircularProgressIndicator(color: CustColors.light_navy)))
              : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),
                      color: CustColors.light_navy,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _BookingDetails!.mechanicService!.length,
                              itemBuilder: (BuildContext context, int index){
                                return listViewItems(_BookingDetails!.mechanicService![index]);
                              }),
                        ),
                        Container(
                          child: Column(
                            children:[
                              Container(
                                height: 120,
                                child: Row(
                                    children:[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 22.0),
                                        child: Container(
                                          height:82,
                                          width: 127,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 00,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            children:[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10.0),
                                                child: Text('Service Type',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'SamsungSharpSans-Medium',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),),
                                              ),
                                              Row(
                                                children: [
                                                  /*Padding(
                                                    padding: const EdgeInsets.only(left: 15.0,top: 15),
                                                    child:  Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Image.asset('assets/image/ic_clock.png')),
                                                  ),*/
                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                      child: Text(
                                                        //_BookingDetails!.serviceTime.toString(),
                                                        _BookingDetails!.regularType.toString() == "1"
                                                            ? "Pick Up & Drop Off"
                                                            : _BookingDetails!.regularType.toString() == "2"
                                                            ? "Mobile Mechanic"
                                                            : _BookingDetails!.regularType.toString() == "3"
                                                            ? "Take My Vehicle" : "Emergency Service",
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white
                                                        ),),
                                                    ),
                                                  ),
                                                  /*Padding(
                                                    padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                    child: Text('Min',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white
                                                      ),),
                                                  ),*/
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 22.0),
                                        child: Container(
                                          height:82,
                                          width: 127,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 00,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            children:[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10.0),
                                                child: Text('Total estimated cost',
                                                  textAlign: TextAlign.center,
                                                  style:TextStyle(
                                                    fontFamily: 'SamsungSharpSans-Medium',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 25.0,top: 15),
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: SvgPicture.asset('assets/image/ic_moneybag.svg')),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                    child: Text('₦',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                    child: Text(
                                                      _BookingDetails!.totalPrice.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 22.0,right: 22.0),
                                child: Divider(
                                  thickness: .7,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 95,
                                child: Row(
                                    children:[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 22.0),
                                        child: Container(
                                          height:82,
                                          width: 127,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CustColors.light_navy,
                                                width: 00,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            children:[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10.0),
                                                child: Text(
                                                  //'VEHICLE PICKING DATE',
                                                  'SERVICE DATE',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'SamsungSharpSans-Medium',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 15, left: 8),
                                                    child: SvgPicture.asset('assets/image/ic_calender.svg',
                                                      height: 20,
                                                      width: 20,
                                                      color: Colors.white,),
                                                    // Icon(Icons.date_range,
                                                    //   size: 30,
                                                    //   color: Colors.white,),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                    child: Text(
                                                      //'Mar 5,',
                                                      _homeCustomerBloc.dateMonthConverter(_BookingDetails!.bookedDate!),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                  //   child: Text('2022',
                                                  //     style: TextStyle(
                                                  //         fontSize: 15,
                                                  //         color: Colors.white
                                                  //     ),),
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 22.0),
                                        child: Container(
                                          height:82,
                                          width: 127,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CustColors.light_navy,
                                                width: 00,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Column(
                                            children:[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10.0),
                                                child: Text(
                                                  'SERVICE TIME',
                                                  //'VEHICLE PICKING TIME',
                                                  textAlign: TextAlign.center,
                                                  style:TextStyle(
                                                    fontFamily: 'SamsungSharpSans-Medium',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 15, left: 10),
                                                    child:  Container(
                                                        height: 20,
                                                        width:20,
                                                        child: Image.asset('assets/image/ic_clock.png')),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                    child: Text(
                                                      //'Mar 5,',
                                                     // _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(bookingDate)),
                                                      _homeCustomerBloc.timeConvert(new DateFormat("hh:mm:ss").parse(_BookingDetails!.bookedTime)).toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                  //   child: Text('2022',
                                                  //     style: TextStyle(
                                                  //         fontSize: 15,
                                                  //         color: Colors.white
                                                  //     ),),
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,right: 22.0,top:80),
                    child: Container(
                      child:Image.asset('assets/image/group_2974.png'),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      _BookingDetails!.bookStatus.toString() == "8" && _BookingDetails!.isRate == false
                          ? Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 0.0,top: 60.0),
                        child: SizedBox(
                          width:100,
                          height: 40,
                          child: TextButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegularRateMechanicScreen(
                                        bookingId: widget.bookingId,
                                        firebaseCollection: widget.firebaseCollection,
                                      )));
                            }, child: Text('RATE',
                            style: TextStyle(
                              fontFamily: 'SamsungSharpSans-Medium',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              primary: CustColors.light_navy,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      )
                          : Container(),

                      _BookingDetails!.reqType == 2 ?
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0,right: 12.0,top: 60.0),
                        child: SizedBox(
                          width:100,
                          height: 40,
                          child: TextButton(
                            onPressed: () async {
                              if(_BookingDetails!.regularType.toString() == "1"){   //pick up and drop off
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustPickUpTrackScreen(
                                        bookingId: _BookingDetails!.id.toString(),
                                        bookingDate: bookingDate,
                                      ),
                                    ));
                              }else if(_BookingDetails!.regularType.toString() == "2"){       //mobile Mechanic
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustMobileTrackScreen(
                                        bookingId: _BookingDetails!.id.toString(),
                                        bookingDate: bookingDate,
                                      ),
                                    ));
                              }
                              else if(_BookingDetails!.regularType.toString() == "3"){       //mobile Mechanic
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustTakeVehicleTrackScreen(
                                        //reachTime: '${_BookingDetails!.bookedTime}',
                                        bookedDate: bookingDate,
                                        latitude: '${_BookingDetails!.latitude}',
                                        longitude: '${_BookingDetails!.longitude}',
                                        goTime: '${_BookingDetails!.bookedTime}',
                                        bookedId: '${_BookingDetails!.id.toString()}',
                                        //mechanicAddress: "${_BookingDetails!.mechanic!.firstName.toString()}",
                                        //mechanicName: "${_BookingDetails!.mechanic!.firstName.toString()}",
                                        //pickingDate: 'Mar 8,2022',
                                      ),
                                    ));
                              }
                            }, child: Text('TRACK',
                            style: TextStyle(
                              fontFamily: 'SamsungSharpSans-Medium',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              primary: CustColors.light_navy,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      )
                          :
                      Container(),
                    ],
                  ),

                  //SizedBox(height: 50)
              ],
          ),
        ),
      ),
    );
  }


  Widget listViewItems(MechanicService mechanicService){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 3.0,bottom: 3.0),
          child: Row(
            children: [
              Expanded(
                flex:290,
                child: Row(
                  children:[
                    Container(
                      height: 30,
                      child: Row(
                          children:[
                            Container(
                              width:140,
                              child: Padding(
                                padding: const EdgeInsets.only(left:08.0),
                                child: Text(
                                  mechanicService.service!.serviceName.toString(), //bookService!.service!.serviceName.toString(),    //'Steering',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'SamsungSharpSans-Regular',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex:120,
                child:  Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CustColors.light_navy,
                        width: 00,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children:[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                                height: 15,
                                width:15,
                                child: SvgPicture.asset('assets/image/ic_moneybag.svg')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 05.0),
                            child: Text('₦',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 05.0),
                            child: Text(
                              mechanicService.fee.toString(),   //bookService.service!.minPrice.toString(),  // '30',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white
                              ),),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}