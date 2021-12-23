import 'dart:ffi';
import 'dart:math';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicListScreen extends StatefulWidget {
  final String serviceID;
  const MechanicListScreen({Key? key, required this.serviceID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicListScreenState();
  }
}

class _MechanicListScreenState extends State<MechanicListScreen> {
  final MechanicListBloc _mechanicListBloc = MechanicListBloc();

  List<Datum> mechanicListData = [];
  Datum? mechanicListDataVal;

  String token = "";
  double km = 0;

  @override
  void initState() {
    super.initState();
    _addToken();
    _getViewVehicle();
  }

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
    _mechanicListBloc.postMechanicListRequest(token, 1, 10, widget.serviceID);
    //_allMakeBloc.postAllMakeRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
    _mechanicListBloc.dispose();
  }

  _getViewVehicle() async {
    _mechanicListBloc.postViewMechanicList.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          print("errrrorr 01");
          //_isLoading = false;
          print(">>>>>mechanic Api Data >>> " +
              "id : " +
              value.data!.mechanicList!.totalItems.toString() +
              " >>>>>>>>>");
          mechanicListData = value.data!.mechanicList!.data!;
          // value.data.mechanicList.mechanicListData[0].id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      //icon: Image.asset("assets/images/icon_back_arrow.png"),
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: CustColors.blue,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 25, top: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mechanics",
                      style: TextStyle(
                        fontFamily: "Corbel_Regular",
                        color: CustColors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 68, top: 1),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select a mechanic near you ! ",
                  style: TextStyle(
                    fontFamily: "Corbel_Light",
                    color: CustColors.black01,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 2),
                  padding: EdgeInsets.all(5),
                  child: buildList(),
                ),
              ),
              //buildList(),
            ],
          ),
          //child: buildList(),
        ),
      ),
    );
  }

  Widget buildList() => ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemCount: mechanicListData.length,
        itemBuilder: (context, index) {
          String? mechName = mechanicListData[index].mechanicName;
          String? address = mechanicListData[index].address;
          String? phone = mechanicListData[index].phoneNo;
          double? mechanic_lat = mechanicListData[index].latitude;
          double? mechanic_lng = mechanicListData[index].longitude;

          //int imageIndex = index +1;
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MechanicProfileScreen(
                            // serviceID: '1',
                            id: mechanicListData[index].id.toString(),
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              /*decoration: BoxDecoration( //                    <-- BoxDecoration
            border: Border(bottom: BorderSide()),
                  ),*/
              child: Card(

                child: ListTile(
                  contentPadding: EdgeInsets.only(
                      top: 4.8, bottom: 4.8, left: 12.5, right: 23),

                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        'http://www.londondentalsmiles.co.uk/wp-content/uploads/2017/06/person-dummy.jpg'
                        //'https://source.unsplash.com/random?sig=$index'
                        ),
                  ),
                  title: Text(
                    mechName!,
                    style: TextStyle(
                      fontFamily: "Corbel_Regular",
                      fontSize: 14,
                      color: CustColors.black01,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text(mechName!),
                          _ratingBar,
                          Text(
                            calculateDistance(10.1964, 76.3879, mechanic_lat, mechanic_lng).round().toString() + " Km",
                            style: TextStyle(
                              fontFamily: "Corbel-Light",
                              color: CustColors.white02,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        //child: Text("sub-title $index")
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text(mechName!),
                          Text(
                            "21 Reviews",
                            style: TextStyle(
                              fontFamily: "Corbel-Light",
                              color: CustColors.white02,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "\$123",
                            style: TextStyle(
                              fontFamily: "Corbel-Light",
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ], //child: Text("sub-title $index")
                      ),
                    ],
                  ),
                  //onTap: () => selectItem(item),
                ),
              ),
            ),
          );
        },
      );

  Widget _ratingBar = RatingBarIndicator(
    rating: 2.5,
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: ScreenSize().setValue(12.5),
    unratedColor: Color(0xffdfe0e2),
    direction: Axis.horizontal,
  );

  void selectItem(String itemSelected) {
    final snackBar = SnackBar(
      content: Text(
        "Selected item $itemSelected",
        style: TextStyle(fontSize: 24),
      ),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
