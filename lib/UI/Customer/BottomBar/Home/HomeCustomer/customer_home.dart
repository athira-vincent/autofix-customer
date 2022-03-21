import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/EmergencyFindMechanicList/find_mechanic_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Constants/cust_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../Mechanic/BottomBar/Home/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import '../../../../WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import '../SearchService/search_service_screen.dart';
import '../home_Bloc/home_customer_bloc.dart';

class HomeCustomerUIScreen extends StatefulWidget {



  HomeCustomerUIScreen();

  @override
  State<StatefulWidget> createState() {
    return _HomeCustomerUIScreenState();
  }
}

class _HomeCustomerUIScreenState extends State<HomeCustomerUIScreen> {


  TextEditingController searchController = new TextEditingController();
  String? filter;
  String authToken="";


  final List<String> imageList = [
    "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  bool isEmergencyService = true;
  bool isRegularService = false;

   List<Choice> choices = const <Choice>[
    const Choice(title: 'Home', icon: Icons.home),
    const Choice(title: 'relay of urgent mechanic', icon: Icons.contacts),
    const Choice(title: 'Map', icon: Icons.map),
    const Choice(title: 'Phone', icon: Icons.phone),
    const Choice(title: 'Camera', icon: Icons.camera_alt),
    const Choice(title: 'Setting', icon: Icons.settings),
    const Choice(title: 'Album', icon: Icons.photo_album),
    const Choice(title: 'WiFi', icon: Icons.wifi),
  ];

   String CurrentLatitude ="10.506402";
   String CurrentLongitude ="76.244164";

  String location ='Null, Press Button';
  String Address = 'search';

  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  List<String> serviceIds =[];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _getCurrentCustomerLocation();
    _listenServiceListResponse();

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
      _homeCustomerBloc.postEmergencyServiceListRequest("$authToken", "1");
      _homeCustomerBloc.postRegularServiceListRequest("$authToken", "2");

    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.emergencyServiceListResponse.listen((value) {
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
    _homeCustomerBloc.mechanicsBookingIDResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print(" postServiceList >>>>>>>  ${value.status}");
          print(" authToken >>>>>>>  $authToken");
          print(" serviceIds >>>>>>>  $serviceIds");
          print(" serviceType >>>>>>>  emergency");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  FindMechanicListScreen(
                    bookingId: '${value.data?.mechanicsBooking?.id}',
                  serviceIds: serviceIds,
                  serviceType: 'emergency',
                  authToken: authToken,)));

        });
      }
    });
    _homeCustomerBloc.findMechanicsListEmergencyResponse.listen((value) {
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
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                searchYouService(context),
                serviceBanners(),
                emergencyService(),
                regularService(),
                upcomingServices(),
                sparePartsServices()

              ],
            ),
          ),
        ),
    );
  }

  Widget searchYouService(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex:1,
                child: InkWell(
                  onTap: () {

                      print("clicked");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  MechanicWorkCompletedScreen(authToken: "",mechanicId: "",)));


                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(width: 1,color: CustColors.light_navy)),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: CustColors.light_navy),
                        Text('Search your Services'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Icon(Icons.location_on_rounded, color: CustColors.light_navy,size: 35,),
                  SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        Text('Elenjikkal house Empyreal Garden',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.textLabelTitle_10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget serviceBanners() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
                color: CustColors.whiteBlueish,
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: Image.asset('assets/image/bannerPngDummy1.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: circleBar(true),
          ),
        ],
      ),
    );
  }

  Widget emergencyService() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: InkWell(
              onTap: (){
                setState(() {

                  if(isEmergencyService==true)
                    {
                      isEmergencyService=false;
                    }
                  else
                    {
                      isEmergencyService=true;
                    }
                });
              },
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
                  Spacer(),
                  Icon(isEmergencyService==true?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right, color: CustColors.light_navy,size: 30,),
                ],
              ),
            ),
          ),
        ),
        isEmergencyService==true
        ? Container(
          child: StreamBuilder(
              stream:  _homeCustomerBloc.emergencyServiceListResponse,
              builder: (context, AsyncSnapshot<ServiceListMdl> snapshot) {
                print("${snapshot.hasData}");
                print("${snapshot.connectionState}");
                if(snapshot.hasData)
                  {
                    return GridView.builder(
                      itemCount:snapshot.data?.data?.emeregencyOrRegularServiceList?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: .9,
                        crossAxisSpacing: .08,
                        mainAxisSpacing: .05,
                      ),
                      itemBuilder: (context,index,) {
                        return GestureDetector(
                          onTap:(){

                            setState(() {
                              print(">>>>>>>>>> Latitude  $CurrentLatitude");
                              print(">>>>>>>>>> Longitude  $CurrentLongitude");
                              print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                              print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
                              serviceIds.clear();
                              serviceIds.add('${snapshot.data?.data?.emeregencyOrRegularServiceList![index].id}');
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
                          child: Container(
                            child: Column(
                              mainAxisAlignment:MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: CustColors.whiteBlueish,
                                      borderRadius: BorderRadius.circular(11.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Icon(choices[0].icon,size: 35,color: CustColors.light_navy,),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text('${snapshot.data?.data?.emeregencyOrRegularServiceList![index].serviceName}',
                                    style: Styles.textLabelTitleEmergencyServiceName,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                else{
                  return CircularProgressIndicator();
                }

              }
              ),
        )
        : Container()
      ],
    );
  }

  Widget regularService() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: InkWell(
              onTap: (){
                setState(() {

                  if(isRegularService==true)
                  {
                    isRegularService=false;
                  }
                  else
                  {
                    isRegularService=true;
                  }
                });
              },
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
                  Spacer(),
                  Icon(isRegularService==true?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right, color: CustColors.light_navy,size: 30,),
                ],
              ),
            ),
          ),
        ),
        isRegularService==true
            ? Container(
                child: StreamBuilder(
                    stream:  _homeCustomerBloc.regularServiceListResponse,
                    builder: (context, AsyncSnapshot<ServiceListMdl> snapshot) {
                      print("${snapshot.hasData}");
                      print("${snapshot.connectionState}");
                      if(snapshot.hasData)
                      {
                        return GridView.builder(
                          itemCount:snapshot.data?.data?.emeregencyOrRegularServiceList?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: .9,
                            crossAxisSpacing: .05,
                            mainAxisSpacing: .05,
                          ),
                          itemBuilder: (context,index,) {
                            return GestureDetector(
                              onTap:(){

                              },
                              child:

                              Container(

                                child: Column(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: CustColors.whiteBlueish,
                                          borderRadius: BorderRadius.circular(11.0)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Icon(choices[0].icon,size: 35,color: CustColors.light_navy,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text('${snapshot.data?.data?.emeregencyOrRegularServiceList![index].serviceName}',
                                        style: Styles.textLabelTitleEmergencyServiceName,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    }
                ),
              )
            : Container()
      ],
    );
  }

  Widget upcomingServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,20,0,20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Upcoming Services',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.textLabelTitle_Regular,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              options: CarouselOptions(
                height: 200,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                aspectRatio: 5,
              ),
              itemBuilder: (context, i, id){
                //for onTap to redirect to another screen
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white,)
                      ),
                      //ClipRRect for image border radius
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          imageList[i],
                          width: 600,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: (){
                      var url = imageList[i];
                      print(url.toString());
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sparePartsServices() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Spareparts for your models ',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.serviceSelectionTitle01Style,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              options: CarouselOptions(
                height: 200,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                aspectRatio: 16/8,
                viewportFraction: 0.5
              ),
              itemBuilder: (context, i, id){
                //for onTap to redirect to another screen
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white,)
                      ),
                      //ClipRRect for image border radius
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          imageList[i],
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: (){
                      var url = imageList[i];
                      print(url.toString());
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 5 : 5,
      width: isActive ? 30 : 25,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : CustColors.whiteBlueish,
          borderRadius: BorderRadius.all(Radius.circular(12))),
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
