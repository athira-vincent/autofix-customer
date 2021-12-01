import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/NoResult/no_result_found_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMoreServiceScreen extends StatefulWidget {
  final List<SearchData> searchData;
  final String type;
  AddMoreServiceScreen({required this.searchData, required this.type});
  @override
  State<StatefulWidget> createState() {
    return _AddMoreServiceScreenState();
  }
}

class _AddMoreServiceScreenState extends State<AddMoreServiceScreen> {
  final SearchResultBloc _searchResultBloc = SearchResultBloc();
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<SearchData>? _regularSearchDataList = [];
  List<SearchData>? _emergencySearchDataList = [];
  final SearchResultBloc _searchResultBlocRegular = SearchResultBloc();
  final SearchResultBloc _searchResultBlocEmergency = SearchResultBloc();
  List<EmergencyData>? _emergencyList = [];
  List<RegularData>? _regularList = [];
  RegularServicesBloc _regularServicesBloc = RegularServicesBloc();
  EmergencyServicesBloc _emergencyServicesBloc = EmergencyServicesBloc();
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    super.initState();
    _getSearchResult();
    _getAllServices();
    _getRegularServices();
    _getEmergencyServices();
  }

  @override
  void dispose() {
    super.dispose();
    _regularServicesBloc.dispose();
    _emergencyServicesBloc.dispose();
    _searchResultBlocRegular.dispose();
    _searchResultBlocEmergency.dispose();
  }

  _getSearchResult() async {
    _searchResultBlocRegular.postSearchResult.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          // _regularSearchDataList = [];
          _regularSearchDataList = value.data!.serviceListAll!.data!;
        });
      }
    });
    _searchResultBlocEmergency.postSearchResult.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          // _emergencySearchDataList = [];
          _emergencySearchDataList = value.data!.serviceListAll!.data;
        });
      }
    });
  }

  _getAllServices() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    _regularServicesBloc.postRegularServicesRequest(
        1, 6, shdPre.getString(SharedPrefKeys.token)!);
    _emergencyServicesBloc.postEmergencyServicesRequest(
        1, 8, shdPre.getString(SharedPrefKeys.token)!);
  }

  _getRegularServices() async {
    _regularServicesBloc.postRegularServices.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
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
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              List<SearchData> _searchData = [];
              _searchData = widget.searchData;
              Navigator.pop(context, _searchData);
            },
            child: Container(
              width: _setValue(25),
              height: _setValue(25),
              margin: EdgeInsets.only(
                  top: _setValue(15),
                  bottom: _setValue(15),
                  left: _setValue(21)),
              child: Image.asset('assets/images/circle_back.png'),
            ),
          ),
          title: Text(
            'Add More Services',
            style: TextStyle(
              color: CustColors.blue,
              fontSize: 17,
              fontFamily: 'Corbel_Regular',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchTextBox(),
              Container(
                  margin: EdgeInsets.only(
                    left: _setValue(31),
                    right: _setValue(31),
                    top: _setValue(8.8),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 0,
                        blurRadius: 1.5,
                        offset: Offset(0, .5),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        _setValue(5.8),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      regularServicesListView(),
                      emergencyServicesListView(),
                    ],
                  )),
              _regularServices(),
              _emergencyServices(),
            ],
          ),
        ),
      ),
    );
  }

  Widget regularServicesListView() {
    return StreamBuilder<SearchResultMdl>(
        stream: _searchResultBlocRegular.postSearchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return textEditingController.text.length > 2
                ? Center(child: CircularProgressIndicator())
                : Container();
          }
          if (!snapshot.hasError) {
            print("First${snapshot.hasData}");
            if (snapshot.hasData) {
              return Column(
                children: [
                  _regularSearchDataList!.length != 0
                      ? _regularServicesSearch()
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                ],
              );
            }
            return Container();
          } else {
            return Center(
              child: Text(
                "No Location Found...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            );
          }
        });
  }

  Widget emergencyServicesListView() {
    return StreamBuilder<SearchResultMdl>(
        stream: _searchResultBlocEmergency.postSearchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return textEditingController.text.length > 2
                ? Center(child: CircularProgressIndicator())
                : Container();
          }
          if (!snapshot.hasError) {
            print("First${snapshot.hasData}");
            if (snapshot.hasData) {
              return Column(
                children: [
                  _emergencySearchDataList!.length != 0
                      ? _emergencyServicesSearch()
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                ],
              );
            }
            return Container();
          } else {
            return Center(
              child: Text(
                "No Location Found...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            );
          }
        });
  }

  _filter(String searchQuery) async {
    // List<DataItem> _filteredList = dataItem01
    //     .where((DataItem user) =>
    //         user.locationName.toLowerCase().contains(searchQuery.toLowerCase()))
    //     .toList();
    // _streamController.sink.add(_filteredList);
    //setState(() {});
    if (searchQuery.length > 2) {
      SharedPreferences shdPre = await SharedPreferences.getInstance();
      _searchResultBlocRegular.postSearchResultRequest(1, 100, searchQuery,
          shdPre.getString(SharedPrefKeys.token).toString(), "1");
      _searchResultBlocEmergency.postSearchResultRequest(1, 100, searchQuery,
          shdPre.getString(SharedPrefKeys.token).toString(), "2");
    }
  }

  Widget searchTextBox() {
    return Container(
      height: _setValue(36.3),
      margin: EdgeInsets.only(
          left: _setValue(41), right: _setValue(41), top: _setValue(9.6)),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: _setValue(23.4)),
              alignment: Alignment.center,
              height: _setValue(36.3),
              child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textAlignVertical: TextAlignVertical.center,
                  focusNode: focusNode,
                  controller: textEditingController,
                  onChanged: _filter,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Corbel_Regular',
                      fontWeight: FontWeight.w600,
                      color: CustColors.blue),
                  decoration: InputDecoration(
                    hintText: "Search Your Services…",
                    border: InputBorder.none,
                    contentPadding: new EdgeInsets.only(bottom: 15),
                    hintStyle: TextStyle(
                      color: CustColors.greyText,
                      fontSize: 12,
                      fontFamily: 'Corbel-Light',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (textEditingController.text.length > 2 &&
                  _emergencySearchDataList!.length == 0 &&
                  _regularSearchDataList!.length == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoResultFoundScreen()));
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: _setValue(25),
                  height: _setValue(25),
                  margin: EdgeInsets.only(right: _setValue(19)),
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
                  margin: EdgeInsets.only(right: _setValue(19)),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: _setValue(10.4),
                    height: _setValue(10.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _regularServicesSearch() {
    return Container(
      padding: EdgeInsets.only(
        top: _setValue(13.8),
        right: _setValue(18.5),
        left: _setValue(18.5),
        bottom: _setValue(8.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: _setValue(7.9)),
            child: Text(
              'Regular Services',
              style: TextStyle(
                fontSize: 12,
                color: CustColors.blue01,
                fontFamily: 'Corbel_Regular',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _regularSearchDataList!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    List<SearchData> regularList01 = [];
                    SearchData searchData = SearchData();
                    searchData.description =
                        _regularSearchDataList![index].description;
                    searchData.fee = _regularSearchDataList![index].fee;
                    searchData.icon = _regularSearchDataList![index].icon;
                    searchData.id =
                        _regularSearchDataList![index].id.toString();
                    searchData.serviceName =
                        _regularSearchDataList![index].serviceName;
                    searchData.status = _regularSearchDataList![index].status;
                    searchData.type = _regularSearchDataList![index].type;
                    regularList01 = widget.searchData;
                    regularList01.add(searchData);

                    Navigator.pop(context, regularList01);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _regularSearchDataList![index].serviceName!,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: CustColors.black01,
                          //fontWeight: FontWeight.normal,
                          fontFamily: 'Corbel_Regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: .4,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget _emergencyServicesSearch() {
    return Container(
      padding: EdgeInsets.only(
        top: _setValue(13.8),
        right: _setValue(18.5),
        left: _setValue(18.5),
        bottom: _setValue(8.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: _setValue(7.9)),
            child: Text(
              'Regular Services',
              style: TextStyle(
                fontSize: 12,
                color: CustColors.blue01,
                fontFamily: 'Corbel_Regular',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _emergencySearchDataList!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    List<SearchData> regularList01 = [];
                    SearchData searchData = SearchData();
                    searchData.description =
                        _emergencySearchDataList![index].description;
                    searchData.fee = _emergencySearchDataList![index].fee;
                    searchData.icon = _emergencySearchDataList![index].icon;
                    searchData.id =
                        _emergencySearchDataList![index].id.toString();
                    searchData.serviceName =
                        _emergencySearchDataList![index].serviceName;
                    searchData.status = _emergencySearchDataList![index].status;
                    searchData.type = _emergencySearchDataList![index].type;
                    regularList01.add(searchData);
                    Navigator.pop(context, regularList01);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _emergencySearchDataList![index].serviceName!,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: CustColors.black01,
                          //fontWeight: FontWeight.normal,
                          fontFamily: 'Corbel_Regular',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: .4,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget _regularServices() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: _setValue(13.9)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: _setValue(23)),
            child: Text(
              'Regular Services',
              style: TextStyle(
                fontSize: 12,
                color: CustColors.blue01,
                fontFamily: 'Corbel_Regular',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: _setValue(44), bottom: _setValue(30.5)),
            margin: EdgeInsets.only(top: _setValue(15)),
            decoration: BoxDecoration(
              color: CustColors.bgGrey,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 40.0,
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

  Widget _regularServicesListItem(RegularData regularList) {
    return InkWell(
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
        Navigator.pop(context, regularList01);
      },
      child: Column(
        children: [
          Container(
            width: _setValue(50),
            height: _setValue(50),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: CustColors.lightGrey, width: 1.3),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  _setValue(7.8),
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(_setValue(12)),
              child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/200",
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
                fontFamily: 'Corbel_Light',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emergencyServices() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: _setValue(26.4)),
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
                fontFamily: 'Corbel_Regular',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: _setValue(44), bottom: _setValue(30.5)),
            margin: EdgeInsets.only(top: _setValue(15)),
            decoration: BoxDecoration(
              color: CustColors.bgGrey,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 13.9,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.2),
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
    return InkWell(
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
        Navigator.pop(context, regularList01);
      },
      child: Column(
        children: [
          Container(
            width: _setValue(50),
            height: _setValue(50),
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
              margin: EdgeInsets.all(_setValue(12)),
              child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/200",
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
                fontFamily: 'Corbel_Light',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewPlaces() {
    return StreamBuilder<SearchResultMdl>(
        stream: _searchResultBloc.postSearchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return textEditingController.text.length > 2
                ? Center(child: CircularProgressIndicator())
                : Container();
          }
          if (!snapshot.hasError) {
            print("First${snapshot.hasData}");
            if (snapshot.hasData) {
              return Column(
                children: [
                  _regularSearchDataList!.length != 0
                      ? widget.type == "1"
                          ? _regularServices()
                          : Container(
                              width: 0,
                              height: 0,
                            )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  _emergencySearchDataList!.length != 0
                      ? widget.type == "2"
                          ? _emergencyServices()
                          : Container(
                              width: 0,
                              height: 0,
                            )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                ],
              );
            }
            return Container();
          } else {
            return Center(
              child: Text(
                "No Location Found...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            );
          }
        });
  }
}
