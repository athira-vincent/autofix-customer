import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/AddMoreServices/add_more_services_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/SelectVehicle/select_vehicle_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<XFile>? _imageFileList;
  List<SearchData>? _searchData;
  File? _image;
  List<File> _images = [];
  final picker = ImagePicker();
  bool _selectService = false;
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    super.initState();
    _searchData = widget.searchData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 36, top: 26, bottom: 10),
            child: Image.asset(
              'assets/images/back.png',
              width: 11,
              height: 19.2,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.only(top: 22),
          child: Text(
            'Choose your service',
            style: TextStyle(
                fontSize: 17,
                color: CustColors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Corbel_Regular'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 34.5, right: 34.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.5),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9.5),
                      child: Image.network(
                        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-chevrolet-corvette-z06-1607016574.jpg?crop=0.737xw:0.738xh;0.181xw,0.218xh&resize=640:*",
                        height: _setValue(141.8),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectVehicleScreen()));
                      },
                      child: Container(
                        alignment: Alignment.bottomRight,
                        width: _setValue(108.8),
                        height: _setValue(24),
                        decoration: BoxDecoration(
                          color: CustColors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              _setValue(_setValue(7.3)),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'CHANGE VECHICLE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Corbel_Regular'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _setValue(17.4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Service",
                      style: TextStyle(
                          color: CustColors.blue,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Corbel_Regular"),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _selectService = !_selectService;
                          });
                        },
                        icon: Icon(
                          _selectService
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_down,
                          color: CustColors.blue,
                        ))
                  ],
                ),
              ),
              _selectService
                  ? GridView.builder(
                      itemCount: _searchData!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return _serviceListItem(
                            widget.searchData[index], index);
                      },
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        //crossAxisSpacing: 40.0,
                        // mainAxisSpacing: 13.9,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 6.5),
                      ),
                    )
                  : Container(width: 0, height: 0),
              Divider(
                height: 20,
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
                    print("checking 0001 ${_searchData!.length}");
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(_setValue(5)),
                    margin: EdgeInsets.only(right: _setValue(10)),
                    width: _setValue(110),
                    height: _setValue(24),
                    decoration: BoxDecoration(
                      color: CustColors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          _setValue(_setValue(12)),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add More Services",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.5,
                                fontFamily: "Corbel_Regular"),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: _setValue(2.3)),
                              child: Image.asset(
                                'assets/images/add_circle.png',
                                width: _setValue(20),
                                height: _setValue(20),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: _setValue(5.8)),
                child: Text(
                  "Add Images",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CustColors.blue,
                      fontSize: 14.5,
                      fontFamily: "Corbel_Regular"),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(top: _setValue(14.4)),
                  child: Row(
                    children: [
                      SizedBox(
                        height: _setValue(56),
                        child: ListView.builder(
                          itemCount: _images.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: _setValue(5.8),
                                      right: _setValue(20)),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(_setValue(12)),
                                    child: Image.file(
                                      File(_images[index].path),
                                      fit: BoxFit.cover,
                                      width: _setValue(50),
                                      height: _setValue(50),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(
                                        top: _setValue(2),
                                        right: _setValue(16)),
                                    child: Image.asset(
                                      'assets/images/close_blue.png',
                                      width: _setValue(14.1),
                                      height: _setValue(14.1),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_images.length < 4) {
                            _showDialogSelectPhoto();
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: _setValue(5.8)),
                            width: _setValue(50),
                            height: _setValue(50),
                            decoration: BoxDecoration(
                              color: Color(0xfff0f2f4),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  _setValue(_setValue(12)),
                                ),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: _setValue(30),
                                height: _setValue(30),
                                decoration: BoxDecoration(
                                  color: Color(0xffe3e4e5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      _setValue(_setValue(25)),
                                    ),
                                  ),
                                ),
                                child: Text('+',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Corbel-Light",
                                        fontSize: 29,
                                        fontWeight: FontWeight.w600,
                                        color: CustColors.blue)),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _setValue(21)),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(top: _setValue(14.4)),
                child: TextFormField(
                  maxLines: 4,
                  minLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfff0f2f4),
                    hintText: "Type your message",
                    hintStyle: TextStyle(
                        color: CustColors.blue,
                        fontFamily: 'Corbel_Light',
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xfff0f2f4),
                      ),
                      borderRadius: BorderRadius.circular(_setValue(5.8)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xfff0f2f4),
                      ),
                      borderRadius: BorderRadius.circular(_setValue(5.8)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceListItem(SearchData searchData, int index) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    searchData.serviceName!,
                    style: TextStyle(
                        color: CustColors.black01,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: "Corbel_Light"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset('assets/images/close_circle.png',
                      width: _setValue(9.2), height: _setValue(9.2)),
                ),
              ],
            ),
          ],
        ));
  }

  _showDialogSelectPhoto() async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
              height: 115.0,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: CustColors.blue,
                    ),
                    title: Text("Camera",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 30);
                      setState(() {
                        if (image != null) {
                          _images.add(File(image.path));
                        }
                      });
                    },
                  ),
                  // Divider(
                  //   height: 1.0,
                  //   color: Colors.grey,
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.image,
                      color: CustColors.blue,
                    ),
                    title: Text("Gallery",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image = (await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 30));

                      setState(() {
                        if (image != null) {
                          _images.add(File(image.path));
                        }
                      });
                    },
                  ),
                ],
              ));
        });
  }
}
