import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerMyVehicleScreen extends StatefulWidget {

  CustomerMyVehicleScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyVehicleScreenState();
  }
}

class _CustomerMyVehicleScreenState extends State<CustomerMyVehicleScreen> {

  String authToken = "";
  bool _isLoadingPage = false;
  bool _isLoadingButton = false;

  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenServiceListResponse();


  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());

    });
  }

  _listenServiceListResponse() {

  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: CustColors.blue,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              appBarCustomUi(),
                              titleUi(),
                            ],
                          )
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isLoadingPage,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustColors.peaGreen),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }


  Widget appBarCustomUi() {
    return Stack(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              'My Vechicles',
              textAlign: TextAlign.center,
              style: Styles.appBarTextWhite,
            ),
            Spacer(),

          ],
        ),
      ],
    );
  }

  Widget titleUi() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Cars',
                textAlign: TextAlign.center,
                style: Styles.badgeTextStyle1,
              ),
            ),
          ],
        ),
        Container(
          height: 180,
          margin: EdgeInsets.all(0),
          child: ListView.builder(
            itemCount: imageList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i, ){
              //for onTap to redirect to another screen
              return Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: i==0 ? Colors.white : Colors.transparent,)
                        ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            imageList[i],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }


}
