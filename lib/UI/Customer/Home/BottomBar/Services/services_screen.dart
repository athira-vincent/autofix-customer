import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/pre_booking_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ServicesScreenState();
  }
}

class _ServicesScreenState extends State<ServicesScreen> {
  RegularServicesBloc _regularServicesBloc = RegularServicesBloc();
  EmergencyServicesBloc _emergencyServicesBloc = EmergencyServicesBloc();
  List<EmergencyList>? _emergencyList = [];
  List<RegularList>? _regularList = [];
  @override
  void dispose() {
    super.dispose();
    _regularServicesBloc.dispose();
    _emergencyServicesBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _regularServicesBloc.postRegularServicesRequest(1, 100);
    _getRegularServices();
    _emergencyServicesBloc.postEmergencyServicesRequest(1, 100);
    _getEmergencyServices();
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
          _regularList = value.data!.emergencyList;
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
          _emergencyList = value.data!.emergencyList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              47.3,
            ),
          ),
        ),
        child: Column(
          children: [
            _reminder(),
            _searchBox(),
            _regularServices(),
            _emergencyServices(),
          ],
        ),
      ),
    );
  }

  Widget _reminder() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 29.9, bottom: 15.9),
          child: Text(
            'You have a service on',
            style: TextStyle(
                fontSize: 17,
                color: CustColors.blue,
                fontFamily: 'Corbel_Bold'),
          ),
        ),
        Text(
          '2-12-2021',
          style: TextStyle(
              fontSize: 17,
              color: CustColors.blue,
              fontFamily: 'Montserrat_Light'),
        ),
        Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.only(top: 16),
          decoration:
              BoxDecoration(color: CustColors.blue, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '9:11 AM',
              style: TextStyle(
                  fontSize: 14.5,
                  color: Colors.white,
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
        height: 36.3,
        margin: EdgeInsets.only(left: 41, right: 41, top: 17.3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
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
              margin: EdgeInsets.only(left: 37.9),
              child: Text(
                'Search Your Services…',
                style: TextStyle(
                    fontFamily: 'Corbel_Light',
                    fontSize: 12,
                    color: CustColors.greyText),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.only(right: 4.5),
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
                  margin: EdgeInsets.only(right: 4.5),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 10.4,
                    height: 10.4,
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
      margin: EdgeInsets.only(top: 33.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 21),
            child: Text(
              'Regular Services',
              style: TextStyle(
                  fontSize: 12,
                  color: CustColors.blue01,
                  fontFamily: 'Corbel_Regular'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 29.1),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 13.9,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.6),
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

  Widget _regularServicesListItem(RegularList regularList) {
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
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: CustColors.lightGrey, width: 1.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    7.8,
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(12),
                child: CachedNetworkImage(
                  imageUrl: "https://picsum.photos/200",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 9.1),
              child: Text(
                regularList.serviceName.toString(),
                style: TextStyle(
                    fontSize: 9.5,
                    color: CustColors.blue,
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
      margin: EdgeInsets.only(top: 29.1),
      padding: EdgeInsets.only(top: 28.9),
      decoration: BoxDecoration(
        color: CustColors.bgGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              60,
            ),
            topRight: Radius.circular(60)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 21,
            ),
            child: Text(
              'Emergency Services',
              style: TextStyle(
                  fontSize: 12,
                  color: CustColors.blue01,
                  fontFamily: 'Corbel_Regular'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 29.1),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 54.0,
                mainAxisSpacing: 13.9,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.5),
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

  Widget _emergencyServicesListItem(EmergencyList emergencyList) {
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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: CustColors.lightGrey, width: 1.3),
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  7.8,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(12),
              child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/200",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 9.1),
            child: Text(
              emergencyList.serviceName.toString(),
              style: TextStyle(
                  fontSize: 9.5,
                  color: CustColors.blue,
                  fontFamily: 'Corbel_Light'),
            ),
          ),
        ],
      ),
    );
  }
}
