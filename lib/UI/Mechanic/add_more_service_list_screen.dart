import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddMoreServicesListScreen extends StatefulWidget {

  AddMoreServicesListScreen();

  @override
  State<StatefulWidget> createState() {
    return _AddMoreServicesListScreenState();
  }
}

class _AddMoreServicesListScreenState extends State<AddMoreServicesListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 6 / 100,
                right: size.width * 6 / 100,
                top: size.height * 3.3 / 100,
                bottom: size.height * 2.7 / 100,
              ),
              color: Colors.purpleAccent,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Add additional faults",
                      style: TextStyle(
                        fontSize: 15.3,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w600,
                        color: CustColors.light_navy,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: size.width * 2.5 / 100,
                       // right: size.width * ,
                        top: size.height * 2.1 / 100,
                        //bottom: size.height * ,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                              color: CustColors.pinkish_grey,
                              width: 0.3
                          )
                      ),
                     // color: Colors.green,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/image/search_service.svg"),
                         /* TextFormField(
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            style: Styles.searchTextStyle01,
                            decoration: InputDecoration(
                                hintText: "Search Your Service",
                                border: InputBorder.none,
                                contentPadding: new EdgeInsets.only(bottom: 15),
                                hintStyle: Styles.searchTextStyle01
                            ),
                          ),*/
                        ],
                      ),

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
