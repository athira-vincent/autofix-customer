import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();

    _getSearchResult();
  }

  @override
  void dispose() {
    super.dispose();
    _searchResultBloc.dispose();
  }

  _getSearchResult() async {
    _searchResultBloc.postSearchResult.listen((value) {
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
          _regularSearchDataList = [];
          _emergencySearchDataList = [];
          for (int i = 0; i < value.data!.serviceListAll!.data!.length; i++) {
            if (value.data!.serviceListAll!.data![i].type == "1") {
              int flag = 0;
              for (int j = 0; j < widget.searchData.length; j++) {
                if (value.data!.serviceListAll!.data![i].id ==
                    widget.searchData[j].id) {
                  flag = 1;
                  break;
                }
              }
              if (flag == 0) {
                _regularSearchDataList!
                    .add(value.data!.serviceListAll!.data![i]);
              }
            } else if (value.data!.serviceListAll!.data![i].type == "2") {
              int flag = 0;
              for (int j = 0; j < widget.searchData.length; j++) {
                if (value.data!.serviceListAll!.data![i].id ==
                    widget.searchData[j].id) {
                  flag = 1;
                  break;
                }
              }
              if (flag == 0) {
                _emergencySearchDataList!
                    .add(value.data!.serviceListAll!.data![i]);
              }
            }
          }
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
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(),
          actions: [
            IconButton(
              onPressed: () {
                List<SearchData> _searchData = [];
                _searchData = widget.searchData;
                Navigator.pop(context, _searchData);
              },
              color: Colors.black,
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          searchTextBox(),
          Expanded(
            child: SingleChildScrollView(child: listViewPlaces()),
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

  _filter(String searchQuery) {
    // List<DataItem> _filteredList = dataItem01
    //     .where((DataItem user) =>
    //         user.locationName.toLowerCase().contains(searchQuery.toLowerCase()))
    //     .toList();
    // _streamController.sink.add(_filteredList);
    //setState(() {});
    if (searchQuery.length > 2) {
      _searchResultBloc.postSearchResultRequest(1, 100, searchQuery);
    }
  }

  Widget searchTextBox() {
    return Container(
      margin: EdgeInsets.only(
        left: 22,
        right: 22,
      ),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        controller: textEditingController,
        onChanged: _filter,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Roboto_Regular',
        ),
        decoration: InputDecoration(
          hintText: "Search Text",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.5),
            borderSide: new BorderSide(
              color: CustColors.borderColor,
              width: 0.3,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          hintStyle: TextStyle(
            color: Color.fromARGB(49, 3, 43, 83),
            fontSize: 14,
          ),
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
              itemCount: _regularSearchDataList!.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return _regularServicesListItem(_regularSearchDataList![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _regularServicesListItem(SearchData regularList) {
    return GestureDetector(
      onTap: () {
        List<SearchData> regularList01 = [];
        List<SearchData> _searchData = [];
        _searchData = widget.searchData;
        regularList01.add(regularList);
        _searchData.add(regularList);
        Navigator.pop(context, _searchData);
      },
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
              itemCount: _emergencySearchDataList!.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return _emergencyServicesListItem(
                    _emergencySearchDataList![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _emergencyServicesListItem(SearchData emergencyList) {
    return GestureDetector(
      onTap: () {
        List<SearchData> regularList01 = [];
        regularList01.add(emergencyList);
        List<SearchData> _searchData = [];
        _searchData = widget.searchData;
        _searchData.add(emergencyList);
        Navigator.pop(context, _searchData);
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
