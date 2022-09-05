import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/payment_main_screen.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_oder_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_oder_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_order_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_state.dart';
import 'package:auto_fix/UI/SpareParts/change_delivery_address_screen.dart';
import 'package:auto_fix/UI/SpareParts/purchase_response_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/Widgets/show_pop_up_widget.dart';
import 'package:auto_fix/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'showcartpopbloc/show_cart_pop_event.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenState();
  }
}

class _MyCartScreenState extends State<MyCartScreen> {
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  bool _isLoading = false;
  double per = .10;
  double perfont = .10;

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  bool language_en_ar = true;

  ShowCartPopBloc? showpop;
  late List<String> image;

  String states = "";
  String city = "";
  String pincode = "";

  @override
  void initState() {
    final addcartsBloc = BlocProvider.of<ShowCartPopBloc>(context);
    addcartsBloc.add(FetchShowCartPopEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteCartBloc, DeleteCartState>(
            listener: (context, state) {
              if (state is DeleteCartLoadedState) {
                if (state.deleteCartModel.data!.updateCart.status ==
                    "Success") {
                  final addcartsBloc =
                      BlocProvider.of<ShowCartPopBloc>(context);
                  addcartsBloc.add(FetchShowCartPopEvent());
                }
              }
            },
          ),
          BlocListener<PlaceOrderBloc, PlaceOrderState>(
            listener: (context, state) {
              if (state is PlaceOrderLoadedState) {
                if (state.placeorderModel.data!.placeOrder.message ==
                    "Success") {
                  Fluttertoast.showToast(msg: "Placed order successfully");
                  final addcartsBloc =
                  BlocProvider.of<ShowCartPopBloc>(context);
                  addcartsBloc.add(FetchShowCartPopEvent());
                }
              }
            },
          ),
        ],
        child: Scaffold(
            body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: RefreshIndicator(
            color: CustColors.light_navy,
            onRefresh: () async {
              final addcartsBloc = BlocProvider.of<ShowCartPopBloc>(context);
              addcartsBloc.add(FetchShowCartPopEvent());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appBarCustomUi(),
                  productsListUi(),
                  // placeOrderUi(),
                  // Divider(),
                  // changeAddressUi(),
                  // Divider(),
                  // selectedBillDetailsUi(),
                  // Divider(),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: const [
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'My Cart',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget productsListUi() {
    return BlocBuilder<ShowCartPopBloc, ShowCartPopState>(
        builder: (context, state) {
      if (state is ShowCartPopLoadingState) {
        return Center(
          child: SizedBox(
            height: _setValue(28),
            width: _setValue(28),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(CustColors.peaGreen),
            ),
          ),
        );
      } else if (state is ShowCartPopLoadedState) {
        return Column(
          children: [
            ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.cartlistmodel.data!.cartList.data.length,
              itemBuilder: (context, index) {
                // image = state.cartlistmodel.data!.cartList.data[index].product.productImage
                //     .replaceAll("[", "")
                //     .replaceAll("]", "")
                //     .split(",");
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  print("WidgetsBinding");
                  states = state.cartlistmodel.data!.cartList.data[index]
                      .customer.address.first.state;
                  city = state.cartlistmodel.data!.cartList.data[index].customer
                      .address.first.city;
                  pincode = state.cartlistmodel.data!.cartList.data[index]
                      .customer.address.first.pincode;
                });

                print("nocunter");
                print(states);
                print(city);
                print(pincode);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: SizedBox(
                                  height: 60,
                                  width: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: state
                                                    .cartlistmodel
                                                    .data!
                                                    .cartList
                                                    .data[index]
                                                    .product
                                                    .productImage ==
                                                "null" ||
                                            state
                                                .cartlistmodel
                                                .data!
                                                .cartList
                                                .data[index]
                                                .product
                                                .productImage
                                                .isEmpty
                                        ? Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(25),
                                              child: SvgPicture.asset(
                                                'assets/image/CustomerType/dummyCar00.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          )
                                        : Image.network(
                                            state
                                                .cartlistmodel
                                                .data!
                                                .cartList
                                                .data[index]
                                                .product
                                                .productImage,
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Text(
                                          state
                                              .cartlistmodel
                                              .data!
                                              .cartList
                                              .data[index]
                                              .product
                                              .vehicleModel
                                              .brandName,
                                          style:
                                              Styles.sparePartNameSubTextBlack,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Text(
                                          state.cartlistmodel.data!.cartList
                                              .data[index].product.productName,
                                          style:
                                              Styles.sparePartNameTextBlack17,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 10),
                                        child: Text(
                                          state
                                              .cartlistmodel
                                              .data!
                                              .cartList
                                              .data[index]
                                              .product
                                              .vehicleModel
                                              .modelName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              Styles.sparePartNameSubTextBlack,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: 20,
                                            width: 70,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        CustColors.greyText3),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (state
                                                            .cartlistmodel
                                                            .data!
                                                            .cartList
                                                            .data[index]
                                                            .quantity >
                                                        1) {
                                                      setState(() {
                                                        state
                                                            .cartlistmodel
                                                            .data!
                                                            .cartList
                                                            .data[index]
                                                            .quantity--;
                                                      });

                                                      final deletcartBloc =
                                                          BlocProvider.of<
                                                                  DeleteCartBloc>(
                                                              context);
                                                      deletcartBloc.add(
                                                          FetchDeleteCartEvent(
                                                              state
                                                                  .cartlistmodel
                                                                  .data!
                                                                  .cartList
                                                                  .data[index]
                                                                  .product
                                                                  .id
                                                                  .toString(),
                                                              state
                                                                  .cartlistmodel
                                                                  .data!
                                                                  .cartList
                                                                  .data[index]
                                                                  .quantity
                                                                  .toString(),
                                                              "1"));
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 25,
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: const Text(
                                                      "-",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: Styles
                                                          .homeNameTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      state
                                                          .cartlistmodel
                                                          .data!
                                                          .cartList
                                                          .data[index]
                                                          .quantity
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Styles
                                                          .homeActiveTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      state
                                                          .cartlistmodel
                                                          .data!
                                                          .cartList
                                                          .data[index]
                                                          .quantity++;
                                                    });
                                                    final deletcartBloc =
                                                        BlocProvider.of<
                                                                DeleteCartBloc>(
                                                            context);
                                                    deletcartBloc.add(
                                                        FetchDeleteCartEvent(
                                                            state
                                                                .cartlistmodel
                                                                .data!
                                                                .cartList
                                                                .data[index]
                                                                .product
                                                                .id
                                                                .toString(),
                                                            state
                                                                .cartlistmodel
                                                                .data!
                                                                .cartList
                                                                .data[index]
                                                                .quantity
                                                                .toString(),
                                                            "1"));
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 25,
                                                    color: Colors.transparent,
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "+",
                                                      style: Styles
                                                          .homeNameTextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: const Text("Confirm",
                                                      style: TextStyle(
                                                        fontFamily: 'Formular',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: CustColors
                                                            .materialBlue,
                                                      )),
                                                  content: const Text(
                                                      "Are you sure you want to delete?"),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: CustColors
                                                              .rusty_red,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        isDefaultAction: true,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("No")),
                                                    CupertinoDialogAction(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: CustColors
                                                              .rusty_red,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        isDefaultAction: true,
                                                        onPressed: () async {
                                                          final deletcartBloc =
                                                              BlocProvider.of<
                                                                      DeleteCartBloc>(
                                                                  context);
                                                          deletcartBloc.add(
                                                              FetchDeleteCartEvent(
                                                                  state
                                                                      .cartlistmodel
                                                                      .data!
                                                                      .cartList
                                                                      .data[
                                                                          index]
                                                                      .product
                                                                      .id
                                                                      .toString(),
                                                                  "1",
                                                                  "0"));
                                                          Navigator.pop(
                                                              context);
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Removed from cart successfully!!",
                                                            timeInSecForIosWeb:
                                                                1,
                                                          );
                                                        },
                                                        child:
                                                            const Text("Yes")),
                                                  ],
                                                );
                                              });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/image/home_customer/deleteMyCart.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(
                                        "\$ " +
                                            state.cartlistmodel.data!.cartList
                                                .data[index].product.price
                                                .toString(),
                                        style: Styles.sparePartNameTextBlack17,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: InkWell(
                                        onTap: (){
                                          final placeorderBloc =
                                          BlocProvider.of<PlaceOrderBloc>(context);
                                          placeorderBloc.add(FetchPlaceOrderEvent(state.cartlistmodel.data!.cartList.data[index].quantity
                                              .toString(),state.cartlistmodel.data!.cartList.data[index].product.price.toString(),state.cartlistmodel.data!.cartList.data[index].product.id.toString(),
                                              city));
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 70,
                                          alignment: Alignment.center,
                                          color: CustColors.light_navy,
                                          child: const Text(
                                            "Place order",
                                            style: Styles.badgeTextStyle1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
            //placeOrderUi(state.cartlistmodel.data!.cartList.totalPrice),
            Divider(),
            changeAddressUi(),
            Divider(),
            // selectedBillDetailsUi(
            //     state.cartlistmodel.data!.cartList.totalPrice,
            //     state.cartlistmodel.data!.cartList.totalItems,
            //     state.cartlistmodel.data!.cartList.deliveryCharge),
            Divider(),
            continueButtonUi(),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget placeOrderUi(int totalPrices) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
          width: double.infinity,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/image/home_customer/mycartSucessflag.svg',
                  height: 35,
                  width: 35,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            "Buy all the  products in the cart",
                            style: Styles.sparePartNameTextBlack17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          "\$ " + totalPrices.toString(),
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Container(
                          height: 20,
                          width: 70,
                          alignment: Alignment.center,
                          color: CustColors.light_navy,
                          child: Text(
                            "Place order",
                            style: Styles.badgeTextStyle1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget changeAddressUi() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/image/home_customer/myCartLocation.svg',
                height: 30,
                width: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Text(
                          "Delivering to : " " " +
                              states +
                              " , " +
                              city +
                              " ," +
                              pincode,
                          maxLines: 2,
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      //   child: Row(
                      //     children: [
                      //       Flexible(
                      //         child: Text(
                      //           "Beside oando filling station.",
                      //           style: Styles.sparePartNameTextBlack17,
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(2),
                      //         child: Container(
                      //           height: 20,
                      //           width: 45,
                      //           decoration: BoxDecoration(
                      //               color: CustColors.roseText1,
                      //               borderRadius: BorderRadius.circular(10)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(4),
                      //             child: Text(
                      //               "Work",
                      //               style: Styles.sparePartNameTextBlack17,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeDeliveryAddressScreen()

                              ));
                        },
                        child: Container(
                          height: 25,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustColors.light_navy),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text(
                            "Change",
                            style: Styles.homeActiveTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget selectedBillDetailsUi(
      int totalPrices, int totalItems, int deliveryCharge) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(0.0)),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  'Bill Details',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: Styles.appBarTextBlack17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Items in cart',
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.visible,
                            style: Styles.textLabelTitle_12,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            totalItems.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.visible,
                            style: Styles.textLabelTitle_10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Delivery Fee',
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.visible,
                            style: Styles.textLabelTitle_12,
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            deliveryCharge.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.visible,
                            style: Styles.textLabelTitle_10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Total price including tax',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.textLabelTitle_12,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          totalPrices.toString(),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.textLabelTitle_12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget continueButtonUi() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
          child: Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: _isLoading
                ? Center(
                    child: SizedBox(
                      height: _setValue(28),
                      width: _setValue(28),
                      child: const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustColors.light_navy),
                      ),
                    ),
                  )
                : Container(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Payment_Main_Screen()));
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Continue',
                              textAlign: TextAlign.center,
                              style: Styles.textButtonLabelSubTitle,
                            ),
                          ],
                        ),
                      ),
                      color: CustColors.materialBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_setValue(10))),
                    ),
                  ),
          ),
        ),
      ],
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
