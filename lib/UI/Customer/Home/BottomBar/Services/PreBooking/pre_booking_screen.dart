import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/AddMoreServices/add_more_services_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreBookingScreen extends StatefulWidget {
  final List<SearchData> searchData;
  final String type;
  PreBookingScreen({required this.searchData, required this.type});
  @override
  State<StatefulWidget> createState() {
    return _PreBookingScreenState();
  }
}

class _PreBookingScreenState extends State<PreBookingScreen> {
  List<SearchData>? _searchData;
  @override
  void initState() {
    super.initState();
    _searchData = widget.searchData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: _searchData!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _serviceListItem(widget.searchData[index], index);
                }),
          ),
          Divider(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                _searchData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMoreServiceScreen(
                              searchData: widget.searchData,
                              type: widget.type.toString(),
                            )));
                setState(() {});
              },
              child: Container(
                color: Colors.yellow,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                width: 170,
                child: Center(
                  child: Text(
                    "+ Add More Services",
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: ""),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Text(
              "Add Images",
              style:
                  TextStyle(color: Colors.black, fontSize: 14, fontFamily: ""),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceListItem(SearchData searchData, int index) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                "${index + 1}. " + searchData.serviceName!,
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: ""),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
