import 'package:flutter/material.dart';


class MechanicListScreen extends StatefulWidget {

  final String bookingId;
  final String authToken;
  final  List<String> serviceIds;
  final String serviceType;


  MechanicListScreen({required this.bookingId,required this.authToken,required this.serviceIds,required this.serviceType});


  @override
  State<StatefulWidget> createState() {
    return _MechanicListScreenState();
  }
}

class _MechanicListScreenState extends State<MechanicListScreen> {

  String authToken = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
    );
  }

}