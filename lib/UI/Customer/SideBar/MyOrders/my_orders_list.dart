import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';

class MyOrdersListScreen extends StatefulWidget {

  MyOrdersListScreen();

  @override
  State<StatefulWidget> createState() {
    return _MyOrdersListScreenState();
  }
}

class _MyOrdersListScreenState extends State<MyOrdersListScreen> {

  TextEditingController searchController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              appBarCustomUi(),
              searchOrdersUi(),
              myOrdersListUi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'My Orders',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget searchOrdersUi() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 35,
              child:  TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search your order',
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                  prefixIcon:  Icon(Icons.search_rounded, color: CustColors.light_navy),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustColors.whiteBlueish),
                      borderRadius: BorderRadius.circular(0.0)),

                ),
                onChanged: (text) {

                  if (text != null && text.isNotEmpty && text != "" ) {


                  }

                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myOrdersListUi() {
    return  ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount:2,
      itemBuilder: (context, index) {
        return Container(
            width: double.infinity,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            width: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: CustColors.whiteBlueish,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8,8,8,2),
                                    child: Text(
                                      "Delivered",
                                      style: Styles.sparePartNameSubTextBlack,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Text(
                                    "Delivery on jan 20  5pm",
                                    style: Styles.sparePartNameTextBlack17,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,10),
                                  child: Text(
                                    "Clutch assembly",
                                    style: Styles.sparePartNameSubTextBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(Icons.arrow_forward_ios, color: CustColors.light_navy,size: 15,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: CustColors.greyText1,
                    )
                  ],
                ),
              ),
            )
        );
      },
    );
  }

}
