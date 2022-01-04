import 'package:flutter/material.dart';

class MyEarningsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyEarningsScreenState();
  }
}

class _MyEarningsScreenState extends State<MyEarningsScreen> {
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
      child: Center(child: Text('My Earnings Screen')),
    );
  }
}
