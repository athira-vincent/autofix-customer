import 'package:flutter/material.dart';

class UpcomingServiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpcomingServiceScreenState();
  }
}

class _UpcomingServiceScreenState extends State<UpcomingServiceScreen> {
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
      child: Center(child: Text('Upcoming Service Screen')),
    );
  }
}
