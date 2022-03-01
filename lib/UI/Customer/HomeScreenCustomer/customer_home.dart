import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constants/cust_colors.dart';

class HomeCustomerUIScreen extends StatefulWidget {

  final String userType;
  final String userCategory;


  HomeCustomerUIScreen({required this.userType,required this.userCategory});

  @override
  State<StatefulWidget> createState() {
    return _HomeCustomerUIScreenState();
  }
}

class _HomeCustomerUIScreenState extends State<HomeCustomerUIScreen> {

  TextEditingController searchController = new TextEditingController();
  String? filter;

   List<Choice> choices = const <Choice>[
    const Choice(title: 'Home', icon: Icons.home),
    const Choice(title: 'Contact', icon: Icons.contacts),
    const Choice(title: 'Map', icon: Icons.map),
    const Choice(title: 'Phone', icon: Icons.phone),
    const Choice(title: 'Camera', icon: Icons.camera_alt),
    const Choice(title: 'Setting', icon: Icons.settings),
    const Choice(title: 'Album', icon: Icons.photo_album),
    const Choice(title: 'WiFi', icon: Icons.wifi),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  searchYouService(),
                  emergencyService(),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  Widget searchYouService() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex:1,
            child: SizedBox(
              height: 35,
              child: new TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search your Services',
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  prefixIcon:  Icon(Icons.search_rounded, color: CustColors.light_navy),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.light_navy),
                      borderRadius: BorderRadius.circular(11.0)),

                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: CustColors.light_navy,size: 35,),
              SizedBox(
                width: 50,
                child: Column(
                  children: [
                    Text('Search your Services',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget emergencyService() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 35.0,
        margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
        decoration: BoxDecoration(
            border: Border.all(
              color: CustColors.light_navy,
            ),
            borderRadius: BorderRadius.circular(11.0)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Emergency Services',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
                style: Styles.textLabelTitle_10,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_forward_ios, color: CustColors.light_navy,size: 15,),
            ),
          ],
        ),
      ),
    );
  }


}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}



class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
