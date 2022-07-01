
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
 bool isFirst,isSecond,isThird,isFourth;
  IndicatorWidget({
    Key? key,
    required this.isFirst,
    required this.isSecond,
    required this.isThird,
    required this.isFourth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isFirst ? filledRectangle : transparentRectangle,
          isSecond ? filledRectangle : transparentRectangle,
          isThird ? filledRectangle : transparentRectangle,
          isFourth ? filledRectangle : transparentRectangle
        ],
      ),
    );
  }
  Widget filledRectangle = Container(
    margin: EdgeInsets.only(left: 6,right: 6),
    color: CustColors.azure,
    height: 3.5,
    width: 30,
  );
  Widget transparentRectangle = Container(
    margin: EdgeInsets.only(left: 6,right: 6),
    height: 3.5,
    width: 30,
    color: CustColors.greyish_purple,
  );
}