import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChangeDeliveryAddressScreen extends StatefulWidget {

  ChangeDeliveryAddressScreen();

  @override
  State<StatefulWidget> createState() {
    return _ChangeDeliveryAddressScreenState();
  }
}

class _ChangeDeliveryAddressScreenState extends State<ChangeDeliveryAddressScreen> {

  bool? isAddressDefault;
  late bool isAddressSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAddressSelected = false;
  }

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
              color: Colors.green,
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
                        color: Colors.white70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select delivery address "),
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 2 / 100,
                                right: size.width * 2 / 100,
                                top: size.height * 1 / 100,
                                bottom: size.height * 1 / 100
                              ),
                              decoration: boxDecorationStyle,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/image/ic_add.svg",
                                    height: size.height * 3 / 100,width: size.width * 3 / 100,),
                                  Text("Add new address ")
                                ],
                              ),
                            ),
//---------------- replaced by list view ---------------
//---------------- List view items ---------------------
                            InkWell(
                              onTap: (){
                                setState(() {
                                  isAddressSelected = true;
                                });
                              },
                                child: addressWidget(size,true)),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    isAddressSelected = true;
                                  });
                                },
                                child: addressWidget(size,false)),
// ---------------- List view items ends here ----------
                            Container(
                              decoration: boxDecorationStyle,
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/image/ic_info_blue_white.svg",
                                    height: size.height * 3 / 100,width: size.width * 3 / 100,),
                                  Text("You  selected a different address as before. \nDelivery Charges may vary for this address . ")
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
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
            'Change delivery address ',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget saveChangeButton(Size size){
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(
          right: size.width * 5 / 100,
          bottom: size.height * 3 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
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

  BoxDecoration boxDecorationStyle = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
          color: CustColors.greyish,
          width: 0.3
      )
  );

  Widget addressWidget(Size size,bool isAddressDefault,){
    return Container(
      decoration: boxDecorationStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("George Dola "),
              isAddressDefault
                  ? Container(
                      padding: EdgeInsets.only(
                        left: size.width * 2 / 100,
                        right: size.width * 2 / 100,
                        top: size.height * .5 / 100,
                        bottom: size.height * .5 / 100,
                      ),
                      margin: EdgeInsets.only(
                        left: size.width * 2 / 100
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.3),
                          ),
                          border: Border.all(
                              color: CustColors.greyish,
                              width: 0.3
                          ),
                        color: CustColors.very_light_blue
                      ),
                      child: Text("Default"),
              )
                  : Container(),
              Spacer(),
              isAddressSelected
                  ? Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: SvgPicture.asset("assets/image/ic_selected_blue_white_tick.svg",
                        height: size.height * 3 / 100,
                        width: size.width * 3 / 100,),
              ),
                  )
                  : Container(),
            ],
          ),
          Text("+234 9213213"),
          Text("Savannah estate, plot 176"),
          Text("Beside oando filling station"),
          Text("Abuja Nigeria")
        ],
      ),
    );
  }

}