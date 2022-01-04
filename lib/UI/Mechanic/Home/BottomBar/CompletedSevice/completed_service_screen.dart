import 'package:flutter/material.dart';

class CompletedServiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompletedServiceScreenState();
  }
}

class _CompletedServiceScreenState extends State<CompletedServiceScreen> {
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
      child: Center(child: Text('Completed Service Screen')),
    );
  }
}
