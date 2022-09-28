import 'package:flutter/material.dart';

class MechNotificationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MechNotificationList();
  }

}
class _MechNotificationList extends State<MechNotificationList>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        backgroundColor: const Color(0xff173a8d),
        toolbarHeight: 80,
        elevation: 0,
        title: Container(
          child: Text('Notifications',
            style: TextStyle(
              fontFamily: 'SamsungSharpSans-Medium',
              fontSize: 16.7,
            ),),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
            Padding(
              padding: const EdgeInsets.only(left:10.0,top:10.0),
              child: Text('New',
                  style: TextStyle(
                    fontFamily: 'SharpSans-Bold',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),),
            ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff5f4f7),
                            border: Border.all(
                                color: const Color(0xffbcbcbc),
                                width: 0,
                            )
                          ),
                          height: 100,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: ClipOval(
                                      child: Image.network(
                                        'https://i.picsum.photos/id/799/200/200.jpg?hmac=zFQHfBiAYFHDNrr3oX_pQDYz-YWPWTDB3lIszvP8rRY',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.only(left:10.0,right:10,top: 30),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('You have service request from ',
                                            style: TextStyle(
                                              fontFamily: 'Samsung_SharpSans_Medium',
                                              fontSize: 10.0,
                                            ),),
                                          Text('Sade.  ',
                                            style: TextStyle(
                                              fontFamily: 'Samsung_SharpSans_Medium',
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                        ],
                                      ),
                                      SizedBox(height:10),
                                      Text('Emergency service ',
                                        style: TextStyle(
                                          fontFamily: 'Samsung_SharpSans_Medium',
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: Container(
                                      height: 20,
                                      width: 70,

                                      child: TextButton(
                                        onPressed: () {  },

                                        child: const Text ('View Services',
                                        style: TextStyle(
                                          fontFamily: 'SamsungSharpSans-Medium',
                                          fontSize: 07,
                                          color: Colors.black,
                                        ),),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          primary: Color(0xffd3dcf2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      //color: const Color(0xffd3dcf2),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text('1h',
                                      style: TextStyle(
                                        color: const Color(0xffbcbcbc),
                                        fontFamily: 'SamsungSharpSans-Medium',
                                        fontSize: 07,
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Icon(Icons.more_vert,
                                      color: const Color(0xff5b5b5b),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}