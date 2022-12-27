import 'dart:core';
import 'dart:core';

import 'package:auto_fix/Common/TokenChecking/JWTTokenChecking.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicList/EmergencyFindMechanicList/find_mechanic_list_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/AddRegularMoreServices/add_more_regular_service_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  //List<Service>?
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  String serviceIds = "";
  bool _isLoading = false;
  double per = .10;

  double _setValue(double value) {
    return value * per + value;
  }

  String addressLocationText = "";
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
      JWTTokenChecking.checking(shdPre.getString(SharedPrefKeys.token).toString(), context);
      print('userFamilyId'+authToken.toString());
      _homeCustomerBloc.postSearchServiceRequest("$authToken", null, null,null,null);
      _homeCustomerBloc.postRegularServiceListRequest("$authToken", "2", null, null);
      // _serviceListBloc.postServiceListRequest(authToken, "", null, "2" );
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
    _homeCustomerBloc.regularServiceListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");

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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

  }

  Future<void> GetAddressString(LatLng position) async {

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];

    String addressLocation = '${place.street}, ${place.subLocality}, ${place.locality}';

    setState(() {
      addressLocationText = addressLocation;
      print("addressLocationText >>>>>>> " + addressLocationText);
    });
    //return addressLocation;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              appBarCustomUi(size),
              searchYouService(),
              emergencyService(size),
              SizedBox(
                height: 10,
              ),
              regularService(),
            ],
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
                //autofocus: true,
                cursorColor: CustColors.light_navy,
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
                      _homeCustomerBloc.postSearchServiceRequest("$authToken", "${searchController.text}", null, null,null);
                      _homeCustomerBloc.postRegularServiceListRequest("$authToken", "2", null, "${searchController.text}");
                    });
                  }else{
                    _homeCustomerBloc.postSearchServiceRequest("$authToken", null, null,null,null);
                    _homeCustomerBloc.postRegularServiceListRequest("$authToken", "2", null, null);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emergencyService(Size size) {
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

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  CustColors.light_navy),
                            );
                          default:
                            return
                              snapshot.data?.data?.serviceListAll?.length != 0 && snapshot.data?.data?.serviceListAll?.length != null
                                  ? Column(
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
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data?.data?.serviceListAll?.length,
                                          itemBuilder: (context, index) {
                                            return  GestureDetector(
                                              onTap:(){

                                                setState(() {

                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          contentPadding: EdgeInsets.all(0.0),
                                                          content: StatefulBuilder(
                                                              builder: (BuildContext context, StateSetter monthYear) {
                                                                return  setupAlertDialogMonthAndYear(
                                                                    snapshot.data?.data?.serviceListAll![index],
                                                                    size
                                                                );
                                                              }
                                                          ),
                                                        );
                                                      });
                                                });

                                              },
                                              child: snapshot.data?.data?.serviceListAll?[index].category![0].catType.toString() =='1' && snapshot.data?.data?.serviceListAll?[index].category![0].catType != null
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
                                    )
                                  : Container();
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
                  stream: _homeCustomerBloc.regularServiceListResponse,
                  builder: (context, AsyncSnapshot<CategoryListHomeMdl> snapshot) {
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
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:snapshot.data?.data?.categoryList?.length,
                            itemBuilder: (context, index) {
                              return  GestureDetector(
                                onTap:() async {
                                  SharedPreferences shdPre = await SharedPreferences.getInstance();

                                      print(">>>>>>>>>> Latitude  ${shdPre.getString(SharedPrefKeys.preferredLatitude,)}");
                                      print(">>>>>>>>>> Longitude  ${shdPre.getString(SharedPrefKeys.preferredLongitude,)}");
                                      print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                                      print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");

                                      serviceIds = '${snapshot.data?.data?.categoryList![index].id}';
                                      print(">>>>>>>>>> ServiceId  $serviceIds");
                                      if(shdPre.getString(SharedPrefKeys.preferredLatitude,).toString() != "null"
                                          && shdPre.getString(SharedPrefKeys.preferredLatitude,).toString() != ""){
                                        GetAddressString(LatLng(
                                            double.parse(shdPre.getString(SharedPrefKeys.preferredLatitude,).toString()),
                                            double.parse(shdPre.getString(SharedPrefKeys.preferredLongitude,).toString())));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  AddMoreRegularServicesListScreen(
                                                  categoryList: snapshot.data?.data?.categoryList![index],
                                                  isAddService: true,
                                                  isReturnData: false,
                                                  latitude: shdPre.getString(SharedPrefKeys.preferredLatitude,).toString(),
                                                  longitude: shdPre.getString(SharedPrefKeys.preferredLongitude,).toString(),
                                                  address: addressLocationText,
                                                  isFromScheduleServicePage: false,
                                                )));

                                      }else{
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  AddMoreRegularServicesListScreen(
                                                  categoryList: snapshot.data?.data?.categoryList![index],
                                                  isAddService: true,
                                                  isReturnData: false,
                                                  latitude: CurrentLatitude,
                                                  longitude: CurrentLongitude,
                                                  address: Address,
                                                  isFromScheduleServicePage: false,
                                                )));
                                      }




                                },
                                child: snapshot.data?.data?.categoryList?.length != 0 && snapshot.data?.data?.categoryList?.length != null
                                    ? Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                            child: Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(30,2,30,2),
                                                  child: Text('${snapshot.data?.data?.categoryList![index].catName}',
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

  Widget setupAlertDialogMonthAndYear(ServiceListAll? service, Size size ) {
    return Container(
      height: 335.0, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.light_navy,
              alignment: Alignment.center,
              child: Text(service!.serviceName,
                style: Styles.textButtonLabelSubTitle,)
          ),
          Container(
            padding: EdgeInsets.only(
                top: size.height * 2.5 / 100,
                bottom: size.height * 2.5 / 100,
                left: size.width * 4 / 100,
                right: size.width * 4 / 100
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * 1.5 / 100,
                      bottom: size.height * 1.5 / 100,
                      left: size.width * 2 / 100,
                      right: size.width * 2 / 100
                  ),
                  decoration: Styles.serviceIconBoxDecorationStyle,
                  child: //service.icon.toString().length != 0 ?
                  Image.network(service.icon,
                    width: 35,
                    //height: 150,
                    fit: BoxFit.cover,)
                      /*:
                  Icon(choices[0].icon,size: 35,color: CustColors.light_navy,),*/
                ),
                SizedBox(
                  width: size.width * 8 / 100,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Estimated cost",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Samsung_SharpSans_Medium",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7
                        ),
                      ),
                      Text("₦ "+ service.minPrice,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontFamily: "SharpSans_Bold",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          InfoTextWidget(size),

          Container(
            margin: EdgeInsets.only(
              //left: size.width * 4 / 100,
              //right: size.width * 4 / 100,
                top: size.height * 1.5 / 100
            ),
            child: _isLoading
                ? Center(
                  child: Container(
                    height: _setValue(28),
                    width: _setValue(28),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CustColors.light_navy),
                    ),
                  ),
              )
                : MaterialButton(
                  onPressed: () {

                        Navigator.pop(context);
                        /*setState(() {
                          _lastMaintenanceController.text = '$selectedMonthText  $selectedYearText';
                          if (_formKey.currentState!.validate()) {
                          } else {
                          }
                        });*/
                      print(">>>>>>>>>> Latitude  $CurrentLatitude");
                      print(">>>>>>>>>> Longitude  $CurrentLongitude");
                      print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                      print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
                      serviceIds = '${service.category![0].id}';
                      print(">>>>>>>>>> ServiceId  $serviceIds");


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  FindMechanicListScreen(
                                  serviceIds: serviceIds,
                                  serviceType: 'emergency',
                                  customerAddress: "",
                                  latitude: CurrentLatitude,
                                  longitude: CurrentLongitude,
                                  authToken: authToken,)));

                  },
                   child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: size.width * 2.5 / 100,
                        right: size.width * 2.5 / 100,
                        top: size.height * 1 / 100,
                        bottom: size.height * 1 / 100
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        color: CustColors.light_navy
                    ),
                    child: Text(
                      'Find available mechanics ',
                      textAlign: TextAlign.center,
                      style: Styles.textButtonLabelSubTitle,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget InfoTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * .2 / 100
      ),
      padding: EdgeInsets.only(
        top: size.height * 1 / 100,
        bottom: size.height * 1 / 100,
        right: size.width * 2.3 / 100,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: size.width * 2 / 100,
              right: size.width * 2.5 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 2.5 / 100,width: size.width * 2.5 / 100,),
          ),
          Expanded(
            child: Text(
              "This cost may change for different mechanics due to change in Service charge or due to distance from your location",
              textAlign: TextAlign.justify,
              style: warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  TextStyle warningTextStyle01 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w400,
      color: Colors.black,
      letterSpacing: .7,
      wordSpacing: .7
  );

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
