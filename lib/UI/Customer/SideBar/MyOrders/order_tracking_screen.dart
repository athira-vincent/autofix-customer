import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class OrderTrackingScreen extends StatefulWidget {
  final OrderList modeldetails;
  const OrderTrackingScreen({Key? key, required this.modeldetails}) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {


  bool isLoading = true;
  String isProductState01 = "-1",
      isProductState02 = "-1",isProductState03 = "-1",
      isProductState04 = "-1",isProductStateOutOfDelivery = "-1",
      isProductStateDeliverToday = "-1",isProductStateReadyToDeliver = "-1",
      isProductStateDeliveryCompleted = "-1";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading == true
            ?
        Container(
            width: size.width,
            height: size.height,
            child: Center(child: CircularProgressIndicator(
                color: CustColors.materialBlue)))
            :
        Column(
          children: [
            appBarCustomerUi(size),
            productDetailsUI(size),

            Container(
              height: size.height - (size.height * 30 / 100),
              child: ListView(
                children: [
                  serviceBookedUi(size),
                  isProductState01 == "-1" ? orderState01InactiveUi(size) : orderState01CompletedUi(size),
                  isProductState02 == "-1" ? orderState02InactiveUi(size) : orderState02CompletedUi(size),
                  isProductState03 == "-1" ? orderState03InactiveUi(size) : orderState03CompletedUi(size),
                  isProductState04 == "-1" ? orderState04InactiveUi(size) : orderState04CompletedUi(size),
                  isProductStateOutOfDelivery == "-1" ? orderStateOutOfDeliveryInactiveUi(size) : orderStateOutOfDeliveryCompletedUi(size),
                  isProductStateDeliverToday == "-1" ? orderStateDeliverTodayInactiveUi(size) : orderStateDeliverTodayCompletedUi(size),
                  isProductStateReadyToDeliver == "-1" ? orderStateReadyToDeliverInactiveUi(size) : orderStateReadyToDeliverCompletedUi(size),
                  //isProductStateDeliveryCompleted == "-1" ? orderState04InactiveUi(size) : orderState04CompletedUi(size),

                  completedUi(size),

                  textButtonUi(size),
                  // completedUi(size),
                  //
                  // textButtonUi(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarCustomerUi(Size size) {
    return Row(
      children: [
        trackServiceBoxUi(size),
      ],
    );
  }

  Widget trackServiceBoxUi(Size size) {
    return Container(
      height: 70,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: CustColors.materialBlue,
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                // left: size.width * 10 / 100,
                  top: size.height * 2.5 / 100
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                            Icons.arrow_back, color: const Color(0xffffffff)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  // left: size.width * 10 / 100,
                    top: size.height * 2.5 / 100
                ),
                height: 45,
                width: 45,
                child: Image.asset('assets/image/ic_clock.png')),
          ],
        ),
        title: Container(
          margin: EdgeInsets.only(
            // left: size.width * 10 / 100,
              top: size.height * 2.5 / 100
          ),
          child: Text('TRACK MY ORDER',
            style: TextStyle(
              fontFamily: 'SamsungSharpSans-Medium',
              fontSize: 16,
              //height: 30
              color: Colors.white,
            ),),
        ),
      ),
    );
  }

  Widget serviceBookedUi(Size size) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.materialBlue,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: SvgPicture.asset('assets/image/ic_calender.svg',
                        fit: BoxFit.contain,
                        color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Placed ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SamsungSharpSans-Medium',
                      ),),
                    SizedBox(height: 05),
                    // Text(
                    //   //_mechanicHomeBloc.dateMonthConverter(DateFormat("yyyy-MM-dd").parse(bookingDate)),
                    //   "Date",
                    //   //bookingDate.toString(),
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       fontSize: 12,
                    //       fontFamily: 'SamsungSharpSans-Medium',
                    //       color: const Color(0xff9b9b9b)
                    //   ),)
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45, 3, 5, 0),
            child: FDottedLine(
              color: CustColors.blue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget productDetailsUI(Size size) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60,
                      width: 90,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            '${widget.modeldetails.product.productImage}',
                            fit: BoxFit.cover,
                          )

                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 8, 0, 10),
                            child: Text(
                              widget.modeldetails
                                  .product
                                  .productName,
                              style:
                              Styles.sparePartNameSubTextBlack,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 5, 0, 5),
                            child: Text(
                              widget.modeldetails
                                  .product.productCode,
                              style: Styles.sparePartNameSubTextBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              const Divider(
                color: CustColors.greyText1,
              )
            ],
          ),
        )
    );
  }

  Widget orderState01CompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/images/TrackServiceIcons/ic_product_order_packed_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Packed',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState01InactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_order_packed_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Packed',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState02CompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_order_shiped_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Shipped',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),

                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState02InactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_order_shiped_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Shipped',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState03CompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_shipment_near_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Near Your Location ',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),

                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState03InactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_shipment_near_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order near your Location',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState04CompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_shipment_near_hub_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order near your hub',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),

                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderState04InactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_shipment_near_hub_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order near your hub',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateOutOfDeliveryCompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_out_for_delivery_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Out for Delivery',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateOutOfDeliveryInactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_out_for_delivery_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Out for delivery',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateDeliverTodayCompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_arriving_today_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Arriving Today',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),

                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateDeliverTodayInactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_arriving_today_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Arriving Today',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateReadyToDeliverCompletedUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.materialBlue,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_agent_near_white.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ready to Deliver',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text(
                      //   'Date',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),

                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 80.0,right: 22.0,top: 05),
                child: Container(
                  height: 23,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9d6f2)
                  ),
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
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.materialBlue,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStateReadyToDeliverInactiveUi(Size size){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,top: 00),
                    child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: CustColors.addresstilecolor,
                              borderRadius: BorderRadius.circular(25)
                            //more than 50% of width makes circle
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/image/TrackServiceIcons/ic_product_agent_near_blue.png',
                            fit: BoxFit.contain,
                            //color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: child)
                ],
              ),
              Expanded(
                flex: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Ready to deliver near you',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      //SizedBox(height: 02),
                      // Text('$customerAddress',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),),
                      // SizedBox(height: 02),
                      // Text(
                      //   'on ' + _mechanicHomeBloc.dateMonthConverter(new DateFormat("yyyy-MM-dd").parse(scheduledDate)),
                      //   //'Mar 5,2022',
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontFamily: 'SamsungSharpSans-Medium',
                      //       color: const Color(0xff9b9b9b)
                      //   ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(45,0,5,5),
            child: FDottedLine(
              color: CustColors.light_navy05,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget completedUi(Size size){
    return Container(
      child: isProductStateDeliveryCompleted == '-1'
          ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0,top: 00),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Container(
                      height:50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: CustColors.addresstilecolor,
                          borderRadius: BorderRadius.circular(25)
                        //more than 50% of width makes circle
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: Image.asset('assets/image/TrackServiceIcons/ic_product_delivered_blue.png',
                        fit: BoxFit.contain,),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Delivered',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SamsungSharpSans-Medium',
                        ),),
                      SizedBox(height: 05),
                    ],
                  ),
                ),
              ),
            ],
      )
          : Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0,top: 00),
            child: Stack(
              alignment: Alignment.center,
              children:[
                Container(
                  height:50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: CustColors.materialBlue,
                      borderRadius: BorderRadius.circular(25)
                    //more than 50% of width makes circle
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset('assets/image/TrackServiceIcons/ic_product_delivered_white.png',
                      fit: BoxFit.contain,
                      color: CustColors.white_02),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0,top: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Service Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SamsungSharpSans-Medium',
                    ),),
                  SizedBox(height: 05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textButtonUi (Size size){
    return Container(
      child: Row(
          children:[
            Container(
              height: 10,
              width: 10,
              color: Colors.white,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 22.0,top:15,bottom: 20),
              child: Container(
                width: 130,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CustomerMainLandingScreen()));
                  },
                  child: Text(' Back ',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SamsungSharpSans-Medium',
                        color: Colors.white
                    ),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    primary: CustColors.materialBlue,
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