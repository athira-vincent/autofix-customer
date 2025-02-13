import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_state.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/my_orders_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOrdersListScreen extends StatefulWidget {
  const MyOrdersListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyOrdersListScreenState();
  }
}

class _MyOrdersListScreenState extends State<MyOrdersListScreen> {
  TextEditingController searchController = TextEditingController();

  List<OrderList> orderlistsearch = [];
  List<OrderList> orderlist = [];
  var formate1;
  late List<String> image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OrderListBloc()..add(FetchOrderListEvent()),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomUi(),
                searchOrdersUi(),
                myOrdersListUi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'My Orders',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget searchOrdersUi() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 35,
              child: TextField(
                controller: searchController,
                //autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search your order',
                  contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: CustColors.light_navy),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                ),
                onChanged: (text) {
                  setState(() {
                    orderlistsearch = orderlist
                        .where((element) => element.product.productName
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    print("orderlistsearch");
                    print(orderlistsearch);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myOrdersListUi() {
    return BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
          if(state is OrderListLoadingState){
            return progressBarDarkBlue();
          } else if (state is OrderListLoadedState) {
        if (searchController.text.isEmpty) {
          return state.orderDetailsmodel.data!.orderList.length != 0
              ?
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.orderDetailsmodel.data!.orderList.length,
            itemBuilder: (context, index) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                orderlist = state.orderDetailsmodel.data!.orderList;
              });
              if (state.orderDetailsmodel.data!.orderList[index].deliverDate !=
                  null) {
                var dateTime = DateTime.parse(state
                    .orderDetailsmodel.data!.orderList[index].deliverDate
                    .toString());

                formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
              }
              if(state.orderDetailsmodel.data!.orderList[index].product.productImage.toString() != "null"){
                image = state
                    .orderDetailsmodel.data!.orderList[index].product.productImage
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .split(",");
                print("imagesss >>>");
                print(image[0]);
              }

              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => My_Orders_Display(
                  //             modeldetails: state
                  //                 .orderDetailsmodel.data!.orderList[index],deliverydate:formate1)));


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => My_Orders_Display(
                            modeldetails: state
                                .orderDetailsmodel.data!.orderList[index],
                            deliverydate: formate1,
                            productpic:image[0],)));
                },
                child: SizedBox(
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
                                    child:

                                    image != null
                                        ?
                                    Image.network(
                                      image[0].toString(),
                                      fit: BoxFit.cover,
                                    )
                                        :
                                    Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
                                      fit: BoxFit.cover,
                                    ),
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
                                      state
                                                  .orderDetailsmodel
                                                  .data!
                                                  .orderList[index]
                                                  .paymentStatus !=
                                              0
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      CustColors.whiteBlueish,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 8, 8, 2),
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
                                                        8, 8, 8, 2),
                                                child: state
                                                            .orderDetailsmodel
                                                            .data!
                                                            .orderList[index]
                                                            .status ==
                                                        1
                                                    ? const Text(
                                                        "Order created",
                                                        style: Styles
                                                            .sparePartNameSubTextBlack,
                                                      )
                                                    : state
                                                                .orderDetailsmodel
                                                                .data!
                                                                .orderList[
                                                                    index]
                                                                .status ==
                                                            2
                                                        ? const Text(
                                                            "Dispatched",
                                                            style: Styles
                                                                .sparePartNameSubTextBlack,
                                                          )
                                                        : state
                                                                    .orderDetailsmodel
                                                                    .data!
                                                                    .orderList[
                                                                        index]
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
                                                                    .sparePartNameSubTextBlack,
                                                              ),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: state
                                                    .orderDetailsmodel
                                                    .data!
                                                    .orderList[index]
                                                    .deliverDate ==
                                                null
                                            ? const Text("")
                                            : Text(
                                                "Delivery on " + formate1,
                                                style: Styles
                                                    .sparePartNameTextBlack17,
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 10),
                                        child: Text(
                                          state
                                              .orderDetailsmodel
                                              .data!
                                              .orderList[index]
                                              .product
                                              .productName,
                                          style:
                                              Styles.sparePartNameSubTextBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: CustColors.light_navy,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: CustColors.greyText1,
                          )
                        ],
                      ),
                    )),
              );
            },
          )
              :
          myOrdersErrorScreen();
        } else {
          return orderlistsearch.length != 0
              ?
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderlistsearch.length,
            itemBuilder: (context, index) {

              if (orderlistsearch[index].deliverDate !=
                  null) {
                var dateTime = DateTime.parse(orderlistsearch[index].deliverDate
                    .toString());

                formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
              }
              if(orderlistsearch[index].product.productImage.toString() != "null"){
                image = orderlistsearch[index].product.productImage
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .split(",");
                print("imagesss >>>");
                print(image[0]);
              }
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => My_Orders_Display(
                            modeldetails: orderlistsearch[index],
                            deliverydate: formate1,
                            productpic:image[0],)));
                },
                child: SizedBox(
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
                                    child: image != null
                                        ? Image.network(
                                      image[0].toString(),
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
                                      fit: BoxFit.cover,
                                    ),
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
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //       color: CustColors.whiteBlueish,
                                      //       borderRadius:
                                      //           BorderRadius.circular(5)),
                                      //   child: const Padding(
                                      //     padding:
                                      //         EdgeInsets.fromLTRB(8, 8, 8, 2),
                                      //     child: Text(
                                      //       "Delivered",
                                      //       style: Styles
                                      //           .sparePartNameSubTextBlack,
                                      //     ),
                                      //   ),
                                      // ),


                                      orderlistsearch[index]
                                          .paymentStatus !=
                                          0
                                          ? Container(
                                        decoration: BoxDecoration(
                                            color:
                                            CustColors.whiteBlueish,
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8, 8, 8, 2),
                                          child: Text(
                                            "Payment Completed",
                                            style: Styles
                                                .sparePartNameSubTextBlack,
                                          ),
                                        ),
                                      )
                                          : Container(
                                        decoration: BoxDecoration(
                                            color: orderlistsearch[index]
                                                .status ==
                                                3
                                                ? CustColors.materialBlue
                                                : CustColors.whiteBlueish,
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              8, 8, 8, 2),
                                          child: orderlistsearch[index]
                                              .status ==
                                              1
                                              ?  Text(
                                            "Order created",
                                            style: Styles
                                                .sparePartNameSubTextBlack,
                                          )
                                              : orderlistsearch[
                                          index]
                                              .status ==
                                              2
                                              ?  Text(
                                            "Dispatched",
                                            style: Styles
                                                .sparePartNameSubTextBlack,
                                          )
                                              : orderlistsearch[
                                          index]
                                              .status ==
                                              3
                                              ? const Text(
                                            "Delivered",
                                            style: Styles
                                                .badgeTextStyle1,
                                          )
                                              :  Text(
                                            "Cancelled",
                                            style: Styles
                                                .sparePartNameSubTextBlack,
                                          ),
                                        ),
                                      ),


                                       Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Text(
                                          "Delivery on " + formate1,
                                          style:
                                              Styles.sparePartNameTextBlack17,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 10),
                                        child: Text(
                                          orderlistsearch[index]
                                              .product
                                              .productName,
                                          style:
                                              Styles.sparePartNameSubTextBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: CustColors.light_navy,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: CustColors.greyText1,
                          )
                        ],
                      ),
                    )),
              );
            },
          )
              :
          myOrdersErrorScreen();
        }
      } else if(state is OrderListErrorState){
        return myOrdersErrorScreen();
      }else {
        return Container();
      }
    });
  }

  Widget myOrdersErrorScreen(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 170,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color:CustColors.materialBlue, spreadRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height:100,
                width: 100,
                child: SvgPicture.asset('assets/images/nodata.svg')
            ),
            Text(
              AppLocalizations.of(context)!.text_no_order_yet, //You have no orders yet!
              textAlign: TextAlign.left,
              style: Styles.noDataTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget progressBarDarkBlue() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.materialBlue),
          )),
    );
  }
}
