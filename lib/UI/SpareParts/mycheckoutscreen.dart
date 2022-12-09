import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../Constants/cust_colors.dart';
import '../../Constants/styles.dart';

import '../../Models/customer_models/cart_list_model/cart_list_model.dart';
import 'payment_main_screen.dart';
import 'MyCart/delete_cart_bloc/delete_cart_bloc.dart';
import 'MyCart/delete_cart_bloc/delete_cart_event.dart';
import 'MyCart/delete_cart_bloc/delete_cart_state.dart';
import 'MyCart/new_checkout_bloc/new_checkout_bloc.dart';
import 'MyCart/new_checkout_bloc/new_checkout_event.dart';
import 'MyCart/new_checkout_bloc/new_checkout_state.dart';
import 'MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'MyCart/showcartpopbloc/show_cart_pop_state.dart';


class MyCheckoutScreen extends StatefulWidget {
  final List newitems;
  final String newaddressid;

  const MyCheckoutScreen({
    Key? key,
    required this.newitems,
    required this.newaddressid,
  }) : super(key: key);

  @override
  State<MyCheckoutScreen> createState() => _MyCheckoutScreenState();
}

class _MyCheckoutScreenState extends State<MyCheckoutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  double per = .10;
  double perfont = .10;
  bool allitems = false;
  int totalitems = 0;

  var itemtotal = 0.0;

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

  String newamount = "";

  String deliverycharge = "";

  String newdeliverysum = "";

  bool isclicked = false;

  final List<TextEditingController> _typecontroller = [];
  final List<TextEditingController> _deliverycontroller = [];
  final List<TextEditingController> _expectedcontroller = [];

  List<String> deliverycount = [];

  String newdeliveryamount = "0";

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
        ],
        child: Scaffold(
            body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: RefreshIndicator(
            color: CustColors.materialBlue,
            onRefresh: () async {
              final addcartsBloc = BlocProvider.of<ShowCartPopBloc>(context);
              addcartsBloc.add(FetchShowCartPopEvent());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appBarCustomUi(),
                  productsListUi(),
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
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'My Checkout',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        const Spacer(),
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
              valueColor:
                  AlwaysStoppedAnimation<Color>(CustColors.materialBlue),
            ),
          ),
        );
      } else if (state is ShowCartPopLoadedState) {
        return state.cartlistmodel.data!.cartList.data.isNotEmpty
            ? Column(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        state.cartlistmodel.data?.cartList.data.length ?? 0,
                    itemBuilder: (context, index) {
                      image = state.cartlistmodel.data!.cartList.data[index]
                          .product.productImage
                          .replaceAll("[", "")
                          .replaceAll("]", "")
                          .split(",");
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        states = state.cartlistmodel.data!.cartList.data[index]
                            .customer.address.first.state;
                        city = state.cartlistmodel.data!.cartList.data[index]
                            .customer.address.first.city;
                        pincode = state.cartlistmodel.data!.cartList.data[index]
                            .customer.address.first.pincode;
                      });

                      totalitems =
                          state.cartlistmodel.data!.cartList.totalItems;

                      _typecontroller.add(TextEditingController());
                      _deliverycontroller.add(TextEditingController());
                      _expectedcontroller.add(TextEditingController());

                      int sum = 0;
                      for (var element
                          in state.cartlistmodel.data!.cartList.data) {
                        sum = sum + element.product.price * element.quantity;
                      }

                      newamount = sum.toString();

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
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                      child: SizedBox(
                                        height: 60,
                                        width: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/productAvadhar.svg',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                )
                                              : Image.network(
                                                  image[0],
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                    style: Styles
                                                        .sparePartNameSubTextBlack,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CupertinoAlertDialog(
                                                            title: const Text(
                                                                "Confirm",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Formular',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  isDefaultAction:
                                                                      true,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "No")),
                                                              CupertinoDialogAction(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    color: CustColors
                                                                        .rusty_red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  isDefaultAction:
                                                                      true,
                                                                  onPressed:
                                                                      () async {
                                                                    final deletcartBloc =
                                                                        BlocProvider.of<DeleteCartBloc>(
                                                                            context);
                                                                    deletcartBloc.add(FetchDeleteCartEvent(
                                                                        state
                                                                            .cartlistmodel
                                                                            .data!
                                                                            .cartList
                                                                            .data[index]
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
                                                                      const Text(
                                                                          "Yes")),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Visibility(
                                                    visible: true,
                                                    child: SvgPicture.asset(
                                                      'assets/image/home_customer/deleteMyCart.svg',
                                                      height: 18,
                                                      width: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 0),
                                              child: Text(
                                                state
                                                    .cartlistmodel
                                                    .data!
                                                    .cartList
                                                    .data[index]
                                                    .product
                                                    .productName,
                                                style: Styles
                                                    .sparePartNameTextBlack17,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  state
                                                          .cartlistmodel
                                                          .data!
                                                          .cartList
                                                          .data[index]
                                                          .product
                                                          .productCode +
                                                      "|" +
                                                      state
                                                          .cartlistmodel
                                                          .data!
                                                          .cartList
                                                          .data[index]
                                                          .product
                                                          .vehicleModel
                                                          .modelName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Styles
                                                      .sparePartNameSubTextBlack,
                                                ),
                                                Text(
                                                  " ₦ " +
                                                      state
                                                          .cartlistmodel
                                                          .data!
                                                          .cartList
                                                          .data[index]
                                                          .product
                                                          .price
                                                          .toString(),
                                                  style: Styles
                                                      .sparePartNameTextBlack17,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Delivery Type",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.sparePartNameSubTextBlack,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Delivery fee",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.sparePartNameSubTextBlack,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 130.0,
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 60,
                                  child: TextFormField(
                                    controller: _deliverycontroller[index],
                                    enabled: false,
                                    style: Styles.orderstatusstyle,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: '₦ 0',
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.8,
                                        horizontal: 0.0,
                                      ),
                                      hintStyle: Styles.textLabelSubTitle,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  onTap: () {
                                    showdeliverytype(index);
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width: 93,
                                    child: TextFormField(
                                        controller: _typecontroller[index],
                                        enabled: false,
                                        style: Styles.orderstatusstyle,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: 'Select type',
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.8,
                                            horizontal: 0.0,
                                          ),
                                          hintStyle: Styles.textLabelSubTitle,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (_formKey.currentState!
                                                .validate()) {
                                            } else {}
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              const Text(
                                "Expected delivery date",
                                style: Styles.sparePartNameSubTextBlack,
                              ),
                              // Visibility(
                              //   visible:false,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(left: 42.0),
                              //     child: Text(
                              //       expecteddate,
                              //       style: Styles.sparePartNameSubTextBlack,
                              //     ),
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, bottom: 10),
                                child: SizedBox(
                                  height: 40,
                                  width: 93,
                                  child: TextFormField(
                                      controller: _expectedcontroller[index],
                                      enabled: false,
                                      style: Styles.orderstatusstyle,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.8,
                                          horizontal: 0.0,
                                        ),
                                        hintStyle: Styles.textLabelSubTitle,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          if (_formKey.currentState!
                                              .validate()) {
                                          } else {}
                                        });
                                      }),
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                  //placeOrderUi(state.cartlistmodel.data!.cartList.totalPrice),
                  const Divider(),
                  changeAddressUi(),
                  const Divider(),
                  // selectedBillDetailsUi(
                  //     state.cartlistmodel.data!.cartList.totalPrice,
                  //     state.cartlistmodel.data!.cartList.totalItems,
                  //     state.cartlistmodel.data!.cartList.deliveryCharge),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bill details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Samsung_SharpSans_Medium',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        /// itemnumber
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item number',
                                  textAlign: TextAlign.center,
                                  style: Styles.textLabelSubTitle),
                              Text(totalitems.toString(),
                                  style: Styles.textLabelSubTitle),
                            ]),
                        const SizedBox(
                          height: 5,
                        ),

                        /// delivery fee
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delivery fee',
                                textAlign: TextAlign.center,
                                style: Styles.textLabelSubTitle),
                            Text(newdeliveryamount,
                                style: Styles.textLabelSubTitle),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        /// item total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Item total',
                                textAlign: TextAlign.center,
                                style: Styles.textLabelSubTitle),
                            Text(itemtotal.toStringAsFixed(2),
                                style: Styles.textLabelSubTitle),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),

                  continueButtonUi(
                    state.cartlistmodel.data!.cartList.data,
                  ),
                ],
              )
            : Center(
                child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  SvgPicture.asset(
                    "assets/images/cart_empty.svg",
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text(
                    "Cart Empty",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Samsung_SharpSans_Medium'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Text(
                    "Your cart is empty",
                    style: Styles.sparePartNameTextBlack17,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.014,
                  ),
                  const Text(
                    "Go to product section and add product to cart",
                    style: Styles.sparePartNameTextBlack17,
                  ),
                ],
              ));
      } else {
        return Container();
      }
    });
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
                              widget.newaddressid,
                          maxLines: 2,
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*Padding(
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
                                      ChangeDeliveryAddressScreen(
                                          quantity: "",
                                          productprice: "",
                                          productid: "",
                                          allitems: false)));
                        },
                        child: Container(
                          height: 25,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: CustColors.materialBlue),
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
              ),*/
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
                      const Spacer(),
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
                      const Spacer(),
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
                    const Spacer(),
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

  Widget continueButtonUi(List<Datum> data) {
    String customerid = "";
    String customername = "";
    String cutomerphone = "";

    for (var element in data) {
      customerid = element.customer.id.toString();
      customername = element.customer.address.first.fullName;
      cutomerphone = element.customer.address.first.phoneNo;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: _isLoading
                ? Center(
                    child: SizedBox(
                      height: _setValue(28),
                      width: _setValue(28),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.materialBlue),
                      ),
                    ),
                  )
                : MaterialButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ChangeDeliveryAddressScreen(
                      //             quantity: "",
                      //             productprice: "",
                      //             productid: "",
                      //             allitems: true)));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ChangeDeliveryAddressScreen(
                      //             quantity: "",
                      //             productprice: itemtotal.toString(),
                      //             productid: "",
                      //             allitems: true,
                      //             customerid:customerid,
                      //             customername:customername,
                      //             customeremail:"",
                      //             customerphone:cutomerphone)));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Payment_Main_Screen(
                      //             amount: itemtotal.toString(),
                      //             customerid: customerid,
                      //             customername: customername,
                      //             customeremail: "",
                      //             customerphone: cutomerphone,
                      //             allitems: true,
                      //             addressid: widget.newaddressid)));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const MyCheckoutScreen()));


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Payment_Main_Screen(
                                  amount: itemtotal.toString(),
                                  customerid: customerid,
                                  customername: customername,
                                  customeremail: "",
                                  customerphone: cutomerphone,
                                  allitems: true,
                                  addressid: widget.newaddressid)));
                    },
                    child: ListTile(
                      leading: const Text(
                        'Checkout all products',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Samsung_SharpSans_Medium',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        " ₦ " + itemtotal.toStringAsFixed(2),
                        style: const TextStyle(
                          fontFamily: 'Samsung_SharpSans_Medium',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    color: CustColors.materialBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_setValue(10))),
                  ),
          ),
        ),
      ],
    );
  }

  showdeliverytype(int index2) {
    print(index2);

    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NewCheckoutBloc()
                  ..add(FetchNewCheckoutEvent(
                      widget.newitems.toString(), widget.newaddressid)),
              ),
            ],
            child: BlocBuilder<NewCheckoutBloc, NewCheckoutState>(
                builder: (context, state) {
              if (state is NewCheckoutLoadedState) {
                return Container(
                  height: 200.0,
                  color: Colors.transparent,
                  child: ListView.separated(
                      itemCount:
                          state.newCheckoutModel.data!.checkout[index2].length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 1),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            _deliverycontroller[index2].text = state
                                .newCheckoutModel
                                .data!
                                .checkout[index2][index]
                                .cost
                                .toString();

                            _typecontroller[index2].text = state
                                .newCheckoutModel
                                .data!
                                .checkout[index2][index]
                                .pricingTier;

                            _expectedcontroller[index2].text = state
                                .newCheckoutModel
                                .data!
                                .checkout[index2][index]
                                .duration
                                .toString()
                                .substring(
                                  8,
                                );

                            /// delivery charge for items calculation

                            double deliverychargesum = 0.0;

                            for (var element in _deliverycontroller) {
                              try {
                                deliverychargesum += double.parse(element.text);
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }

                              /// total item including deliverycharge

                              double newitemtotal = 0.0;

                              newitemtotal =
                                  double.parse(newamount) + deliverychargesum;

                              setState(() {
                                newdeliveryamount = deliverychargesum
                                    .toDouble()
                                    .toStringAsFixed(2);
                                itemtotal = newitemtotal;
                              });
                            }

                            Navigator.pop(context);
                          },
                          child: ListTile(
                              leading: Text(
                            state.newCheckoutModel.data!.checkout[index2][index]
                                .pricingTier,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          )),
                        );
                      }),
                );
              } else {
                return Container();
              }
            }),
          );
        });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
