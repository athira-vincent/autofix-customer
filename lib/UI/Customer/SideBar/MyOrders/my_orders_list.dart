import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_state.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/my_orders_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                autofocus: true,
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
      if (state is OrderListLoadedState) {
        if (searchController.text.isEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.orderDetailsmodel.data!.orderList.length,
            itemBuilder: (context, index) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                orderlist = state.orderDetailsmodel.data!.orderList;
              });

              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => My_Orders_Display(
                              modeldetails: state
                                  .orderDetailsmodel.data!.orderList[index])));
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
                                    child: Image.network(
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
                                      Container(
                                        decoration: BoxDecoration(
                                            color: CustColors.whiteBlueish,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 8, 8, 2),
                                          child: Text(
                                            "Delivered",
                                            style: Styles
                                                .sparePartNameSubTextBlack,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Text(
                                          "Delivery on jan 20  5pm",
                                          style:
                                              Styles.sparePartNameTextBlack17,
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
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderlistsearch.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => My_Orders_Display(
                              modeldetails: state
                                  .orderDetailsmodel.data!.orderList[index])));
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
                                    child: Image.network(
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
                                      Container(
                                        decoration: BoxDecoration(
                                            color: CustColors.whiteBlueish,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 8, 8, 2),
                                          child: Text(
                                            "Delivered",
                                            style: Styles
                                                .sparePartNameSubTextBlack,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: Text(
                                          "Delivery on jan 20  5pm",
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
          );
        }
      } else {
        return Container();
      }
    });
  }
}
