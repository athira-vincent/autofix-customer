import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_state.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cancel_order_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cust_rating_bloc/cust_rating_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cust_rating_bloc/cust_rating_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cust_rating_bloc/cust_rating_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class My_Orders_Display extends StatefulWidget {
  final OrderList modeldetails;
  final String deliverydate;

  const My_Orders_Display(
      {Key? key, required this.modeldetails, required this.deliverydate})
      : super(key: key);

  @override
  State<My_Orders_Display> createState() => _My_Orders_DisplayState();
}

class _My_Orders_DisplayState extends State<My_Orders_Display> {
  double _rating = 1.0;
  double _initialRating = 1.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<CancelOrderBloc, CancelOrderState>(
            listener: (context, state) {
              if (state is CancelOrderLoadedState) {
                if (state.cancelOrder.data!.orderCancel.message ==
                    "Order cancelled successfully!!!!") {
                  Fluttertoast.showToast(
                    msg: "Order cancelled successfully!!",
                    timeInSecForIosWeb: 1,
                  );
                }
              }
            },
          ),

          BlocListener<CustRatingBloc, CustRatingState>(
            listener: (context, state) {
              if (state is CustRatingLoadedState) {
                if (state.customerRatingModel.data!.reviewCreate.message ==
                    "Rating updating successfully!!!") {
                  Fluttertoast.showToast(
                    msg: "Rated successfully!!",
                    timeInSecForIosWeb: 1,
                  );
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        widget.modeldetails.product.productName,
                        textAlign: TextAlign.center,
                        style: Styles.appBarTextBlue,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustColors.whiteBlueish,
                        borderRadius: BorderRadius.circular(11.0)),
                    child: Image.network(
                        'https://cdn.zeplin.io/620a1cdc253c8ca7ef9e1792/assets/0DEE6D3F-2121-4194-86D6-903C453BFC87.png'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: CustColors.whiteBlueish,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: SizedBox(
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text
                                  const SizedBox(
                                    height: 10,
                                  ), //SizedBox
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Text(
                                          "Delivery on " + widget.deliverydate,
                                          style:
                                              Styles.sparePartNameTextBlack17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      widget.modeldetails.paymentStatus != 0
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      CustColors.whiteBlueish,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 10, 8, 2),
                                                child: Text(
                                                  "Payment Completed",
                                                  style: Styles
                                                      .sparePartNameSubTextBlack,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      CustColors.whiteBlueish,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 10, 8, 2),
                                                child: widget.modeldetails
                                                            .status ==
                                                        1
                                                    ? const Text(
                                                        "Order created",
                                                        style: Styles
                                                            .sparePartNameSubTextBlack,
                                                      )
                                                    : widget.modeldetails
                                                                .status ==
                                                            2
                                                        ? const Text(
                                                            "Dispatched",
                                                            style: Styles
                                                                .sparePartNameSubTextBlack,
                                                          )
                                                        : widget.modeldetails
                                                                    .status ==
                                                                3
                                                            ? const Text(
                                                                "Delivered",
                                                                style: Styles
                                                                    .sparePartNameSubTextBlack,
                                                              )
                                                            : const Text(
                                                                "Cancelled",
                                                                style: Styles
                                                                    .sparePartNameTextBlack17,
                                                              ),
                                              ),
                                            ),
                                    ],
                                  ), //Text
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(
                                    widget.modeldetails.product.productName,
                                    style: Styles.sparePartNameSubTextBlack,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Product code",
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        widget.modeldetails.product.productCode,
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(color: Colors.grey), //
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Item Quantity",
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        widget.modeldetails.product.quantity
                                            .toString(),
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                    ],
                                  ), //
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Delivery fee",
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                      const SizedBox(
                                        width: 23,
                                      ),
                                      Text(
                                        widget
                                            .modeldetails.product.shippingCharge
                                            .toString(),
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Total price",
                                        style: Styles.sparePartNameTextBlack17,
                                      ),
                                      const SizedBox(
                                        width: 19,
                                      ),
                                      Text(
                                        "₦" +
                                            widget.modeldetails.totalPrice
                                                .toString(),
                                        style: Styles.sparePartNameTextBlack17,
                                      ),
                                    ],
                                  ),
                                  const Divider(color: Colors.grey), //
                                   Center(
                                    child:  Visibility(
                                      visible: widget.modeldetails.status==3?true:false,
                                      child: Text(
                                        "Rate your product !",
                                        style: TextStyle(
                                            fontSize: 10.7,
                                            fontFamily: "Samsung_SharpSans_Medium",
                                            fontWeight: FontWeight.w400,
                                            color: CustColors.light_navy),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Visibility(
                                    visible: widget.modeldetails.status==3?true:false,
                                    child: SizedBox(
                                     height: 60,
                                      child: RatingBar(
                                        initialRating: _initialRating,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        ratingWidget: RatingWidget(
                                          full: _image(
                                              'assets/image/IconsRatingBar/star_active.png'),
                                          half: _image(
                                              'assets/image/IconsRatingBar/star_half.png'),
                                          empty: _image(
                                              'assets/image/IconsRatingBar/star_inactive.png'),
                                        ),
                                        itemPadding:
                                        const EdgeInsets.symmetric(horizontal: 8.1),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            _rating = rating;
                                          });
                                        },
                                        updateOnDrag: true,
                                      ),
                                    ),
                                  ),//
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(""),
                                      InkWell(
                                        onTap: (){
                                          final custratingBloc =
                                          BlocProvider.of<CustRatingBloc>(context);
                                          custratingBloc.add(FetchCustRatingEvent(_rating.toString(),
                                              widget.modeldetails.id.toString(),widget.modeldetails.product.id.toString()));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                              CustColors.whiteBlueish,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 10, 12, 5),
                                            child: Text(
                                              "Submit",
                                              style: Styles
                                                  .sparePartNameSubTextBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )// SizedBox
                                  //SizedBox
                                ],
                              ), //Column
                            ), //Padding
                          ), //SizedBox
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Visibility(
                    visible: widget.modeldetails.status == 1 ? true : false,
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: MaterialButton(
                        onPressed: () {
                          final cacncelBloc =
                              BlocProvider.of<CancelOrderBloc>(context);
                          cacncelBloc.add(FetchCancelOrderEvent(
                              widget.modeldetails.id.toString()));
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Cancel Order',
                                textAlign: TextAlign.center,
                                style: Styles.textButtonLabelSubTitle,
                              ),
                            ],
                          ),
                        ),
                        color: CustColors.materialBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      //color: Colors.amber,
    );
  }
}
