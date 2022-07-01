import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDeliveryAddressScreen extends StatefulWidget {

  AddDeliveryAddressScreen();

  @override
  State<StatefulWidget> createState() {
    return _AddDeliveryAddressScreenState();
  }
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: Container(
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
                      onTap: (){
                        print("on tap saveAddress");
                        Navigator.pop(context);
                      },
                      child: saveAddressButton(size)
                  )
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
          borderRadius: BorderRadius.only(
            //Radius.circular(8),
          ),
          border: Border.all(
              color: CustColors.almost_black,
              width: 0.3
          )
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: CustColors.warm_grey03),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Address ',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget useMyLocationButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          //top: size.height * .5 / 100,
          //bottom: size.height * .5 / 100,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: size.width * 1.5 / 100
              ),
              width: size.width * 4 / 100,
              height: size.height * 4 / 100,
                child: SvgPicture.asset("assets/image/ic_zoom_location.svg",)
            ),
            Text(
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

  Widget addressTypeOptions(Size size, String text, String imagePath){
    return Container(
      decoration: boxDecorationStyle,
      padding: EdgeInsets.only(
        left: size.width * 3 / 100,
        right: size.width * 3 / 100,
        top: size.height * 1 / 100,
        bottom: size.height * 1 /100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * 1 / 100),
            child: SvgPicture.asset(imagePath,
            height: size.height * 2.3 / 100,
            width: size.width * 2.3 / 100,),
          ),
          Text(text,style: hintTextStyle,)
        ],
      ),
    );
  }

  Widget locationForm(Size size){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name",
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
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch : "Name").nameChecking,
            //controller: _nameController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              //hintText:  "name",
              border: UnderlineInputBorder(
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
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ),
        Text("Phone number", style: hintTextStyle,),
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
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch : "Phone").phoneNumChecking,
            //controller: _nameController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              // hintText:  "phone",
              border: UnderlineInputBorder(
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
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ),
        Text("Pincode ", style: hintTextStyle,),
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
                      FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z ]')),
                    ],
                    validator: InputValidator(
                        ch : "Pincode").phoneNumChecking,
                    //controller: _nameController,
                    cursorColor: CustColors.whiteBlueish,
                    decoration: InputDecoration(
                      isDense: true,
                      // hintText:  "PinCode",
                      border: UnderlineInputBorder(
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
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CustColors.greyish,
                          width: .5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.8,
                        horizontal: 0.0,
                      ),
                      hintStyle: Styles.textLabelSubTitle,),
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
        Text("Locality", style: hintTextStyle,),

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
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch : "Phone").phoneNumChecking,
            //controller: _nameController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              // hintText:  "phone",
              border: UnderlineInputBorder(
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
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ),
        Text("Type of address", style: hintTextStyle,),
        Container(
          margin: EdgeInsets.only(
            top: size.height * 1.7 / 100,
            bottom: size.height * 1.7 / 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: addressTypeOptions(size,"Home","assets/image/ic_home_outline.svg")),
              SizedBox(
                width: size.width * 1.5 / 100,
              ),
              Flexible(child: addressTypeOptions(size,"Work","assets/image/ic_work_outline.svg")),
              SizedBox(
                width: size.width * 1.5 / 100,
              ),
              Flexible(child: addressTypeOptions(size,"Other","assets/image/ic_location_outline.svg")),
            ],
          ),
        ),
      ],
    );
  }

  Widget saveAddressButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
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
        child: Text(
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
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
          color: CustColors.greyish,
          width: 0.3
      )
  );

  TextStyle hintTextStyle = TextStyle(
      fontSize: 10,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w400,
      color: Colors.black
  );
}