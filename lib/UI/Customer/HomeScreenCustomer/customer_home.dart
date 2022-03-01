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

  bool isEmergencyService = true;
  bool isRegularService = false;

   List<Choice> choices = const <Choice>[
    const Choice(title: 'Home', icon: Icons.home),
    const Choice(title: 'relay of urgent mechanic', icon: Icons.contacts),
    const Choice(title: 'Map', icon: Icons.map),
    const Choice(title: 'Phone', icon: Icons.phone),
    const Choice(title: 'Camera', icon: Icons.camera_alt),
    const Choice(title: 'Setting', icon: Icons.settings),
    const Choice(title: 'Album', icon: Icons.photo_album),
    const Choice(title: 'WiFi', icon: Icons.wifi),
  ];


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                searchYouService(),
                serviceBanners(),
                emergencyService(),
                regularService(),
              ],
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
                    Text('Elenjikkal house Empyreal Garden',
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

  Widget serviceBanners() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        child: Image.asset('assets/image/home_customer/banner1.png'),
      )
    );
  }

  Widget emergencyService() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20,5,20,5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: InkWell(
              onTap: (){
                setState(() {

                  if(isEmergencyService==true)
                    {
                      isEmergencyService=false;
                    }
                  else
                    {
                      isEmergencyService=true;
                    }
                });
              },
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
                  Icon(isEmergencyService==true?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right, color: CustColors.light_navy,size: 30,),
                ],
              ),
            ),
          ),
        ),
        isEmergencyService==true
        ? Container(
          child: GridView.builder(
            itemCount:choices.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .94,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context,index,) {
              return GestureDetector(
                onTap:(){

                },
                child:Container(

                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: CustColors.whiteBlueish,
                            borderRadius: BorderRadius.circular(11.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Icon(choices[index].icon,size: 40,color: CustColors.light_navy,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(choices[index].title,
                            style: Styles.textLabelTitle12,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
        : Container()
      ],
    );
  }

  Widget regularService() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20,5,20,5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: InkWell(
              onTap: (){
                setState(() {

                  if(isRegularService==true)
                  {
                    isRegularService=false;
                  }
                  else
                  {
                    isRegularService=true;
                  }
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Regular Services',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_10,
                    ),
                  ),
                  Spacer(),
                  Icon(isRegularService==true?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right, color: CustColors.light_navy,size: 30,),
                ],
              ),
            ),
          ),
        ),
        isRegularService==true
            ? Container(
          child: GridView.builder(
            itemCount:choices.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .94,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context,index,) {
              return GestureDetector(
                onTap:(){

                },
                child:Container(

                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: CustColors.whiteBlueish,
                            borderRadius: BorderRadius.circular(11.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Icon(choices[index].icon,size: 40,color: CustColors.light_navy,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(choices[index].title,
                          style: Styles.textLabelTitle12,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
            : Container()
      ],
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
