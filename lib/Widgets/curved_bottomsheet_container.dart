import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvedBottomSheetContainer extends StatefulWidget {
  final double? percentage;
  final Widget? child;

  const CurvedBottomSheetContainer({
    this.percentage,
    this.child,
  });

  @override
  _CurvedBottomSheetContainerState createState() => _CurvedBottomSheetContainerState();
}

class _CurvedBottomSheetContainerState extends State<CurvedBottomSheetContainer> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        height: MediaQuery.of(context).size.height * double.parse(widget.percentage.toString()),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child:  widget.child,
    )
    );
  }
}
