import 'dart:typed_data';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicProfileView/mechanic_profile_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/MechanicList/RegularMechanicProfileView/regular_mechanic_profile_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart' as category;



class MechanicListScreen extends StatefulWidget {

  final String serviceIds;
  final String serviceDate;
  final String serviceTime;
  final String regularServiceType;
  final List<category.Service>? selectedService;
  //final String serviceType;
  final String latitude;
  final String longitude;
  final String address;

  MechanicListScreen({
    required this.serviceIds,
    //required this.serviceType,
    required this.latitude,
    required this.selectedService,
    required this.serviceDate,
    required this.serviceTime,
    required this.regularServiceType,
    required this.longitude,
    required this.address,

  });


  @override
  State<StatefulWidget> createState() {
    return _MechanicListScreenState();
  }
}

class _MechanicListScreenState extends State<MechanicListScreen> {


  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  GoogleMapController? mapController;

  String googleAPiKey = "AIzaSyA1s82Y0AiWYbzXwfppyvKLNzFL-u7mArg";
  String? _mapStyle;
  Set<Marker> markers = Set();
  BitmapDescriptor? customerIcon;
  CameraPosition? _kGooglePlex = CameraPosition(
    target: LatLng(37.778259000,
      -122.391386000,),
    zoom: 25,
  );

  String waitingMechanic="1";

  String authToken = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenServiceListResponse();

