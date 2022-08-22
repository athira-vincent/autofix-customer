import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_event.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  AddDeliveryAddressScreen();

  @override
  State<StatefulWidget> createState() {
    return _AddDeliveryAddressScreenState();
  }
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {

  int selectedIndex = -1;

  List items=[ "Home", "assets/image/ic_home_outline.svg",
   "Work", "assets/image/ic_work_outline.svg",
     "Other", "assets/image/ic_location_outline.svg"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    bottom: size.height * 2 / 100,
                  ),
                  //color: Colors.white70,
                  child: locationForm(size),
                ),
              ),
              InkWell(
                  onTap: () {
                    print("on tap saveAddress");
                    // final addaddressBloc =
                    // BlocProvider.of<AddAddressBloc>(context);
                    // addaddressBloc.add(FetchAddAddressEvent());
                    Navigator.pop(context);
                  },
                  child: saveAddressButton(size))
            ],
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
            icon: const Icon(Icons.arrow_back, color: CustColors.warm_grey03),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Address ',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget useMyLocationButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy),
        padding: EdgeInsets.only(
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          //top: size.height * .5 / 100,
          //bottom: size.height * .5 / 100,
        ),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: size.width * 1.5 / 100),
                width: size.width * 4 / 100,
                height: size.height * 4 / 100,
                child: SvgPicture.asset(
                  "assets/image/ic_zoom_location.svg",
                )),
            const Text(
              "Use my location",
              style: TextStyle(
                fontSize: 14.3,
                fontWeight: FontWeight.w600,
                fontFamily: "Samsung_SharpSans_Medium",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addressTypeOptions(Size size, String text, String imagePath) {
    return Container(
      decoration: boxDecorationStyle,
      padding: EdgeInsets.only(
        left: size.width * 3 / 100,
        right: size.width * 3 / 100,
        top: size.height * 1 / 100,
        bottom: size.height * 1 / 100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * 1 / 100),
            child: SvgPicture.asset(
              imagePath,
              height: size.height * 2.3 / 100,
              width: size.width * 2.3 / 100,
            ),
          ),
          Text(
            text,
            style: hintTextStyle,
          )
        ],
      ),
    );
  }

  Widget locationForm(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: hintTextStyle,
        ),
        Container(
          margin: EdgeInsets.only(
            top: size.height * 1.7 / 100,
            bottom: size.height * 1.7 / 100,
          ),
          decoration: boxDecorationStyle,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            // focusNode: _nameFocusNode,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(ch: "Name").nameChecking,
            //controller: _nameController,
            cursorColor: CustColors.whiteBlueish,
            decoration: const InputDecoration(
              isDense: true,
              //hintText:  "name",
              border:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:  BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              hintStyle: Styles.textLabelSubTitle,
            ),
          ),
        ),
        Text(
          "Phone number",
          style: hintTextStyle,
        ),
        Container(
          margin: EdgeInsets.only(
            top: size.height * 1.7 / 100,
            bottom: size.height * 1.7 / 100,
          ),
          decoration: boxDecorationStyle,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            // focusNode: _nameFocusNode,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(ch: "Phone").phoneNumChecking,
            //controller: _nameController,
            cursorColor: CustColors.whiteBlueish,
            decoration: const InputDecoration(
              isDense: true,
              // hintText:  "phone",
              border:  UnderlineInputBorder(
                borderSide:  BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder:  UnderlineInputBorder(
                borderSide:  BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding:  EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              hintStyle: Styles.textLabelSubTitle,
            ),
          ),
        ),
        Text(
          "Pincode ",
          style: hintTextStyle,
        ),
        Container(
          margin: EdgeInsets.only(
            top: size.height * 1.7 / 100,
            bottom: size.height * 1.7 / 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  decoration: boxDecorationStyle,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    style: Styles.textLabelSubTitle,
                    // focusNode: _nameFocusNode,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    validator: InputValidator(ch: "Pincode").phoneNumChecking,
                    //controller: _nameController,
                    cursorColor: CustColors.whiteBlueish,
                    decoration: const InputDecoration(
                      isDense: true,
                      // hintText:  "PinCode",
                      border:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CustColors.greyish,
                          width: .5,
                        ),
                      ),
                      focusedBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CustColors.greyish,
                          width: .5,
                        ),
                      ),
                      enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CustColors.greyish,
                          width: .5,
                        ),
                      ),
                      contentPadding:  EdgeInsets.symmetric(
                        vertical: 12.8,
                        horizontal: 0.0,
                      ),
                      hintStyle: Styles.textLabelSubTitle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 8 / 100,
              ),
              useMyLocationButton(size),
            ],
          ),
        ),
        Text(
          "Locality",
          style: hintTextStyle,
        ),
        Container(
          margin: EdgeInsets.only(
            top: size.height * 1.7 / 100,
            bottom: size.height * 1.7 / 100,
          ),
          decoration: boxDecorationStyle,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            // focusNode: _nameFocusNode,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(ch: "Phone").phoneNumChecking,
            //controller: _nameController,
            cursorColor: CustColors.whiteBlueish,
            decoration: const InputDecoration(
              isDense: true,
              // hintText:  "phone",
              border:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              hintStyle: Styles.textLabelSubTitle,
            ),
          ),
        ),
        Text(
          "Type of address",
          style: hintTextStyle,
        ),
        Container(
          margin: EdgeInsets.only(
            top: size.height * 1.7 / 100,
            bottom: size.height * 1.7 / 100,
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: addressTypeOptions(
                      size, "Home", "assets/image/ic_home_outline.svg")),
              SizedBox(
                width: size.width * 1.5 / 100,
              ),
              Flexible(
                  child: addressTypeOptions(
                      size, "Work", "assets/image/ic_work_outline.svg")),
              SizedBox(
                width: size.width * 1.5 / 100,
              ),
              Flexible(
                  child: addressTypeOptions(
                      size, "Other", "assets/image/ic_location_outline.svg")),
            ],
          ),



          // GridView.builder(
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     itemCount: items.length,
          //     gridDelegate:
          //     const SliverGridDelegateWithFixedCrossAxisCount(
          //         mainAxisSpacing: 10,
          //         childAspectRatio: 1 / 3,
          //         crossAxisCount: 1),
          //     itemBuilder:
          //         (BuildContext context1, index) {
          //       return InkWell(
          //         onTap: () {
          //           setState(() {
          //             selectedIndex = index++;
          //
          //           });
          //         },
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color:
          //               selectedIndex == index
          //                   ? const Color(
          //                   0xff0052a0)
          //                   : Colors.white,
          //               border: Border.all(
          //                   color: const Color(
          //                       0xff0052a0)),
          //               borderRadius: BorderRadius
          //                   .circular(SizeConfig
          //                   .widthMultiplier *
          //                   1)),
          //           child: Center(
          //             child: Text(
          //               items[index],
          //               style:
          //               GoogleFonts.openSans(
          //                 fontSize: SizeConfig
          //                     .widthMultiplier *
          //                     3.1,
          //                 color: selectedIndex ==
          //                     index
          //                     ? Colors.white
          //                     : const Color(
          //                     0xff0052a0),
          //                 letterSpacing: 0.075,
          //               ),
          //               textAlign:
          //               TextAlign.center,
          //             ),
          //           ),
          //         ),
          //       );
          //     })

        ),
      ],
    );
  }

  Widget saveAddressButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy),
        padding: EdgeInsets.only(
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          top: size.height * .9 / 100,
          bottom: size.height * .9 / 100,
        ),
        margin: EdgeInsets.only(
          right: size.width * 6 / 100,
          bottom: size.height * 3.6 / 100,
        ),
        child: const Text(
          "Save address",
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

  BoxDecoration boxDecorationStyle = BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(color: CustColors.greyish, width: 0.3));

  TextStyle hintTextStyle = const TextStyle(
      fontSize: 10,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w400,
      color: Colors.black);
}
