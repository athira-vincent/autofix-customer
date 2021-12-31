
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
 bool isFirst,isSecond,isThird;
  IndicatorWidget({
    Key? key,
    required this.isFirst,
    required this.isSecond,
    required this.isThird
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isFirst ? filledRectangle : transparentRectangle,
          isSecond ? filledRectangle : transparentRectangle,
          isThird ? filledRectangle : transparentRectangle
        ],
      ),
    );
  }
  Widget filledRectangle = Container(
    margin: EdgeInsets.only(left: 3,right: 3),
    color: Colors.white,
    height: 3,
    width: 20,
  );
  Widget transparentRectangle = Container(
    margin: EdgeInsets.only(left: 3,right: 3),
    height: 3,
    width: 20,
    //color: Colors.yellow,
    decoration: BoxDecoration(
      border: Border.all(
        color: CustColors.cloudy_blue,
        style: BorderStyle.solid,
        width: .6,
      ),
    ),
  );
}