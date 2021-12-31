import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';

class SelectBrandScreen extends StatefulWidget {
  final List<MakeDetails> brandData;
  final String type;

  SelectBrandScreen({required this.brandData, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _SelectBrandScreenState();
  }
}

class _SelectBrandScreenState extends State<SelectBrandScreen> {
  List<MakeDetails>? makeDetailsList = [];
  List<MakeDetails>? selectedMakeList = [];

  List<bool>? _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.brandData.length, false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Image.asset(
                "assets/images/icon_close_blue.png",
                height: 15,
                width: 15,
              ),
              onPressed: () {
                List<MakeDetails> _searchData = [];
                _searchData = makeDetailsList!;
                Navigator.pop(context, _searchData);
              },
            )
          ],
          title: Text(
            'Select Your Brand',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'Corbel_Bold',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          children: [
            Container(
              height: ScreenSize().setValue(36.3),
              margin: EdgeInsets.only(top: ScreenSize().setValue(15)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ScreenSize().setValue(10),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustColors.border_grey,
                    spreadRadius: 0,
                    blurRadius: 1.5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: ScreenSize().setValue(20)),
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: CustColors.greyText,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: ScreenSize().setValue(15)),
                      alignment: Alignment.center,
                      height: ScreenSize().setValue(36.3),
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textAlignVertical: TextAlignVertical.center,
                          /*onChanged: (text) {
                           setState(() {
                             makeDetails!.clear();
                             //_countryData.clear();
                             _loadingBrand = true;
                           });
                           _allMakeBloc.searchMake(text);
                         },*/
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Corbel_Regular',
                              fontWeight: FontWeight.w600,
                              color: CustColors.borderColor),
                          decoration: InputDecoration(
                            hintText: "Search Your Brand",
                            border: InputBorder.none,
                            contentPadding: new EdgeInsets.only(bottom: 15),
                            hintStyle: TextStyle(
                              color: CustColors.greyText,
                              fontSize: 15,
                              fontFamily: 'Corbel-Light',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                //padding: EdgeInsets.only(top: ScreenSize().setValue(22.4)),
                margin: EdgeInsets.only(/*left: ScreenSize().setValue(5),*/
                    top: ScreenSize().setValue(22.4)),
                child: widget.brandData.length != 0
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.brandData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                final brandName =
                                    widget.brandData[index].makeName;
                                final brandId = widget.brandData[index].id;
                                          /* setState(() {
                                     _brandController.text =
                                         brandName.toString();
                                     selectedBrandId =
                                         int.parse(brandId!);
                                     _modelController.clear();
                                     selectedModelId = 0;
                                     _engineController.clear();
                                     selectedEngineId = 0;
                                     _allModelBloc
                                         .postAllModelDataRequest(
                                         selectedBrandId!,
                                         token);
                                   });*/
                                print(">>>>>");
                                print(brandId);
                                //Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: Row(
                                  children: [

                                    Transform.scale(
                                      scale: .8,
                                      child: Checkbox(
                                        value: _isChecked![index],
                                        onChanged: (bool? val){
                                        setState(() {
                                          this._isChecked![index] = val!;
                                          //isChecked ? false : true;
                                          val ?
                                              selectedMakeList!.add(widget.brandData[index])
                                              :
                                              selectedMakeList!.remove(widget.brandData[index]);
                                          print(">>>>>>>>> Selected Make List data " + selectedMakeList!.length.toString());
                                        });
                                      },
                                      ),
                                    ),

                                    Text(
                                      '${widget.brandData[index].makeName}',
                                      style: TextStyle(
                                          fontSize: ScreenSize().setValueFont(14),
                                          fontFamily: 'Corbel_Regular',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0b0c0d)),
                                    ),
                                  ],
                                ),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  top: ScreenSize().setValue(10),
                                  left: 5,
                                  right: 5,
                                  bottom: ScreenSize().setValue(10)),
                              child: Divider(
                                height: 0,
                              ));
                        },
                      )
                    : Center(
                        child: Text('No Results found.'),
                      ),
              ),
            ),

            //_isChecked!.contains(true)
            selectedMakeList!.length >= 3
                ?
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 8, bottom: 6,left: 75,right: 75),
                    //padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: CustColors.blue,
                      border: Border.all(
                        color: CustColors.blue,
                        style: BorderStyle.solid,
                        width: 0.70,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:  MaterialButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Corbel_Bold',
                            fontSize:
                            ScreenSize().setValueFont(14.5),
                            fontWeight: FontWeight.w800),
                      ),
                      onPressed: () {
                        Navigator.pop(context, selectedMakeList);
                        },
                    ),
                  )
                :
                  Container(),
          ],
        ),

      ),
    );
  }
}
