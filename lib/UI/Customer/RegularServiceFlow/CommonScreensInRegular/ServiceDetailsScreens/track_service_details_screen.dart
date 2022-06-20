import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';

class TrackServiceDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TrackServiceDetailsScreen();
  }

}
class _TrackServiceDetailsScreen extends State <TrackServiceDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomui(size),
                trackServiceBoxui(size),
                serviceBookedUi(size),
                vehicleStartedFromUi(size),
                vehicleReachedNearUi(size),
                pickedYourVehicleUi(size),
                reachedWorkShopUi(size),
                startedWorkUi(size),
                finishedWorkUi(size),
                returnFromUi(size),
                returnAndReachNearUi(size),
                textButtonUi(size),
              ],
            ),
          ),
        ),

      ),

    );
  }
  Widget appBarCustomui(Size size){
    return Container(
      margin: EdgeInsets.only(
         // left: size.width * 10 / 100,
          //top: size.height * 3.3 / 100
      ),
      child: Stack(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: const Color(0xff707070)),
                onPressed: () {  },
                //onPressed: () => Navigator.pop(context),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget trackServiceBoxui(Size size){
    return Padding(
      padding: const EdgeInsets.only(left: 22.0,right: 22.0),
      child: Container(
        //color: CustColors.light_navy,
        height: 83,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustColors.light_navy,
        ),
        // child: Container(
        //
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10)
        //   ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                    height: 50,
                    width:50,
                    child: Image.asset('assets/image/ic_clock.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('TRACK SERVICE',
                style: TextStyle(
                  fontFamily: 'SamsungSharpSans-Medium',
                  fontSize: 16,
                  //height: 30
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
      //),
    );
  }
  Widget serviceBookedUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustColors.light_navy,
                ),
                child: Container(
                    height: size.height * 3.3/100,
                    width: size.width * 5.5/100,
                    child: Image.asset('assets/image/ic_clock.png')),
              ),
      ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0,top: 30),
            child: Column(
              children: [
                Text('Service booked on',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SamsungSharpSans-Medium',
                ),),
                SizedBox(height: 05),
                Text('Mar 5,2022',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'SamsungSharpSans-Medium',
                  color: const Color(0xff9b9b9b)
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget vehicleStartedFromUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Savannah estate, plot 176',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget vehicleReachedNearUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget pickedYourVehicleUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget reachedWorkShopUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 23,
              width: 55,
              child: Padding(
                padding: const EdgeInsets.only(top: 00.0),
                child: TextButton(
                  onPressed: () {  },
                  child: Text('TRACK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff919191),
                      fontSize: 08,
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                        primary: const Color(0xffc9d6f2),
                        shape:
                        RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                ),
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget startedWorkUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget finishedWorkUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget returnFromUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget returnAndReachNearUi(Size size){
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 30),
            child: Stack(
              children:[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustColors.light_navy,
                  ),
                  child: Container(
                      height: size.height * 3.3/100,
                      width: size.width * 5.5/100,
                      child: Image.asset('assets/image/ic_clock.png')),
                ),
              ],
            ),
          ),
          Expanded(
            flex:200,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 30),
              child: Column(
                children: [
                  Text('Service booked on',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                  Text('Mar 5,2022',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: const Color(0xff9b9b9b)
                    ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
            child: Container(
              height: 20,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9d6f2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 05.0),
                child: Text('TRACK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff919191),
                    fontSize: 08,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
  Widget textButtonUi (Size size){
    return Container(
      child: Column(
        children:[
          Padding(
            padding: const EdgeInsets.only(left: 250.0,right: 22.0),
            child: Container(
              width: 130,
              child: TextButton(
              onPressed: () {  },
              child: Text('Back to home',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'SamsungSharpSans-Medium',
                color: Colors.white
              ),),
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
          ),
          SizedBox(height: 20)
    ]
      ),

    );
  }

}