
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class UserCategorySelectionWidget extends StatelessWidget {
  String titleText;
  String imagePath;
  UserCategorySelectionWidget({
    Key? key,
    required this.titleText,
    required this.imagePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 18,),
      child: Container(
        height: size.height * 0.163,
        width: size.width * 0.757,
        color: Colors.white,
        margin: EdgeInsets.only(
            top: size.height * 0.074,
            left: size.width * 0.10,
            right: size.width * 0.10,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              /*margin: EdgeInsets.only(
                top: size.height * 0.153,
                bottom: size.height * 0.15,
                left: size.width * 0.092,
                right: size.width * 0.625,
              ),*/
                child: Image.asset(imagePath,
                width: size.width * 0.210,
                height: size.height * 0.620,)
            ),

            Text(titleText,style: titleTextStyle,)
          ],
        ),
      ),
    );
  }

  final titleTextStyle = TextStyle(
    color: CustColors.light_navy,
    fontSize: 11.7,
    fontFamily: 'Samsung_SharpSans_Medium',
    fontWeight: FontWeight.bold,
  );

}