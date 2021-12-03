import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpairPartsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpairPartsScreenState();
  }
}

class _SpairPartsScreenState extends State<SpairPartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            47.3,
          ),
        ),
      ),
      child: Center(child: Text('Spare Parts')),
    );
  }
}
