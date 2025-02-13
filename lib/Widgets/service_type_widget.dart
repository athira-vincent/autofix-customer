
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class ServiceTypeSelectionWidget extends StatelessWidget {
  Widget titleText;
  String imagePath;
  ServiceTypeSelectionWidget({
    Key? key,
    required this.titleText,
    required this.imagePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.88,
      height: size.height * 0.38,
      color: CustColors.pale_grey,

      child: Column(
        /*mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,*/
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.038),
            child: titleText,
          ),
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.056,
                left: size.width * 0.038,
                right: size.width * 0.038,
            ),
            height: size.height * 0.15,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }



}