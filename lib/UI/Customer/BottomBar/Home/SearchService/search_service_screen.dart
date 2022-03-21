import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/EmergencyFindMechanicList/find_mechanic_list_screen.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/SearchService/serviceSearchListAll_Mdl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Constants/cust_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import '../home_Bloc/home_customer_bloc.dart';

class SearchServiceScreen extends StatefulWidget {



  SearchServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _SearchServiceScreenState();
  }
}

class _SearchServiceScreenState extends State<SearchServiceScreen> {


  TextEditingController searchController = new TextEditingController();
  String? filter;
  String authToken="";


  bool isEmergencyService = true;
  bool isRegularService = false;


  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  List<String> serviceIds =[];


  String CurrentLatitude ="10.506402";
  String CurrentLongitude ="76.244164";

  String location ='Null, Press Button';
  String Address = 'search';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _getCurrentCustomerLocation();
    _listenServiceListResponse();

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData +SearchServiceScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
      _homeCustomerBloc.postSearchServiceRequest("$authToken", "s","","");
    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.postSearchServiceResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("sucess postServiceList >>>>>>>  ${value.status}");

        });
      }
    });
  }



  Future<void> _getCurrentCustomerLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {
      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();
    });
    print(location);
    GetAddressFromLatLong(position);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomUi(size),
                searchYouService(),
                emergencyService(),
                SizedBox(
                  height: 10,
                ),
                regularService(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Search Services',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue,
        ),
        Spacer(),
      ],
    );
  }

  Widget searchYouService() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 35,
              child:  TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search your Services',
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  prefixIcon:  Icon(Icons.search_rounded, color: CustColors.light_navy),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(11.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(11.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(11.0)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(11.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(11.0)),

                ),
                onChanged: (text) {

                  if (text != null && text.isNotEmpty && text != "" ) {
                    setState(() {
                      print('First text field: $text');
                      _homeCustomerBloc.postSearchServiceRequest("$authToken", "${searchController.text}","","");
                    });
                  }

                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emergencyService() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,20,0),
      child: Container(
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        child: Column(
          children: [

            Container(
                  child: StreamBuilder(
                      stream:  _homeCustomerBloc.postSearchServiceResponse,
                      builder: (context, AsyncSnapshot<ServiceSearchListAllMdl> snapshot) {
                        print("${snapshot.hasData}");
                        print("${snapshot.connectionState}");
                        if(snapshot.hasData)
                        {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10,5,10,5),
                                child: Container(
                                  height: 35.0,
                                  margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Emergency Services',
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          style: Styles.textLabelTitle_Regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data?.data?.serviceListAll?.length,
                                itemBuilder: (context, index) {
                                  return  GestureDetector(
                                    onTap:(){

                                      setState(() {
                                        print(">>>>>>>>>> Latitude  $CurrentLatitude");
                                        print(">>>>>>>>>> Longitude  $CurrentLongitude");
                                        print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                                        print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
                                        serviceIds.clear();
                                        serviceIds.add('${snapshot.data?.data?.serviceListAll?[index].id}');
                                        print(">>>>>>>>>> ServiceId  $serviceIds");

                                        _homeCustomerBloc.postMechanicsBookingIDRequest(
                                            authToken,
                                            '${_homeCustomerBloc.dateConvert(DateTime.now())}',
                                            '${_homeCustomerBloc.timeConvert(DateTime.now())}',
                                            CurrentLatitude,
                                            CurrentLongitude,
                                            serviceIds);
                                      });

                                    },
                                    child: snapshot.data?.data?.serviceListAll?[index].type =='1' && snapshot.data?.data?.serviceListAll?[index].type != null
                                    ? Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                        child: Column(
                                          mainAxisAlignment:MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(30,2,30,2),
                                              child: Text('${snapshot.data?.data?.serviceListAll![index].serviceName}',
                                                style: Styles.textLabelTitleEmergencyServiceName,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    )
                                    : Container(),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        else{
                          return  Container();
                        }

                      }
                  ),
                )
          ],
        ),
      ),
    );
  }

  Widget regularService() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,20,0),
      child: Container(
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        child: Column(
          children: [

            Container(
              child: StreamBuilder(
                  stream:  _homeCustomerBloc.postSearchServiceResponse,
                  builder: (context, AsyncSnapshot<ServiceSearchListAllMdl> snapshot) {
                    print("${snapshot.hasData}");
                    print("${snapshot.connectionState}");
                    if(snapshot.hasData)
                    {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,5,10,5),
                            child: Container(
                              height: 35.0,
                              margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Regular Services',
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.visible,
                                      style: Styles.textLabelTitle_Regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data?.data?.serviceListAll?.length,
                            itemBuilder: (context, index) {
                              return  GestureDetector(
                                onTap:(){

                                  setState(() {
                                    print(">>>>>>>>>> Latitude  $CurrentLatitude");
                                    print(">>>>>>>>>> Longitude  $CurrentLongitude");
                                    print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                                    print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
                                    serviceIds.clear();
                                    serviceIds.add('${snapshot.data?.data?.serviceListAll?[index].id}');
                                    print(">>>>>>>>>> ServiceId  $serviceIds");

                                    _homeCustomerBloc.postMechanicsBookingIDRequest(
                                        authToken,
                                        '${_homeCustomerBloc.dateConvert(DateTime.now())}',
                                        '${_homeCustomerBloc.timeConvert(DateTime.now())}',
                                        CurrentLatitude,
                                        CurrentLongitude,
                                        serviceIds);
                                  });

                                },
                                child: snapshot.data?.data?.serviceListAll?[index].type =='2' && snapshot.data?.data?.serviceListAll?[index].type != null
                                    ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(30,2,30,2),
                                          child: Text('${snapshot.data?.data?.serviceListAll![index].serviceName}',
                                            style: Styles.textLabelTitleEmergencyServiceName,
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                )
                                    : Container(),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    else{
                      return  Container();
                    }

                  }
              ),
            )
          ],
        ),
      ),
    );
  }


}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}



class MyBehavior extends ScrollBehavior {


  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
