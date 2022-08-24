import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_state.dart';
import 'package:auto_fix/UI/SpareParts/add_delivery_address_screen.dart';
import 'package:auto_fix/UI/SpareParts/edit_delivery_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangeDeliveryAddressScreen extends StatefulWidget {
  ChangeDeliveryAddressScreen();

  @override
  State<StatefulWidget> createState() {
    return _ChangeDeliveryAddressScreenState();
  }
}

class _ChangeDeliveryAddressScreenState
    extends State<ChangeDeliveryAddressScreen> {
  bool isAddressDefault = true;
  late bool isAddressSelected;
  double per = .10;

  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAddressSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddressBloc()..add(FetchAddressEvent()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteAddressBloc, DeleteAddressState>(
              listener: (context, state) {
                if (state is DeleteAddressLoadedState) {
                  if (state.deleteAddressModel.data!.updateAddress.status ==
                      "Success") {
                    final addcartsBloc = BlocProvider.of<AddressBloc>(context);
                    addcartsBloc.add(FetchAddressEvent());
                  }
                }
              },
            ),
          ],
          child: Scaffold(
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarCustomUi(size),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                      left: size.width * 5 / 100,
                      right: size.width * 5 / 100,
                      top: size.height * 2 / 100,
                      bottom: size.height * 1 / 100,
                    ),
                    //color: Colors.white70,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select delivery address ",
                            style: TextStyle(
                                fontSize: 14.3,
                                fontFamily: "Samsung_SharpSans_Medium",
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddDeliveryAddressScreen()));
                              },
                              child: addNewAddressButton(size)),

                          // addressWidget(size,true,"assets/image/ic_work_blue.svg","Work"),
                          BlocBuilder<AddressBloc, AddressState>(
                              builder: (context, state) {
                            if (state is AddressLoadingState) {
                              return Center(
                                child: SizedBox(
                                  height: _setValue(28),
                                  width: _setValue(28),
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        CustColors.peaGreen),
                                  ),
                                ),
                              );
                            } else if (state is AddressLoadedState) {
                              return ListView.builder(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state
                                    .addressModel.data!.selectAddress.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Edit_Delivery_Address(
                                                    fullname: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .fullName,
                                                    phone: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .phoneNo,
                                                    pincode: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .pincode,
                                                    city: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .city,
                                                    state: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .state,
                                                    addressline1: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .address,
                                                    addressline2: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .addressLine2,
                                                    type: state
                                                        .addressModel
                                                        .data!
                                                        .selectAddress[index]
                                                        .type,
                                                  )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 2.8 / 100),
                                      padding: EdgeInsets.only(
                                        left: size.width * 2.5 / 100,
                                        right: size.width * 2.5 / 100,
                                        top: size.height * 2 / 100,
                                        bottom: size.height * 2 / 100,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: Border.all(
                                              color: isAddressSelected
                                                  ? CustColors.light_navy
                                                  : CustColors.greyish,
                                              width: 0.3),
                                          color: isAddressSelected
                                              ? CustColors.pale_blue
                                              : Colors.transparent),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right:
                                                        size.width * 2.5 / 100,
                                                    bottom:
                                                        size.height * 1 / 100),
                                                child: state
                                                            .addressModel
                                                            .data!
                                                            .selectAddress[
                                                                index]
                                                            .type ==
                                                        "Home"
                                                    ? SvgPicture.asset(
                                                        "assets/image/ic_home_blue.svg",
                                                        height: size.height *
                                                            3 /
                                                            100,
                                                        width: size.width *
                                                            3 /
                                                            100,
                                                      )
                                                    : state
                                                                .addressModel
                                                                .data!
                                                                .selectAddress[
                                                                    index]
                                                                .type ==
                                                            "Work"
                                                        ? SvgPicture.asset(
                                                            "assets/image/ic_work_blue.svg",
                                                            height:
                                                                size.height *
                                                                    3 /
                                                                    100,
                                                            width: size.width *
                                                                3 /
                                                                100,
                                                          )
                                                        : SvgPicture.asset(
                                                            "assets/image/ic_location_outline.svg",
                                                            height:
                                                                size.height *
                                                                    3 /
                                                                    100,
                                                            width: size.width *
                                                                3 /
                                                                100,
                                                          ),
                                              ),
                                              state
                                                      .addressModel
                                                      .data!
                                                      .selectAddress[index]
                                                      .type
                                                      .isEmpty
                                                  ? const Text(
                                                      "Other",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "SharpSans_Bold",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    )
                                                  : Text(
                                                      state
                                                          .addressModel
                                                          .data!
                                                          .selectAddress[index]
                                                          .type,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "SharpSans_Bold",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black),
                                                    ),
                                              state
                                                          .addressModel
                                                          .data!
                                                          .selectAddress[index]
                                                          .isDefault ==
                                                      1
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                        left: size.width *
                                                            2 /
                                                            100,
                                                        right: size.width *
                                                            2 /
                                                            100,
                                                        top: size.height *
                                                            .5 /
                                                            100,
                                                        bottom: size.height *
                                                            .5 /
                                                            100,
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        left: size.width *
                                                            2 /
                                                            100,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                4.3),
                                                          ),
                                                          border: Border.all(
                                                              color: CustColors
                                                                  .greyish,
                                                              width: 0.3),
                                                          color: CustColors
                                                              .very_light_blue),
                                                      child:
                                                          const Text("Default"),
                                                    )
                                                  : Container(),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return CupertinoAlertDialog(
                                                          title: const Text(
                                                              "Confirm",
                                                              style: TextStyle(
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
                                                                onPressed: () {
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
                                                                      BlocProvider.of<
                                                                              DeleteAddressBloc>(
                                                                          context);
                                                                  deletcartBloc.add(
                                                                      FetchDeleteAddressEvent(
                                                                    state
                                                                        .addressModel
                                                                        .data!
                                                                        .selectAddress[
                                                                            index]
                                                                        .id,
                                                                    "0",
                                                                  ));
                                                                  Navigator.pop(
                                                                      context);
                                                                  Fluttertoast
                                                                      .showToast(
                                                                    msg:
                                                                        "Removed  successfully!!",
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
                                                child: SvgPicture.asset(
                                                  'assets/image/home_customer/deleteMyCart.svg',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  state
                                                      .addressModel
                                                      .data!
                                                      .selectAddress[index]
                                                      .fullName,
                                                  style: addressTextStyle01),
                                              state
                                                          .addressModel
                                                          .data!
                                                          .selectAddress[index]
                                                          .isDefault ==
                                                      1
                                                  ? Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SvgPicture.asset(
                                                        "assets/image/ic_selected_blue_white_tick.svg",
                                                        height: size.height *
                                                            3 /
                                                            100,
                                                        width: size.width *
                                                            3 /
                                                            100,
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Text(
                                            state.addressModel.data!
                                                .selectAddress[index].phoneNo,
                                            style: addressTextStyle01,
                                          ),
                                          Text(
                                            state.addressModel.data!
                                                .selectAddress[index].address,
                                            style: addressTextStyle02,
                                          ),
                                          Text(
                                            state
                                                .addressModel
                                                .data!
                                                .selectAddress[index]
                                                .addressLine2,
                                            style: addressTextStyle03,
                                          ),
                                          Text(
                                            state
                                                    .addressModel
                                                    .data!
                                                    .selectAddress[index]
                                                    .state +
                                                " " +
                                                state.addressModel.data!
                                                    .selectAddress[index].city +
                                                " " +
                                                state
                                                    .addressModel
                                                    .data!
                                                    .selectAddress[index]
                                                    .pincode,
                                            style: addressTextStyle03,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),
                          // InkWell(
                          //     onTap: (){
                          //       setState(() {
                          //         isAddressSelected = true;
                          //       });
                          //     },
                          //     child: addressWidget(size,false,"assets/image/ic_home_blue.svg","Home")),
                          differentAddressWarning(size),
                        ],
                      ),
                    ),
                  )),
                  saveChangeButton(size)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              //Radius.circular(8),
              ),
          border: Border.all(color: CustColors.almost_black, width: 0.3)),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: CustColors.warm_grey03),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Change delivery address ',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget saveChangeButton(Size size) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 5 / 100, bottom: size.height * 3 / 100),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy),
        padding: EdgeInsets.only(
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: const Text(
          "Save changes",
          style: TextStyle(
            fontSize: 14.3,
            fontWeight: FontWeight.w600,
            fontFamily: "Samsung_SharpSans_Medium",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget addressWidget(
      Size size, bool isAddressDefault, String imagePath, String addressType) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 2.8 / 100),
      padding: EdgeInsets.only(
        left: size.width * 2.5 / 100,
        right: size.width * 2.5 / 100,
        top: size.height * 2 / 100,
        bottom: size.height * 2 / 100,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
              color: isAddressSelected
                  ? CustColors.light_navy
                  : CustColors.greyish,
              width: 0.3),
          color: isAddressSelected ? CustColors.pale_blue : Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: size.width * 2.5 / 100,
                    bottom: size.height * 1 / 100),
                child: SvgPicture.asset(
                  imagePath,
                  height: size.height * 3 / 100,
                  width: size.width * 3 / 100,
                ),
              ),
              Text(
                addressType,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "SharpSans_Bold",
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              isAddressDefault
                  ? Container(
                      padding: EdgeInsets.only(
                        left: size.width * 2 / 100,
                        right: size.width * 2 / 100,
                        top: size.height * .5 / 100,
                        bottom: size.height * .5 / 100,
                      ),
                      margin: EdgeInsets.only(
                        left: size.width * 2 / 100,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.3),
                          ),
                          border:
                              Border.all(color: CustColors.greyish, width: 0.3),
                          color: CustColors.very_light_blue),
                      child: Text("Default"),
                    )
                  : Container(),
              const Spacer(),
              isAddressSelected
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: SvgPicture.asset(
                          "assets/image/ic_selected_blue_white_tick.svg",
                          height: size.height * 3 / 100,
                          width: size.width * 3 / 100,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          Text("George Dola ", style: addressTextStyle01),
          Text(
            "+234 9213213",
            style: addressTextStyle01,
          ),
          Text(
            "Savannah estate, plot 176",
            style: addressTextStyle02,
          ),
          Text(
            "Beside oando filling station",
            style: addressTextStyle03,
          ),
          Text(
            "Abuja Nigeria",
            style: addressTextStyle03,
          )
        ],
      ),
    );
  }

  Widget differentAddressWarning(Size size) {
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(top: size.height * 2.8 / 100),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100, bottom: size.width * 3 / 100),
            margin: EdgeInsets.only(
              left: size.width * 2 / 100,
              //right: size.width * 3 / 100
            ),
            child: SvgPicture.asset(
              "assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,
              width: size.width * 3 / 100,
            ),
          ),
          Text(
            "You  selected a different address as before. \nDelivery Charges may vary for this address . ",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget addNewAddressButton(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 2.8 / 100),
      padding: EdgeInsets.only(
          left: size.width * 2 / 100,
          right: size.width * 2 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100),
      decoration: Styles.boxDecorationStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * 2.5 / 100),
            child: SvgPicture.asset(
              "assets/image/ic_add.svg",
              height: size.height * 2.5 / 100,
              width: size.width * 2.5 / 100,
            ),
          ),
          const Text(
            "Add new address ",
            style: TextStyle(
                fontSize: 14.3,
                fontFamily: "SharpSans_Bold",
                fontWeight: FontWeight.bold,
                color: Colors.black),
          )
        ],
      ),
    );
  }

  TextStyle addressTextStyle01 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Medium",
      fontWeight: FontWeight.w600,
      color: Colors.black);

  TextStyle addressTextStyle02 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w500,
      color: Colors.black);
  TextStyle addressTextStyle03 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w400,
      color: CustColors.warm_grey03);
  TextStyle warningTextStyle01 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w600,
      color: Colors.black);
}
