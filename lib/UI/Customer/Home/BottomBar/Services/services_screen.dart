import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/pre_booking_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ServicesScreenState();
  }
}

class _ServicesScreenState extends State<ServicesScreen> {
  RegularServicesBloc _regularServicesBloc = RegularServicesBloc();
  EmergencyServicesBloc _emergencyServicesBloc = EmergencyServicesBloc();
  List<EmergencyData>? _emergencyList = [];
  List<RegularData>? _regularList = [];
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void dispose() {
    super.dispose();
    _regularServicesBloc.dispose();
    _emergencyServicesBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getAllServices();
    _getRegularServices();

    _getEmergencyServices();
  }

  _getAllServices() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    _regularServicesBloc.postRegularServicesRequest(
        1, 100, shdPre.getString(SharedPrefKeys.token)!);
    _emergencyServicesBloc.postEmergencyServicesRequest(
        1, 100, shdPre.getString(SharedPrefKeys.token)!);
  }

  _getRegularServices() async {
    _regularServicesBloc.postRegularServices.listen((value) {
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
          _regularList = value.data!.emergencyList!.regularData;
        });
      }
    });
  }

  _getEmergencyServices() async {
    _emergencyServicesBloc.postEmergencyServices.listen((value) {
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
          _emergencyList = value.data!.emergencyList!.regularData;
        });
      }
    });
  }

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
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: _setValue(75)),
        child: Column(
          children: [
            _reminder(),
            _searchBox(),
            _regularServices(),
            _emergencyServices(),
            _adsList(),
          ],
        ),
      ),
    );
  }

  Widget _reminder() {
    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.only(top: _setValue(29.9), bottom: _setValue(15.9)),
          child: Text(
            'You have a service on',
            style: TextStyle(
                fontSize: 17,
                color: CustColors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Corbel_Bold'),
          ),
        ),
        Text(
          '2-12-2021',
          style: TextStyle(
              fontSize: 17,
              color: CustColors.blue,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat_Light'),
        ),
        Container(
          width: _setValue(69),
          height: _setValue(69),
          margin: EdgeInsets.only(top: _setValue(16)),
          decoration:
              BoxDecoration(color: CustColors.blue, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '9:11 AM',
              style: TextStyle(
                  fontSize: 14.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat_Light'),
            ),
          ),
        )
      ],
    );
  }

  Widget _searchBox() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SearchResultScreen()));
      },
      child: Container(
        height: _setValue(36.3),
        margin: EdgeInsets.only(
            left: _setValue(41), right: _setValue(41), top: _setValue(17.3)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              _setValue(20),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: _setValue(37.9)),
              child: Text(
                'Search Your Services…',
                style: TextStyle(
                    fontFamily: 'Corbel_Light',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: CustColors.greyText),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: _setValue(25),
                  height: _setValue(25),
                  margin: EdgeInsets.only(right: _setValue(4.5)),
                  decoration: BoxDecoration(
                    color: CustColors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: _setValue(4.5)),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: _setValue(10.4),
                    height: _setValue(10.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _regularServices() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: _setValue(33.9)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: _setValue(21)),
            child: Text(
              'Regular Services',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CustColors.blue01,
                  fontFamily: 'Corbel_Regular'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: _setValue(29.1),
                left: _setValue(21),
                right: _setValue(21)),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: _setValue(22),
                mainAxisSpacing: _setValue(13.9),
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.40),
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _regularList!.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return _regularServicesListItem(_regularList![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _regularServicesListItem(RegularData regularList) {
    return GestureDetector(
      onTap: () {
        List<SearchData> regularList01 = [];
        SearchData searchData = SearchData();
        searchData.description = regularList.description;
        searchData.fee = regularList.fee;
        searchData.icon = regularList.icon;
        searchData.id = regularList.id.toString();
        searchData.serviceName = regularList.serviceName;
        searchData.status = regularList.status;
        searchData.type = regularList.type;
        regularList01.add(searchData);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreBookingScreen(
                      searchData: regularList01,
                      type: regularList.type.toString(),
                    )));
      },
      child: Container(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: MediaQuery.of(context).size.width -
                    ((_setValue(21) + _setValue(21)) + (22 * 3)),
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: CustColors.lightGrey, width: 1.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      _setValue(7.8),
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(_setValue(9)),
                  child: CachedNetworkImage(
                    imageUrl: "https://picsum.photos/200",
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _setValue(9.1)),
              child: Text(
                regularList.serviceName.toString(),
                style: TextStyle(
                    fontSize: 9.5,
                    color: CustColors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Corbel_Light'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emergencyServices() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: _setValue(29.1)),
      padding: EdgeInsets.only(top: _setValue(28.9), bottom: 10),
      decoration: BoxDecoration(
        color: CustColors.bgGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              60,
            ),
            topRight: Radius.circular(_setValue(60))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: _setValue(21),
            ),
            child: Text(
              'Emergency Services',
              style: TextStyle(
                  fontSize: 12,
                  color: CustColors.blue01,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Corbel_Regular'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: _setValue(29.1),
                left: _setValue(21),
                right: _setValue(21),
                bottom: _setValue(15)),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: _setValue(62.0),
                mainAxisSpacing: _setValue(13.9),
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.40),
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _emergencyList!.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return _emergencyServicesListItem(_emergencyList![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emergencyServicesListItem(EmergencyData emergencyList) {
    return GestureDetector(
      onTap: () {
        List<SearchData> regularList01 = [];
        SearchData searchData = SearchData();
        searchData.description = emergencyList.description;
        searchData.fee = emergencyList.fee;
        searchData.icon = emergencyList.icon;
        searchData.id = emergencyList.id.toString();
        searchData.serviceName = emergencyList.serviceName;
        searchData.status = emergencyList.status;
        searchData.type = emergencyList.type;
        regularList01.add(searchData);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreBookingScreen(
                      searchData: regularList01,
                      type: emergencyList.type.toString(),
                    )));
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: MediaQuery.of(context).size.width -
                  ((_setValue(21) + _setValue(21)) + (60 * 2)),
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: CustColors.lightGrey, width: 1.3),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    _setValue(7.8),
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(_setValue(9)),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://cdn-icons-png.flaticon.com/512/833/833015.png",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: _setValue(9.1)),
            child: Text(
              emergencyList.serviceName.toString(),
              style: TextStyle(
                  fontSize: 9.5,
                  color: CustColors.blue,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Corbel_Light'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _adsList() {
    return Container(
      margin: EdgeInsets.only(top: _setValue(10)),
      height: _setValue(109),
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _adsListItem();
        },
      ),
    );
  }

  Widget _adsListItem() {
    return Container(
      margin: EdgeInsets.only(right: _setValue(4.7)),
      child: Image.network(
        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-chevrolet-corvette-z06-1607016574.jpg?crop=0.737xw:0.738xh;0.181xw,0.218xh&resize=640:*",
        fit: BoxFit.cover,
        width: _setValue(178),
        height: _setValue(109),
      ),
    );
  }
}
