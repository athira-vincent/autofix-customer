import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyProfileScreenState();
  }
}

class _MyProfileScreenState extends State<MyProfileScreen> {
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
      child: Center(child: Text('My Profile Screen')),
    );
  }
}
