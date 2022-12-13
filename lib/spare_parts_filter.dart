import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/my_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Search_Spare_Parts_Filter extends StatefulWidget {
  final  String modelname,fromcost,tocost,sorting;

  const Search_Spare_Parts_Filter(
      {Key? key, required this.modelname, required this.fromcost, required this.tocost, required this.sorting,})
      : super(key: key);

  @override
  State<Search_Spare_Parts_Filter> createState() => _Search_Spare_Parts_FilterState();
}

class _Search_Spare_Parts_FilterState extends State<Search_Spare_Parts_Filter> {
  late List<String> image;
  bool addToCart = false;
  String itemcount = "";
  String totalamount = "";
  bool _isSearching = false;
  bool ischanged = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SparePartListBloc()
            ..add(FetchSparePartListEvent(
                widget.modelname.toString(), "null", widget.fromcost, widget.tocost,widget.sorting)),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          /// addtocart
          BlocListener<AddCartBloc, AddCartState>(
            listener: (context, state) {
              if (state is AddCartLoadedState) {
                if (state.addCartModel.data!.addCart.msg.status == "Success") {
                  Fluttertoast.showToast(
                    msg:AppLocalizations.of(context)!.text_successfully_added_cart,
                    timeInSecForIosWeb: 1,
                  );

                  setState(() {
                    addToCart = true;

                    itemcount =
                        state.addCartModel.data!.addCart.itemCount.toString();
                    totalamount =
                        state.addCartModel.data!.addCart.totalAmount.toString();

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
                  appBarCustomUi(),
                  SparePartsListUi(),
                ],
              ),
              addToCart == true ? ViewCartUi() : Container(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget SparePartsListUi() {
    return Expanded(
      child: BlocBuilder<SparePartListBloc, SparePartListState>(
          builder: (context, state) {
        if (state is SparePartListLoadingState) {
          return Container();
        } else if (state is SparePartListLoadedState) {
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
              image = state
                  .sparePartslistModel.data!.sparePartsList[index].productImage
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
                                  state.sparePartslistModel.data!
                                          .sparePartsList[index].productImage ==
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
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              "\$ " +
                                  state.sparePartslistModel.data!
                                      .sparePartsList[index].price.toString(),
                              style: Styles.sparePartOrginalPriceSubTextBlack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  "\$ " +
                                      state.sparePartslistModel.data!
                                          .sparePartsList[index].price.toString(),
                                  style: Styles.sparePartOfferPriceSubTextBlack,
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: InkWell(
                                    onTap: () {
                                      final addcartBloc =
                                          BlocProvider.of<AddCartBloc>(context);
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
                                      child: const Text(
                                        AppLocalizations.of(context)!.text_Add_cart,
                                        style: Styles.homeActiveTextStyle,
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
          return Container();
        }
      }),
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
      ],
    );
  }

  ViewCartUi() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyCartScreen(isFromHome: false, addresstext: '', addressid: '',)));
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
                      itemcount + AppLocalizations.of(context)!.text_items,
                      style: Styles.addToCartItemText02,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        "\$" + totalamount,
                        style: Styles.addToCartItemText02,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  AppLocalizations.of(context)!.text_View_Cart,
                  style: Styles.addToCartText02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
