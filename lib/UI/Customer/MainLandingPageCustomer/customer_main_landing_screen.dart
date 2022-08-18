import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/HomeCustomer/customer_home.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_my_profile.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyServices/customer_my_services.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/PaymentScreens/mechanic_waiting_payment.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/ServiceDetailsScreens/cust_service_regular_details_screen.dart';
import 'package:auto_fix/UI/Customer/SideBar/navigation_drawer_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceDetailsScreen/mech_service_regular_details_screen.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/my_cart_screen.dart';
import 'package:auto_fix/UI/SpareParts/SparePartsList/spare_parts_list_screen.dart';
import 'package:auto_fix/Widgets/show_pop_up_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomerMainLandingScreen extends StatefulWidget {

  CustomerMainLandingScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMainLandingScreenState();
  }
}

class _CustomerMainLandingScreenState extends State<CustomerMainLandingScreen> {

  int _index = 0;
  int _counter = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double per = .10;
  double perfont = .10;

  String authToken="",profileImageUrl="";
  String userName="";
  DateTime timeBackPressed = DateTime.now();


  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenNotification(context);
  }

  Future<void> getSharedPrefData() async {
    String localProfileUrl = "", localProfileName = "", localUserId = "";
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      localUserId = shdPre.getString(SharedPrefKeys.userID).toString();
      localProfileName = shdPre.getString(SharedPrefKeys.userName).toString();
      localProfileUrl = shdPre.getString(SharedPrefKeys.profileImageUrl).toString();
      Provider.of<ProfileDataProvider>(context, listen: false).setProfile(localUserId, localProfileName, localProfileUrl);
      print('authToken>>>>>>>>> ' + authToken.toString());
      //print('profileImageUrl>>>>>>>>> CustomerMainLandingScreen' + profileImageUrl.toString());
    });
  }

  _listenNotification(BuildContext context){

    /*FirebaseMessaging.onMessage.listen((RemoteMessage event) {

      print("message received onMessage");

      //Future<void>.delayed(const Duration(seconds: 2));//faking task delay

      setState(() {
        _counter += 1;
        //_notificationPayloadMdl = event.data;
      });
      print("event.notification!.data " + event.data.toString());

      String screen = event.data['screen'];
      if(screen.toString() == "IncomingJobOfferScreen"){
        NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(event.data);

        //var data = message['data'] ?? message;
        String bookingId = event.data['bookingId'];
        print("bookingId >>>>> " + bookingId );

        final provider = Provider.of<LocaleProvider>(context,listen: false);
        provider.setPayload(notificationPayloadMdl);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  IncomingJobRequestScreen(notificationPayloadMdl: notificationPayloadMdl,)
            )).then((value){
        });
      }
    });*/

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {

      print("message received onMessage");

      /*setState(() {
        _counter += 1;
        //_notificationPayloadMdl = event.data;
      });*/
      print("event.notification!.data " + event.data.toString());

      String screen = event.data['screen'];
      /*if(screen.toString() == "MechanicWaitingPaymentScreen"){

        String bookingId = event.data['bookingId'];
        print("bookingId >>>>> " + bookingId );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MechanicWaitingPaymentScreen()));
      }*/
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {

      print("message received onMessageOpenedApp");

      setState(() {
        _counter += 1;
      });

      print("event.notification!.data " + event.data.toString());
      String screen = event.data['screen'];
      if(screen.toString() == "MechanicWaitingPaymentScreen"){

        String bookingId = event.data['bookingId'];
        print("bookingId >>>>> " + bookingId );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MechanicWaitingPaymentScreen()));
      }
      else if(screen.toString() == "customerServiceDetails"){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  CustServiceRegularDetailsScreen(
                  bookingId: event.data['bookingId'],
                  firebaseCollection: event.data['regularType'].toString()  == "1"
                      ?
                  TextStrings.firebase_pick_up
                      : event.data['regularType'].toString()  == "2" ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle ,
                )
            )).then((value){
        });
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("onBackgroundMessage " + message.data.toString());

      setState(() {
        _counter += 1;
        //_notificationPayloadMdl = event.data;
      });
      print("message.notification!.data " + message.data.toString());
      print("event.notification!.data " + message.data.toString());
      String screen = message.data['screen'];
      if(screen.toString() == "MechanicWaitingPaymentScreen"){

        String bookingId = message.data['bookingId'];
        print("bookingId >>>>> " + bookingId );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MechanicWaitingPaymentScreen()));
      }
     else if(screen.toString() == "mechanicServiceDetails"){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  MechServiceRegularDetailsScreen(
                  bookingId: message.data['bookingId'],
                  firebaseCollection: message.data['regularType'].toString()  == "1"
                      ?
                  TextStrings.firebase_pick_up
                      : message.data['regularType'].toString()  == "2" ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle ,
                )
            )).then((value){
        });
      }else if(screen.toString() == "customerServiceDetails"){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  CustServiceRegularDetailsScreen(
                  bookingId: message.data['bookingId'],
                  firebaseCollection: message.data['regularType'].toString()  == "1"
                      ?
                  TextStrings.firebase_pick_up
                      : message.data['regularType'].toString()  == "2" ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle ,
                )
            )).then((value){
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    userName = Provider.of<ProfileDataProvider>(context).getName;
    Size size = MediaQuery.of(context).size;
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
                    child: _index == 0
                        ? Image.asset('assets/image/ic_home_active.png',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                        : SvgPicture.asset(
                      'assets/image/ic_home_inactive.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    'Home',
                    style: _index == 0
                        ? Styles.homeActiveTextStyle
                        : Styles.homeInactiveTextStyle,
                  ),
                ),
              ],
            ),
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                width: _setValue(25),
                height: _setValue(25),
                child: _index == 1
                    ? SvgPicture.asset(
                  'assets/image/ic_home_cart_active.svg',
                  width: _setValue(26),
                  height: _setValue(26),
                )
                    : Image.asset(
                  'assets/image/ic_home_cart_inactive.png',
                  width: _setValue(28),
                  height: _setValue(28),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'Cart',
                  style: _index == 1
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                width: _setValue(25),
                height: _setValue(25),
                child:
                _index == 2
                    ? SvgPicture.asset(
                      'assets/image/ic_home_service_active.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                    : Image.asset(
                  'assets/image/ic_home_service_inactive.png',
                  width: _setValue(26),
                  height: _setValue(26),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'My services ',
                  style: _index == 2
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                width: _setValue(25),
                height: _setValue(25),
                child: _index == 3
                    ? SvgPicture.asset(
                  'assets/image/ic_home_profile_active.svg',
                  width: _setValue(26),
                  height: _setValue(26),
                )
                    : Image.asset(
                  'assets/image/ic_home_profile_inactive.png',
                  width: _setValue(26),
                  height: _setValue(26),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'Profile',
                  style: _index == 3
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
    ];
    return WillPopScope(
      onWillPop: () async{
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if(isExitWarning){
          /* final message = 'Press back again to exit';
            Fluttertoast.showToast(msg: message,fontSize: 18);
            */
          return false;
        }else{
          //Fluttertoast.cancel();
          ShowPopUpWidget().showPopUp(context);
          return true;
        }
      },
      child: Scaffold(
        drawer: CustomerNavigationDrawerScreen(),
        key: scaffoldKey,
        appBar: _index == 0
          ? PreferredSize(
              preferredSize: Size.fromHeight(40.0 + MediaQuery.of(context).padding.top),
              child: AppBar(
                actions: [],
                automaticallyImplyLeading: false,
                flexibleSpace: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 21, top: 20 + MediaQuery.of(context).padding.top),
                      child: GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          child: Image.asset(
                            'assets/image/ic_drawer.png',
                            width: 30,
                            height: 30,
                          )),
                    ),

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 25 + MediaQuery.of(context).padding.top, left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              //"Hi $_userName",
                              "Welcome",
                              style: Styles.homeWelcomeTextStyle,
                            ),
                            Expanded(
                              child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text:   " $userName",
                                  style: Styles.homeNameTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(text: " !",
                                      style: Styles.homeWelcomeSymbolTextStyle,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /*Container(
                      margin: EdgeInsets.only(
                           top: 25 + MediaQuery.of(context).padding.top,
                        right: size.width * 4.2/100
                      ),
                      child: Stack(
                        children: [
                              GestureDetector(
                              onTap: () {},
                                child: SvgPicture.asset(
                                  'assets/image/notification_icon.svg',
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                          Positioned(
                            right: 0,
                            child: _counter > 0 ? Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: new Text(
                               '$_counter',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ) : Container(),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
                backgroundColor: Colors.white,
                shadowColor: Colors.white,
              ),
            )
          : PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container()
            ),
        body:

        Center(
            child:  IndexedStack(
              index: _index,
              children: <Widget> [
                HomeCustomerUIScreen(),
                MyCartScreen(),
                CustomerMyServicesScreen(),
                CustomerMyProfileScreen(isEnableEditing: false,),
              ],
            )
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            child: SizedBox(
              height: size.height * 0.098,
              child: BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                    fontFamily: 'Corbel_Light',
                    fontWeight: FontWeight.w600,
                    fontSize: 0),
                unselectedLabelStyle: TextStyle(
                    fontFamily: 'Corbel_Light',
                    fontWeight: FontWeight.w600,
                    fontSize: 0),
                items: bottomNavigationBarItems,
                currentIndex: _index,
                //backgroundColor: CustColors.blue,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                onTap: (index) {
                  setState(() {
                    _index = index;
                    //getSharedPrefData();
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

}