    mapStyling();
    customerMarker (LatLng(double.parse(widget.latitude.toString()), double.parse(widget.longitude.toString())));
    getGoogleMapCameraPosition(LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString())));
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
          "regular");
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height:  MediaQuery.of(context).size.height * .50,
                    child: GoogleMap( //Map widget from google_maps_flutter package
                      zoomGesturesEnabled: true, //enable Zoom in, out on map
                      initialCameraPosition: _kGooglePlex!,
                      markers: markers,
                      mapType: MapType.normal, //map type
                      onMapCreated: (controller) { //method called when map is created
                        setState(() {
                          controller.setMapStyle(_mapStyle);
                          mapController = controller;
                        });
                      },
                    ),
                  ),
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
                                                                  builder: (context) =>  RegularMechanicProfileViewScreen(
                                                                    mechanicId: "${snapshot.data?.data?.mechanicList?.data![index].id.toString()}",
                                                                    authToken: '$authToken',
                                                                    customerAddress: "${widget.address}",
                                                                    mechanicListData: snapshot.data?.data?.mechanicList?.data![index],
                                                                    isEmergency: true,
                                                                    //serviceModel: "",
                                                                    serviceIds: widget.serviceIds,
                                                                    longitude: widget.longitude,
                                                                    latitude: widget.latitude,
                                                                    //serviceType : widget.serviceType,
                                                                    serviceDate : widget.serviceDate,
                                                                    serviceTime : widget.serviceTime,
                                                                    regularServiceType : widget.regularServiceType,
                                                                    selectedService: widget.selectedService!,
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
                                                                                    child:
                                                                                      snapshot.data?.data?.mechanicList?.data?[index].mechanic[0].profilePic != null
                                                                                          && snapshot.data?.data?.mechanicList?.data?[index].mechanic[0].profilePic != ""
                                                                                          ?
                                                                                      Image.network(
                                                                                        '${snapshot.data?.data?.mechanicList?.data?[index].mechanic[0].profilePic.toString()}',
                                                                                        width: 150,
                                                                                        height: 150,
                                                                                        fit: BoxFit.cover,
                                                                                      )
                                                                                          :
                                                                                      SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
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
                                                                                    updateOnDrag: false,
                                                                                    ignoreGestures: true,
                                                                                    initialRating: double.parse('${snapshot.data?.data?.mechanicList?.data?[index].mechanicReview}'),
                                                                                    //initialRating: 3.075,
                                                                                    //minRating: 1,
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

  Widget titleWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Row(
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
                  waitingMechanic=="0" ? "Mechanic not found" : "Mechanic found",
                  textAlign: TextAlign.start,
                  style: Styles.waitingTextBlack17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mechanicNotFountWidget(Size size) {
    return Expanded(
      child: Container(
        //color: Colors.lightGreen,
        margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 8 / 100,
          bottom: size.height * 3.5 / 100
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: SvgPicture.asset(
                  'assets/image/img_oops_mechanic_bg.svg',
                  height: size.height * 27 / 100,
                  fit: BoxFit.cover,
                ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * 1 / 100,
                  right: size.width * 1 / 100,
                  top: size.height * 7 / 100
                ),
                height: size.height * 18 / 100,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: CustColors.pale_grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Oops!! Mechanic not found!",
                      style: Styles.oopsmechanicNotFoundStyle01,
                    ),
                    Text("No mechanic in your region",
                      style: Styles.smallTitleStyle3,
                    ),
                    Text("Try after sometime!",
                      style: Styles.TryAfterSomeTimetyle01,
                    ),
                  ],
                ),
              ),
            ),
            tryAgainButtonWidget(size),
          ],
        ),
      ),
    );
  }

  Widget mechanicListWidget(Size size){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: StreamBuilder(
                stream:  _homeCustomerBloc.findMechanicsListEmergencyResponse,
                builder: (context, AsyncSnapshot<MechanicListMdl> snapshot) {
                  print("${snapshot.hasData}");
                  print("${snapshot.connectionState}");
                  switch (snapshot.connectionState) {
                  /*case ConnectionState.waiting: return progressBarLightRose();*/
                    default:
                      return
                        //snapshot.data?.data?.mechaniclistForServices?.length != 0 && snapshot.data?.data?.mechaniclistForServices?.length != null
                        snapshot.data?.data?.mechanicList?.data?.length != 0 && snapshot.data?.data?.mechanicList?.data?.length != null
                            ? ListView.builder(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              //itemCount:snapshot.data?.data?.mechaniclistForServices?.length,
                              itemCount:snapshot.data?.data?.mechanicList?.data?.length,
                              itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  RegularMechanicProfileViewScreen(
                                            authToken: '$authToken',
                                            isEmergency: false,
                                            customerAddress: "",
                                            mechanicListData: snapshot.data?.data?.mechanicList?.data![index],
                                            mechanicId: "${snapshot.data?.data?.mechanicList?.data![index].id.toString()}",
                                            //serviceModel: 'widget.serviceModel',
                                            serviceIds: widget.serviceIds,
                                            longitude: widget.longitude,
                                            latitude: widget.latitude,
                                            //serviceType : widget.serviceType,
                                            serviceDate : widget.serviceDate,
                                            serviceTime : widget.serviceTime,
                                            regularServiceType : widget.regularServiceType,
                                            selectedService: widget.selectedService!,
                                          )));

                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10,6,10,0),
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
                                              width: 75.0,
                                              height: 75.0,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  child:Container(
                                                      child:CircleAvatar(
                                                          radius: 45,
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
                                                    child: Text('${snapshot.data?.data?.mechanicList?.data![index].firstName}',
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
                                                            initialRating: 3.5,
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
                                                          child: Text('1280 Reviews',
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
                                                        child: Text('120 km',
                                                          style: Styles.smallTitleStyle1,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: Text('12 min',
                                                          style: Styles.smallTitleStyle1,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,3,0,3),
                                                        child: Text('₦ 1245',
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
                            : mechanicNotFountWidget(size);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget tryAgainButtonWidget(Size size){
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
            //right: size.width * 6.2 / 100,
            top: size.height * 22 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Try again",
          style: TextStyle(
            fontSize: 14.3,
            fontWeight: FontWeight.w600,
            fontFamily: "Samsung_SharpSans_Medium",
            color: Colors.white,
          ),
        ),
      ),
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

}