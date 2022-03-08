import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindMechanicScreen extends StatefulWidget {


  FindMechanicScreen( );

  @override
  State<StatefulWidget> createState() {
    return _FindMechanicScreenState();
  }
}

class _FindMechanicScreenState extends State<FindMechanicScreen> {
   //Completer<GoogleMapController> _controller = Completer();
   //var currentLocation = LocationData;
   static LatLng _initialPosition = LatLng(-15.4630239974464, 28.363397732282127);
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
                          //color: CustColors.ocean_blue,
                          child: GoogleMap(
                            //sty
                            mapType: MapType.normal,
                            compassEnabled: true,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(-15.4630239974464, 28.363397732282127),
                              zoom: 10,
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
                          percentage: 0.90,
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.amber,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    //bottom: size.height * ,
                                    left: size.width * 0.121,
                                    right: size.width * 0.121
                                ),
                                color: CustColors.pale_grey,
                              ),

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
}
