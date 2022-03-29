import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Widgets/screen_size.dart';

class AddMoreServicesListScreen extends StatefulWidget {

  final bool isAddService;

  AddMoreServicesListScreen({ required this.isAddService});

  @override
  State<StatefulWidget> createState() {
    return _AddMoreServicesListScreenState();
  }
}

class _AddMoreServicesListScreenState extends State<AddMoreServicesListScreen> {

  List<String> serviceList = [
    "A","Spareparts delivery01","c","Spareparts delivery","d","e","Spareparts delivery05","g","h","Spareparts delivery02","j","K","l"
  ];
  List<bool>? _serviceIsChecked;
  List<String>? selectedServiceList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _serviceIsChecked = List<bool>.filled(serviceList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 6 / 100,
                right: size.width * 6 / 100,
                top: size.height * 3.3 / 100,
                bottom: size.height * 2 / 100,
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Add additional faults",
                      style: TextStyle(
                        fontSize: 15.3,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w600,
                        color: CustColors.light_navy,
                      ),
                    ),
                  ),

                  addServicesSearchArea(size),

                  servicesListArea(size),

                  widget.isAddService
                      ? InkWell(
                          onTap: (){
                            print("selected service list - length >>>>>>>>" + selectedServiceList!.length.toString());
                            Navigator.pop(context,selectedServiceList);
                          },
                            child: nextButton(size)
                        )
                      : Container(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addServicesSearchArea(Size size,){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.026,
          left: size.width * 0.025,
          right: size.width * 0.078,
        ),
        height: ScreenSize().setValue(35),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              ScreenSize().setValue(5),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: CustColors.pinkish_grey,
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
              margin: EdgeInsets.only(left: ScreenSize().setValue(18)),
              child: Icon(
                Icons.search,
                size: 18,
                color: CustColors.light_navy,
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: ScreenSize().setValue(14)),
                alignment: Alignment.center,
                height: ScreenSize().setValue(35),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    style: Styles.searchTextStyle01,
                    decoration: InputDecoration(
                        hintText: "Search Your  additional services ",
                        border: InputBorder.none,
                        contentPadding: new EdgeInsets.only(bottom: 16),
                        hintStyle: Styles.searchTextStyle01
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /*child: Container(
                      margin: EdgeInsets.only(
                        left: size.width * 2.5 / 100,
                       // right: size.width * ,
                        top: size.height * 2.1 / 100,
                        //bottom: size.height * ,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                              color: CustColors.pinkish_grey,
                              width: 0.3
                          )
                      ),
                     // color: Colors.green,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/image/search_service.svg"),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            style: Styles.searchTextStyle01,
                            decoration: InputDecoration(
                                hintText: "Search Your Service",
                                border: InputBorder.none,
                                contentPadding: new EdgeInsets.only(bottom: 15),
                                hintStyle: Styles.searchTextStyle01
                            ),
                          ),
                        ],
                      ),

                    ),*/
    );
  }

  Widget servicesListArea(Size size){
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(
         // left: size.width * 6 / 100,
        //  right: size.width * 6 / 100,
          top: size.height * 2.6 / 100,
          //bottom: size.height * 1.9 / 100,
        ),
        color: CustColors.pale_grey,
        child: Container(
          margin: EdgeInsets.only(
            left: size.width * 5.9 / 100,
            right: size.width * 5.9 / 100,
            top: size.height * 3.7 / 100,
            // bottom: size.height * ,
          ),
          child: serviceList.length != 0
              ? ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: serviceList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    final serviceName = serviceList[index];
                    /*print("widget.isAddService >>>>>>> " + widget.isAddService.toString());
                    if(widget.isAddService != true){
                      Navigator.pop(context,serviceName);
                    }*/
                    //final brandId = regularServiceList[index].id;
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
                    //print(brandId);
                  },
                  child: serviceListItems(size,index) );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(
                    //top: ScreenSize().setValue(1),
                    left: size.width * 3 / 100,
                    right: size.width * 1 / 100,
                    //bottom: ScreenSize().setValue(1),
                  ),
                  child: Divider(
                    height: 0,
                  ));
            },
          )
              : Center(
            child: Text("No Results found."),
          ),
        ),
      ),
    );
  }

  Widget serviceListItems(Size size,int index){
    return Container(
      child: Row(
        children: [

          Transform.scale(
            scale: .6,
            child: widget.isAddService
                ? Checkbox(
              activeColor: CustColors.light_navy,
              value: _serviceIsChecked![index],
              onChanged: (bool? val){
                setState(() {
                  this._serviceIsChecked![index] = val!;
                  //isChecked ? false : true;
                  val ?
                  selectedServiceList!.add(serviceList[index])
                      :
                  selectedServiceList!.remove(serviceList[index]);
                  print("sgsjhgj 001 $val");
                  print(">>>>>>>>> Selected Make List data " + selectedServiceList!.length.toString());
                });
              },
            )
                : Container(),
          ),

          Text(
            '${serviceList[index].toString()}',
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Samsung_SharpSans_Medium",
              fontWeight: FontWeight.w400,
              color: CustColors.almost_black
            ),
          ),
          /*SizedBox(
            width: size.width / 100 * 18,
          ),*/

        ],
      ),
    ) ;
  }

  Widget nextButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 11.5 / 100,
            top: size.height * 1.9 / 100,
            bottom: size.height * .7 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 5.9 / 100,
          right: size.width * 5.9 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Next",
          style: TextStyle(
            fontSize: 14.3,
            fontWeight: FontWeight.w600,
            fontFamily: "Samsung_SharpSans_Medium",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
