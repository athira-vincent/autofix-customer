import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/AddRegularMoreServices/add_more_regular_service_list_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleRegularServiceScreen extends StatefulWidget {

  final String serviceIds;
  final String serviceType;
  final CategoryList? categoryList;

  ScheduleRegularServiceScreen
      ({
        required this.serviceIds,
        required this.serviceType,
        required this.categoryList
      });

  @override
  State<StatefulWidget> createState() {
    return _ScheduleRegularServiceScreenState();
  }
}

class _ScheduleRegularServiceScreenState extends State<ScheduleRegularServiceScreen> {


  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  String authToken="";

  TextEditingController _serviceTypeController = TextEditingController();
  FocusNode _serviceTypeFocusNode = FocusNode();

  TextEditingController _serviceDateController = TextEditingController();
  FocusNode _serviceDateFocusNode = FocusNode();


  List<Service> selectedCategoryList =[];

  String selectedServiceModel = "";

  List<String> serviceModelList = [
    "Mobile Mechanic",
    "Pick up & Drop off",
    "Take Vehicle to Mechanic"
  ];
  DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.categoryList!.service![0].regularStatus = 1;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Stack(
                children: [
                  Image.asset("assets/image/img_schedule_service_bg.png"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appBarUiWidget(size),
                      serviceCartWidget(size),
                      totalEstimateWidget(size),
                      dateTextSelection(size),
                      serviceTypeTextSelection(size),
                      findMechanicButtonWidget(size)
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
    });
  }


