import 'package:flutter/material.dart';

class TodayServiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodayServiceScreenState();
  }
}

class _TodayServiceScreenState extends State<TodayServiceScreen> {
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
      child: Center(child: Text('Today Service Screen')),
    );
  }
}
