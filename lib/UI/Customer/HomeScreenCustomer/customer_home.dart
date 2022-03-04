import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Constants/cust_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  String location ='Null, Press Button';
  String Address = 'search';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentCustomerLocation();

  }

  Future<void> _getCurrentCustomerLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                searchYouService(),
                serviceBanners(),
                emergencyService(),
                regularService(),
                upcomingServices(),
                sparePartsServices()

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchYouService() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex:1,
            child: SizedBox(
              height: 35,
              child: new TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search your Services',
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  prefixIcon:  Icon(Icons.search_rounded, color: CustColors.light_navy),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),

                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
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
          padding: const EdgeInsets.fromLTRB(20,5,20,5),
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
          child: GridView.builder(
            itemCount:choices.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .94,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context,index,) {
              return GestureDetector(
                onTap:(){

                },
                child:Container(

                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: CustColors.whiteBlueish,
                            borderRadius: BorderRadius.circular(11.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Icon(choices[index].icon,size: 40,color: CustColors.light_navy,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(choices[index].title,
                            style: Styles.textLabelTitle12,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,),
                      ),
                    ],
                  ),
                ),
              );
            },
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
          padding: const EdgeInsets.fromLTRB(20,5,20,5),
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
          child: GridView.builder(
            itemCount:choices.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .94,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context,index,) {
              return GestureDetector(
                onTap:(){

                },
                child:Container(

                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: CustColors.whiteBlueish,
                            borderRadius: BorderRadius.circular(11.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Icon(choices[index].icon,size: 40,color: CustColors.light_navy,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(choices[index].title,
                          style: Styles.textLabelTitle12,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
            : Container()
      ],
    );
  }

  Widget upcomingServices() {
    return Padding(
      padding: const EdgeInsets.all(20),
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