  Widget appBarUiWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 2.5 / 100,
      ),
      child: Row(
        children: [
          InkWell(
            onTap:()
            {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,15,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Schedule your service",
                  textAlign: TextAlign.start,
                  style: Styles.appBarTextWhite01,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceCartWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        right: size.width * 6 /100,
        top: size.height * 1 / 100,
      ),
      padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 2.5 / 100,
          top: size.height * 2.5 / 100,
          bottom: size.height * 2.5 / 100
      ),
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(1),
            ),
            boxShadow: [
              BoxShadow(
                color: CustColors.pinkish_grey03,
                spreadRadius: 0,
                blurRadius: 1.5,
              ),
            ],
            border: Border.all(
            color: CustColors.pinkish_grey03,
            width: 0.3,
          ),
        ),
      child: Column(
        children: [
          listHeaderWidget(size),
          selectedCategoryList.length != 0
              ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: selectedCategoryList.length,
                itemBuilder: (context, index) {
                  return serviceListItemWidget(size,index);
                },
              )
              : Container(),

        ],

      ),
    );
  }

  Widget totalEstimateWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        right: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 1 / 100,
      ),
      padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 2.5 / 100,
          top: size.height * 2.5 / 100,
          bottom: size.height * 2.5 / 100
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ),
        boxShadow: [
          BoxShadow(
            color: CustColors.pinkish_grey03,
            spreadRadius: 0,
            blurRadius: 1.5,
          ),
        ],
        border: Border.all(
          color: CustColors.pinkish_grey03,
          width: 0.3,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
            bottom: size.height * 1.5 / 100
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text("Total service estimate",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "SharpSans_Bold",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .4,
                    wordSpacing: .5
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 8 / 100,
                  width: size.width * 12 / 100,
                  decoration: BoxDecoration(
                    color: CustColors.white_02,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(
                      color: CustColors.pinkish_grey03,
                      width: 0.3,
                    ),
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "abc",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .7,
                        height: 1.7,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .3 / 100,
                    ),
                    Text("Estimated time",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .7,
                        height: 1.3,
                      ),
                    ),
                    Text("20:00 Min",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .2,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 2.5 / 100,
                    ),
                    Text("Estimated price",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .7,
                        height: 1.3,
                      ),
                    ),
                    Text("₦ 80",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .2,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listHeaderWidget(Size size){
    return Container(
      padding: EdgeInsets.only(
          bottom: size.height * 2.5 / 100
      ),
      child: Row(
        children: [
          Container(
            child: Text("Service cart ",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "SharpSans_Bold",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .4,
                  wordSpacing: .5
              ),
            ),
          ),
          Spacer(),
          Container(
            child: Text("Add more services",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Samsung_SharpSans_Medium",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .4,
                  wordSpacing: .4
              ),
            ),
          ),
          SizedBox(
            width: size.width * .7 / 100,
          ),
          InkWell(
            onTap: (){
              print(" on Tap - Add More");
              _awaitReturnValueFromSecondScreenOnAdd(context);
            },
            child: SvgPicture.asset("assets/image/CustomerType/add_car_plus.svg",
              height: size.height * 4 / 100,),
          ),
        ],
      ),
    );
  }

  Widget serviceListItemWidget(Size size, int index){
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        //color: CustColors.white_02,
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
        border: Border.all(
          color: CustColors.pinkish_grey04,
          width: 0.1,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                selectedCategoryList.removeAt(index);
              });
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [

                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Container(
                      height: size.height * 7 / 100,
                      width: size.width * 13 / 100,
                      decoration: BoxDecoration(
                          color: CustColors.whiteBlueish,
                          borderRadius: BorderRadius.circular(11.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child:selectedCategoryList[index].icon.toString() != ""
                            ? Image.network(selectedCategoryList[index].icon,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.stop,size: 35,color: CustColors.light_navy,),
                        //child: Icon(choices[0].icon,size: 35,color: CustColors.light_navy,),
                      ),
                    ),
                  ),
                ),
                Image.asset("assets/image/ic_delete_blue_white.png",
                  height: size.height * 2.5 / 100,
                ),



              ],
            ),
          ),

          SizedBox(width: 5,),
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Text(
                  selectedCategoryList[index].serviceName,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Samsung_SharpSans_Medium",
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    wordSpacing: .5,
                    letterSpacing: .7,
                    height: 1.7,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text("Estimated time",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Samsung_SharpSans_Medium",
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          wordSpacing: .5,
                          letterSpacing: .7,
                          height: 1.3,
                        ),
                      ),
                      Text("20:00 Min",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "SharpSans_Bold",
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          wordSpacing: .5,
                          letterSpacing: .2,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width:5,
                  ),
                  Column(
                    children: [
                      Text("Estimated price",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Samsung_SharpSans_Medium",
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          wordSpacing: .5,
                          letterSpacing: .7,
                          height: 1.3,
                        ),
                      ),
                      Text("₦ 80",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "SharpSans_Bold",
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          wordSpacing: .5,
                          letterSpacing: .2,
                          height: 1.3,
                        ),

                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget dateTextSelection(Size size) {
    return  InkWell(
      onTap: () async {
        //_showDialogForWorkSelection(serviceTypeList);
        _selectDate(context);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: size.width * 6 /100,
          right: size.width * 6 /100,
          // bottom: size.height * 1 /100,
          top: size.height * 2 / 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your service date",
              style: Styles.textLabelTitle,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              focusNode: _serviceDateFocusNode,
              keyboardType: TextInputType.text,
              enabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z ]')),
              ],
              validator: InputValidator(
                  ch : 'Service Date').emptyChecking,
              controller: _serviceDateController,
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/arrow_down.svg',height: 7,width: 7,)
                ),
                hintText: "Vehicle ready for service on",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.8,
                  horizontal: 0.0,
                ),
                errorStyle: Styles.textLabelSubTitleRed,
                hintStyle: Styles.textLabelSubTitle,),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceTypeTextSelection(Size size) {
    return  InkWell(
      onTap: (){
        _showDialogForWorkSelection(serviceModelList);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: size.width * 6 /100,
          right: size.width * 6 /100,
          // bottom: size.height * 1 /100,
          top: size.height * 2 / 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your service type",
              style: Styles.textLabelTitle,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              focusNode: _serviceTypeFocusNode,
              keyboardType: TextInputType.name,
              enabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z ]')),
              ],
              validator: InputValidator(
                  ch : 'Service Type').emptyChecking,
              controller: _serviceTypeController,
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/arrow_down.svg',height: 7,width: 7,)
                ),
                hintText:
                "Take my vehicle to the mechanic ",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.8,
                  horizontal: 0.0,
                ),
                errorStyle: Styles.textLabelSubTitleRed,
                hintStyle: Styles.textLabelSubTitle,),
            ),
          ],
        ),
      ),
    );
  }

  Widget findMechanicButtonWidget(Size size){
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 6 / 100,
            top: size.height * 2.5 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Find available mechanics",
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

  void _awaitReturnValueFromSecondScreenOnAdd(BuildContext context) async {
    selectedCategoryList = [];
    selectedCategoryList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMoreRegularServicesListScreen(
            isAddService: true,isMechanicApp: false,categoryList: widget.categoryList,),
        ));

    setState(() {

    });
  }

  _showDialogForWorkSelection(List<String> _serviceTypeList) async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _serviceTypeList.length,
                itemBuilder: (context, index) {
                  return  ListTile(
                    title: Text("${_serviceTypeList[index]}",
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      setState(() {
                        selectedServiceModel = _serviceTypeList[index];
                        _serviceTypeController.text = _serviceTypeList[index];
                      });
                    },
                  );
                },
              ),
            ),);
        });
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        //selectedDate = selected;
        String selectedDateFormated = selected.day.toString() + "/"
            + selected.month.toString() + "/" + selected.year.toString();
        print("selectedDateFormated : " + selectedDateFormated);
        _serviceDateController.text = selectedDateFormated.toString();
      });
  }


}