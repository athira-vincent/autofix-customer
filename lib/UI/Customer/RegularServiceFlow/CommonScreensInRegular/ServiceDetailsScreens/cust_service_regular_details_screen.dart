import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/add_more_service_list_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Mechanic/mechanic_home_screen.dart';

class CustServiceRegularDetailsScreen extends StatefulWidget {


  final String bookingId;
  CustServiceRegularDetailsScreen({
    required this.bookingId
  });

  @override
  State<StatefulWidget> createState() {
    return _CustServiceRegularDetailsScreen();
  }
}

class _CustServiceRegularDetailsScreen extends State<CustServiceRegularDetailsScreen> {


  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> MechanicHomeScreen()
            ));
          },
          //onPressed: () => Navigator.pop(context),
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
              child: Column(
                children: [
                  Container(
                    color: CustColors.light_navy,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 02,
                        itemBuilder: (BuildContext context, int index){
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex:290,
                                      child: Row(
                                        children:[
                                           Container(
                                              height: 30,
                                              //color: Colors.yellow,
                                              child: Row(
                                                  children:[
                                                    Container(

                                                      width:140,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:08.0),
                                                        child: Text(
                                                          //_mechanicDetails!.mechanicService![index].service!.serviceName,
                                                          //_AddPriceServiceList!.data![index].serviceName.toString(),
                                                          'Steering',
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
                                                  child: Text('30',
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
                                    Expanded(
                                      flex:110,
                                      child: Container(
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
                                                      child: Image.asset('assets/image/ic_clock.png')),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 04.0),
                                                  child: Text('30',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white
                                                    ),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 3.0),
                                                  child: Text('Min',
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
                              //),
                            ],
                          );
                        }),
                  ),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          ),
                        color: CustColors.light_navy,
                      ),
                      child: Column(
                        children:[
                          Container(
                          height: 130,
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
                                      child: Text('Total estimated time',
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
                                          padding: const EdgeInsets.only(left: 20.0,top: 15),
                                          child:  Container(
                                              height: 20,
                                              width: 20,
                                              child: Image.asset('assets/image/ic_clock.png')),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                          child: Text('30',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white
                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                          child: Text('Min',
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
                                              child: Text('30',
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
                              color: Colors.white,
                            ),
                          ),
                          Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(10),
                          //     topRight: Radius.circular(20),
                          //     bottomLeft:Radius.circular(80),
                          //     bottomRight:Radius.circular(80)
                          // ),
                          //   ),
                            height: 100,
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
                                            child: Text('VEHICLE PICKING DATE',
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
                                                padding: const EdgeInsets.only(top: 15),
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
                                                child: Text('Mar 5,',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white
                                                  ),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                child: Text('2022',
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
                                            child: Text('VEHICLE PICKING TIME',
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
                                                padding: const EdgeInsets.only(top: 15),
                                                child:  Container(
                                                    height: 20,
                                                    width:20,
                                                    child: Image.asset('assets/image/ic_clock.png')),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                child: Text('Mar 5,',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white
                                                  ),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 05.0,top: 15.0),
                                                child: Text('2022',
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
                      ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,right: 22.0,top:80),
                    child: Container(
                    child:Image.asset('assets/image/group_2974.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 280.0,right: 22.0,top: 60.0),
                    child: SizedBox(
                      width:100,
                      height: 40,
                      child: TextButton(
                        onPressed: () async {

                          }, child: Text('  TRACK  ',
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
                  ),
                  SizedBox(height: 95)
                ],
              ),
            ),
        ),
      );
  }


}