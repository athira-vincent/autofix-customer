import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_mdl.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/services_fee_list/service_fee_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';

class SelectServiceScreen extends StatefulWidget {
  List<AllServiceFeeData> serviceList;
  final String type;

  SelectServiceScreen({required this.serviceList, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _SelectServiceScreenState();
  }
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  TextEditingController _rateController = TextEditingController();
  //List<AllServiceFeeData>? serviceData = [];
  List<AllServiceFeeData>? selectedServiceList = [];
  List<AllServiceFeeData>? regularServiceList = [];
  List<AllServiceFeeData>? emergencyServiceList = [];
  List<bool>? _emergencyIsChecked;
  List<bool>? _regularIsChecked;

  @override
  void initState() {
    super.initState();
    final serviceList = widget.serviceList.splitMatch(widget.serviceList);
    regularServiceList = serviceList.regular;
    emergencyServiceList = serviceList.emergency;
    _emergencyIsChecked = List<bool>.filled(emergencyServiceList!.length, false);
    _regularIsChecked = List<bool>.filled(regularServiceList!.length, false);
  }


  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
/*regularServiceList!.add(widget.serviceList.singleWhere((element) => element.type == "1"));
    emergencyServiceList!.add(widget.serviceList.singleWhere((element) => element.type == "2"));*/

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
                List<AllServiceFeeData> _searchData = [];
                _searchData = selectedServiceList!;
                Navigator.pop(context, _searchData);
              },
            )
          ],
          title: Text(
            widget.type == "2" ? 'Select Emergency Services' : 'Select Regular Services',
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
                            hintText: "Search Your Service",
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
                child: widget.type == '2' ?
                    regularServiceList!.length != 0
                        ? ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: regularServiceList!.length,
                            itemBuilder: (context, index) {
                              print(regularServiceList![index].minAmount.toString() + ">>>Min amt");
                              _rateController.text = regularServiceList![index].minAmount.toString();
                              return InkWell(
                                  onTap: () {
                                    final brandName = regularServiceList![index].serviceName;
                                    final brandId = regularServiceList![index].id;
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
                                            value: _regularIsChecked![index],
                                            onChanged: (bool? val){
                                            setState(() {
                                              this._regularIsChecked![index] = val!;
                                              //isChecked ? false : true;
                                              val ?
                                                  selectedServiceList!.add(regularServiceList![index])
                                                  :
                                                  selectedServiceList!.remove(regularServiceList![index]);
                                              print(">>>>>>>>> Selected Make List data " + regularServiceList!.length.toString());
                                            });
                                          },
                                          ),
                                        ),

                                        Text(
                                          '${regularServiceList![index].serviceName}',
                                          style: TextStyle(
                                              fontSize: ScreenSize().setValueFont(14),
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff0b0c0d)),
                                        ),

                                        SizedBox(
                                          width: mediaQueryData.size.width / 100 * 25,
                                        ),

                                        Container(
                                          height: ScreenSize().setValue(25),
                                          width: mediaQueryData.size.width / 100 * 20,
                                          margin: EdgeInsets.only(left: ScreenSize().setValue(5)),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                ScreenSize().setValue(5),
                                              ),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: CustColors.border_grey,
                                                spreadRadius: .5,
                                                blurRadius: 1.5,
                                              ),
                                            ],
                                          ),
                                          child:
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenSize().setValue(2),
                                                left: ScreenSize().setValue(2),
                                                right: ScreenSize().setValue(2)),
                                            alignment: Alignment.center,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 8,
                                                    child:  Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        //initialValue: regularServiceList![index].minAmount.toString(),
                                                        /*validator:
                                                        InputValidator(ch: "Phone number")
                                                            .phoneNumChecking,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(15),
                                                        ],*/
                                                        maxLines: 1,
                                                        //focusNode: _phoneFocusNode,
                                                        textAlignVertical:
                                                        TextAlignVertical.center,
                                                        keyboardType: TextInputType.phone,
                                                        controller: _rateController,
                                                        style: TextStyle(
                                                          fontFamily: 'Corbel_Light',
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize:
                                                          ScreenSize().setValueFont(10
                                                          ),
                                                        ),
                                                        enableSuggestions: false,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(
                                                              Icons.attach_money_sharp,
                                                              size: 20,
                                                              color: Colors.black,
                                                            ),
                                                            suffixIcon: Icon(
                                                              Icons.edit_outlined,
                                                              size: 18,
                                                              color: _regularIsChecked![index] ? Colors.black : CustColors.border_grey,
                                                            ),
                                                            isDense: true,
                                                            contentPadding:
                                                            EdgeInsets.symmetric(
                                                              vertical:
                                                              ScreenSize().setValue(7.8),
                                                            ),
                                                            hintStyle: TextStyle(
                                                              fontFamily: 'Corbel_Light',
                                                              //color: Colors.white.withOpacity(.60),
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize:
                                                              ScreenSize().setValueFont(12),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),

                                           /*
                                           * Row(

                                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [

                                                        Container(
                                                          //margin: EdgeInsets.only(left: ScreenSize().setValue(8)),
                                                          child: Icon(
                                                            Icons.attach_money_sharp,
                                                            size: 20,
                                                            color: Colors.black,
                                                          ),
                                                        ),

                                                        Container(
                                                          margin: EdgeInsets.only(left: 1,right: 1),
                                                          child: TextFormField(
                                                            initialValue: '${regularServiceList![index].minAmount.toString()}',
                                                            controller: _rateController,
                                                            decoration: InputDecoration(
                                                                hintText: '${regularServiceList![index].fee}',
                                                                hintStyle: TextStyle(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            style: TextStyle(
                                                                fontSize: ScreenSize().setValueFont(14),
                                                                fontFamily: 'Corbel_Regular',
                                                                fontWeight: FontWeight.w600,
                                                                color: Color(0xff0b0c0d)),
                                                          ),),

                                                        Container(
                                                          margin: EdgeInsets.only(left: ScreenSize().setValue(1)),
                                                          child: Icon(
                                                            Icons.edit_outlined,
                                                            size: 18,
                                                            color: _regularIsChecked![index] ? Colors.black : CustColors.border_grey,
                                                          ),
                                                        ),
                                                      ],
                                                    )*/

                                        ),

                                     /*   _regularIsChecked![index] ?
                                        Container(
                                          margin: EdgeInsets.only(right: 0),
                                          child: Text(
                                            '${regularServiceList![index].fee}',
                                            style: TextStyle(
                                                fontSize: ScreenSize().setValueFont(14),
                                                fontFamily: 'Corbel_Regular',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff0b0c0d)),
                                          ),
                                        ) :Container(),*/

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
                          )
                :
                    emergencyServiceList!.length != 0
                        ? ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: emergencyServiceList!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    final brandName =
                                        emergencyServiceList![index].serviceName;
                                    final brandId = emergencyServiceList![index].id;
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
                                      value: _emergencyIsChecked![index],
                                      onChanged: (bool? val){
                                        setState(() {
                                          this._emergencyIsChecked![index] = val!;
                                          //isChecked ? false : true;
                                          val ?
                                          selectedServiceList!.add(emergencyServiceList![index])
                                              :
                                          selectedServiceList!.remove(emergencyServiceList![index]);
                                          print(">>>>>>>>> Selected Make List data " + selectedServiceList!.length.toString());
                                        });
                                      },
                                    ),
                                  ),

                                  Text(
                                    '${emergencyServiceList![index].serviceName}',
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
                    )
              ),
            ),

            //_isChecked!.contains(true)
            selectedServiceList!.length >= 3
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
                        Map<List<AllServiceFeeData>?, String> myData = new Map();
                        SelectedData data = SelectedData(selectedServiceList,"rate");
                        Navigator.pop(context, data);
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

class ListMatch<T> {
  List<AllServiceFeeData> emergency= [];
  List<AllServiceFeeData> regular = [];
}

extension SplitMatch<T> on List<T>{
  ListMatch<T> splitMatch(List<AllServiceFeeData> list){
    final listMatch = ListMatch<T>();
    list.forEach((element) {
      if(element.type!.toString() == "2"){
        listMatch.regular.add(element);
      }else{
        listMatch.emergency.add(element);
      }
    });
        return listMatch;
  }
}

class SelectedData {
  final String rate;
  final List<AllServiceFeeData>? services;
  SelectedData(this.services, this.rate);
}