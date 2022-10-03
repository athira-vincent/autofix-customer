import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_list_model/spare_parts_list_model.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_state.dart';
import 'package:auto_fix/UI/SpareParts/FilterScreen/filter_screen.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/my_cart_screen.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SparePartsListScreen extends StatefulWidget {
  final String modelname;

  const SparePartsListScreen({Key? key, required this.modelname})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SparePartsListScreenState();
  }
}

class _SparePartsListScreenState extends State<SparePartsListScreen> {
  double per = .10;
  double perfont = .10;

  bool addToCart = false;

  TextEditingController searchController = TextEditingController();
  StateSetter? setStateSearch;

  late List<String> image;
  String itemcount = "";
  String totalamount = "";
  bool _isSearching = false;
  bool ischanged = false;
  List<SparePartsList> sparepartslistsearch = [];
  List<SparePartsList> spareparts = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SparePartListBloc()
              ..add(FetchSparePartListEvent(
                  widget.modelname.toString(), "null", "null", "null", "null")),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            /// addtocart
            BlocListener<AddCartBloc, AddCartState>(
              listener: (context, state) {
                if (state is AddCartLoadedState) {
                  if (state.addCartModel.data!.addCart.msg.status ==
                      "Success") {
                    Fluttertoast.showToast(
                      msg: "successfully added to cart!!",
                      timeInSecForIosWeb: 1,
                    );

                    setState(() {
                      addToCart = true;

                      itemcount =
                          state.addCartModel.data!.addCart.itemCount.toString();
                      totalamount = state.addCartModel.data!.addCart.totalAmount
                          .toString();

                      final addcartsBloc =
                          BlocProvider.of<ShowCartPopBloc>(context);
                      addcartsBloc.add(FetchShowCartPopEvent());

                      ViewCartUi();
                    });
                  }
                }
              },
            ),
          ],
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      _isSearching == true
                          ? _buildSearchField()
                          : appBarCustomUi(),
                      SparePartsListUi(),
                    ],
                  ),
                  addToCart == true ? ViewCartUi() : Container(),
                ],
              )),
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
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            widget.modelname,
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: SvgPicture.asset(
            'assets/image/home_customer/filterSearch.svg',
            height: 20,
            width: 20,
          ),
          onPressed: () {
            // _showModal(context);
            setState(() {
              _isSearching = true;
            });
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/image/home_customer/filterIcon.svg',
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FilterScreen(
                          modelname: widget.modelname,
                        )));
          },
        ),
      ],
    );
  }

  Widget SparePartsListUi() {
    return Expanded(
      child: BlocBuilder<SparePartListBloc, SparePartListState>(
          builder: (context, state) {
        if (state is SparePartListLoadingState) {
          return Container();
        } else if (state is SparePartListLoadedState) {
          if (searchController.text.isEmpty) {
            return GridView.builder(
              itemCount: state.sparePartslistModel.data!.sparePartsList.length,
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (
                context,
                index,
              ) {
                spareparts = state.sparePartslistModel.data!.sparePartsList;

                image = state.sparePartslistModel.data!.sparePartsList[index]
                    .productImage
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .split(",");
                print("imagesss");

                print(image);

                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustColors.greyText1),
                      borderRadius: BorderRadius.circular(0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: state
                                        .sparePartslistModel
                                        .data!
                                        .sparePartsList[index]
                                        .productImage
                                        .isEmpty ||
                                    state
                                            .sparePartslistModel
                                            .data!
                                            .sparePartsList[index]
                                            .productImage ==
                                        "null"
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
                                    image[0],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Text(
                                state.sparePartslistModel.data!
                                    .sparePartsList[index].productName,
                                style: Styles.sparePartNameTextBlack17,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                state.sparePartslistModel.data!
                                        .sparePartsList[index].productCode +
                                    "." " |" +
                                    state
                                        .sparePartslistModel
                                        .data!
                                        .sparePartsList[index]
                                        .vehicleModel
                                        .modelName,
                                style: Styles.sparePartNameSubTextBlack,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            //   child: Container(
                            //     height: 20,
                            //     width: 50,
                            //     alignment: Alignment.center,
                            //     color: CustColors.light_navy,
                            //     child: const Text(
                            //       "5% OFF",
                            //       style: Styles.badgeTextStyle1,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Spacer(),
                                  Text(
                                    state.sparePartslistModel.data!
                                        .sparePartsList[index].avgRate
                                        .toString()
                                        .substring(0, 3),
                                    style: Styles.sparePartOrginalPriceSubTextBlack,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₦ " +
                                        state.sparePartslistModel.data!
                                            .sparePartsList[index].price
                                            .toString(),
                                    style: Styles.sparePartOrginalPriceSubTextBlack,
                                  ),

                                  SizedBox(
                                    height: 10,
                                    child: RatingBar.builder(
                                      itemSize: 13,
                                      ignoreGestures: true,
                                      initialRating: state.sparePartslistModel.data!
                                          .sparePartsList[index].avgRate
                                          .toDouble(),
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: CustColors.materialBlue,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "₦" +
                                        state.sparePartslistModel.data!
                                            .sparePartsList[index].price
                                            .toString(),
                                    style:
                                        Styles.sparePartOfferPriceSubTextBlack,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        final addcartBloc =
                                            BlocProvider.of<AddCartBloc>(
                                                context);
                                        addcartBloc.add(FetchAddCartEvent(state
                                            .sparePartslistModel
                                            .data!
                                            .sparePartsList[index]
                                            .id
                                            .toString()));
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 70,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: CustColors.greyText3),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: state
                                                    .sparePartslistModel
                                                    .data!
                                                    .sparePartsList[index]
                                                    .inCart ==
                                                false
                                            ? const Text(
                                                "+ Add to cart",
                                                style:
                                                    Styles.homeActiveTextStyle,
                                              )
                                            : const Text(
                                                "in cart",
                                                style:
                                                    Styles.homeActiveTextStyle,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {

            return GridView.builder(
              itemCount: sparepartslistsearch.length,
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (
                context,
                index,
              ) {

                image = sparepartslistsearch[index]
                    .productImage
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .split(",");

                print("imagesss");

                print(image);

                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustColors.greyText1),
                      borderRadius: BorderRadius.circular(0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: sparepartslistsearch[index]
                                        .productImage
                                        .isEmpty ||
                                    sparepartslistsearch[index].productImage ==
                                        "null"
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
                                    image[0],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Text(
                                sparepartslistsearch[index].productName,
                                style: Styles.sparePartNameTextBlack17,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                sparepartslistsearch[index].productCode +
                                    "." " |" +
                                    sparepartslistsearch[index]
                                        .vehicleModel
                                        .modelName,
                                style: Styles.sparePartNameSubTextBlack,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            //   child: Container(
                            //     height: 20,
                            //     width: 50,
                            //     alignment: Alignment.center,
                            //     color: CustColors.light_navy,
                            //     child: const Text(
                            //       "5% OFF",
                            //       style: Styles.badgeTextStyle1,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                "₦ " +
                                    sparepartslistsearch[index]
                                        .price
                                        .toString(),
                                style: Styles.sparePartOrginalPriceSubTextBlack,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "₦" +
                                        sparepartslistsearch[index]
                                            .price
                                            .toString(),
                                    style:
                                        Styles.sparePartOfferPriceSubTextBlack,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: InkWell(
                                      onTap: () {
                                        final addcartBloc =
                                            BlocProvider.of<AddCartBloc>(
                                                context);
                                        addcartBloc.add(FetchAddCartEvent(
                                            sparepartslistsearch[index]
                                                .id
                                                .toString()));
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 70,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: CustColors.greyText3),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: sparepartslistsearch[index]
                                                    .inCart ==
                                                false
                                            ? const Text(
                                                "+ Add to cart",
                                                style:
                                                    Styles.homeActiveTextStyle,
                                              )
                                            : const Text(
                                                "in cart",
                                                style:
                                                    Styles.homeActiveTextStyle,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        } else {
          return Container();
        }
      }),
    );
  }

  ViewCartUi() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyCartScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Container(
          height: 65,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: CustColors.light_navy,
              border: Border.all(
                color: CustColors.light_navy,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      itemcount + " items",
                      style: Styles.addToCartItemText02,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        " ₦" + totalamount,
                        style: Styles.addToCartItemText02,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  "View Cart >",
                  style: Styles.addToCartText02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _showModal(context) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         //3
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //           setStateSearch = setState;
  //           return Container(
  //             height: MediaQuery.of(context).size.height * .85,
  //             alignment: Alignment.topCenter,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: SizedBox(
  //                       height: 35,
  //                       child: TextField(
  //                         controller: searchController,
  //                         autofocus: true,
  //                         decoration: InputDecoration(
  //                           hintText: 'Search spare parts for your vehicle',
  //                           contentPadding:
  //                               const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
  //                           prefixIcon: const Icon(Icons.search_rounded,
  //                               color: CustColors.light_navy),
  //                           border: OutlineInputBorder(
  //                               borderSide: const BorderSide(
  //                                   color: CustColors.whiteBlueish),
  //                               borderRadius: BorderRadius.circular(0.0)),
  //                           focusedBorder: OutlineInputBorder(
  //                               borderSide: const BorderSide(
  //                                   color: CustColors.whiteBlueish),
  //                               borderRadius: BorderRadius.circular(0.0)),
  //                           enabledBorder: OutlineInputBorder(
  //                               borderSide: const BorderSide(
  //                                   color: CustColors.whiteBlueish),
  //                               borderRadius: BorderRadius.circular(0.0)),
  //                           disabledBorder: OutlineInputBorder(
  //                               borderSide: const BorderSide(
  //                                   color: CustColors.whiteBlueish),
  //                               borderRadius: BorderRadius.circular(0.0)),
  //                           errorBorder: OutlineInputBorder(
  //                               borderSide: const BorderSide(
  //                                   color: CustColors.whiteBlueish),
  //                               borderRadius: BorderRadius.circular(0.0)),
  //                         ),
  //                         onChanged: (text) {
  //                           if (text != null &&
  //                               text.isNotEmpty &&
  //                               text != "") {}
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         });
  //       });
  // }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      autofocus: true,
      onChanged: (text) {
        setState(() {
          sparepartslistsearch = spareparts
              .where((element) => element.productName
                  .toLowerCase()
                  .contains(text.toLowerCase()))
              .toList();
        });
      },
      decoration: InputDecoration(
        hintText: 'Search spare parts for your vehicle',
        contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
        prefixIcon: InkWell(
          onTap: () async {
            // SharedPreferences shdPre = await SharedPreferences.getInstance();
            // setState(() {
            //   ischanged = true;
            //   shdPre.setString("ischanged", ischanged.toString());
            //
            //   final addcartsBloc = BlocProvider.of<SparePartListBloc>(context);
            //   addcartsBloc.add(FetchSparePartListEvent(
            //       widget.modelname.toString(),
            //       searchController.text.toString(),
            //       "null",
            //       "null",
            //       "null"));
            // });
            //
            //
            //
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => Search_Spare_Parts(
            //             changestatus: ischanged,
            //             modelname: widget.modelname,
            //             searchkey: searchController.text)));
          },
          child: const Icon(Icons.search_rounded, color: CustColors.light_navy),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: CustColors.whiteBlueish),
            borderRadius: BorderRadius.circular(0.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustColors.whiteBlueish),
            borderRadius: BorderRadius.circular(0.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustColors.whiteBlueish),
            borderRadius: BorderRadius.circular(0.0)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustColors.whiteBlueish),
            borderRadius: BorderRadius.circular(0.0)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustColors.whiteBlueish),
            borderRadius: BorderRadius.circular(0.0)),
      ),
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
