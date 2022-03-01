import 'package:flutter/material.dart';

class CustomerHome extends StatefulWidget {

  CustomerHome();

  @override
  State<StatefulWidget> createState() {
    return _CustomerHomeState();
  }
}

class _CustomerHomeState extends State<CustomerHome> {

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
      child: Center(child: Text('Home')),
    );
  }

}
