import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class FindMechanicListScreen extends StatefulWidget {


  FindMechanicListScreen( );

  @override
  State<StatefulWidget> createState() {
    return _FindMechanicListScreenState();
  }
}

class _FindMechanicListScreenState extends State<FindMechanicListScreen> {
   //Completer<GoogleMapController> _controller = Completer();
   //var currentLocation = LocationData;
  late GoogleMapController mapController;
   final LatLng _initialPosition = LatLng(-15.4630239974464, 28.363397732282127);

   void _onMapCreated(GoogleMapController controller){
     mapController = controller;
   }
   @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SafeArea(

              child: Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height,
                      child:  Column(
                        children: [
                        Container(
                          height: size.height * 0.358,
                          color: CustColors.ocean_blue,
                          child: GoogleMap(
                            //sty
                            onMapCreated: _onMapCreated,
                            mapType: MapType.normal,
                            compassEnabled: true,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(-15.4630239974464, 28.363397732282127),
                              zoom: 12,
                            ),
                            //  onMapCreated:(GoogleMapController controller){
                            //     _controllerGoogleMap.complete(controller);
                            //     newGoogleMapController = controller;

                            //     setState(() {
                            //       bottomPaddingOfMap = 300.0;
                            //     });
                            //     locatePosition();

                            //  },

                          ),
                        ),
                        CurvedBottomSheetContainer(
                          percentage: 0.50,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: size.height * 2 / 100,
                                    left: size.width * 12.1 / 100,
                                    right: size.width * 12.1 / 100,
                                  ),
                                  color: CustColors.pale_grey,
                                  child: Column(
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

                                Align(
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

                                //mechanicList(size,"assets/image/mechanic_01.png","Eric","180  Reviews","8  Km","12 min","₦ 88 "),
                                //mechanicList(size,"assets/image/mechanic_02.png","Lucka","60  Reviews","18  Km","15 min","₦ 88 "),
                                //mechanicList(size,"assets/image/mechanic_03.png","George","130 Reviews","3  Km","4 min","₦ 88 "),
                                //mechanicList(size,"assets/image/mechanic_04.png","Nelson","15  Reviews","28  Km","20 min","₦ 88 "),

                              ],
                            ),
                          ),
                        ),
                      ],
                      ),
                    ),
                    /*Container(
                      color: Colors.green,
                    ),*/
                  ],
                ),
              ),
              ),
          ),
      ),
      ),
    );
  }

  Widget mechanicList(Size size, String mechanicImageUrl,String mechanicName, String reviewCount, String km, String time, String cost){

    /* return Container(
       color: Colors.tealAccent,
       child: Text("Sample text")
     );*/

     return ListView.builder(
     // itemCount:3,
      shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index,) {
        return GestureDetector(
          onTap:(){

          },
          child:Column(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              Padding(
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
                        Text("Test"),
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
                                          child:  Image.asset(mechanicImageUrl),
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
                                  child: Text(mechanicName,
                                    style: Styles.textLabelTitle12,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.asset("assets/image/ic_star_group.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(reviewCount,
                                    style: Styles.textLabelTitle12,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(km,
                                style: Styles.textLabelTitle12,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(time,
                                style: Styles.textLabelTitle12,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(cost,
                                style: Styles.textLabelTitle12,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible,),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
