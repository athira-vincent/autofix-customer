import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_state.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cancel_order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class My_Orders_Display extends StatefulWidget {
  final OrderList modeldetails;

  const My_Orders_Display({Key? key, required this.modeldetails})
      : super(key: key);

  @override
  State<My_Orders_Display> createState() => _My_Orders_DisplayState();
}

class _My_Orders_DisplayState extends State<My_Orders_Display> {
  @override
  Widget build(BuildContext context) {
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
                            height: 300,
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
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Text(
                                          "Delivery on jan 20  5pm",
                                          style:
                                              Styles.sparePartNameTextBlack17,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: CustColors.whiteBlueish,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 10, 8, 2),
                                          child: Text(
                                            "Delivered",
                                            style:
                                                Styles.sparePartNameTextBlack17,
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
                                  ), // SizedBox
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
