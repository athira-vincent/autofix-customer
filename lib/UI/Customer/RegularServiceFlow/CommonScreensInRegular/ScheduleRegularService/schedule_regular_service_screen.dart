import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/AddRegularMoreServices/add_more_regular_service_list_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/MechanicList/RegularFindMechanicList/mechanic_list_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleRegularServiceScreen extends StatefulWidget {

  final CategoryList? categoryList;
  final List<Service>? selectedService;

  final String latitude;
  final String longitude;
  final String address;

  ScheduleRegularServiceScreen
      ({
        required this.categoryList,
        required this.selectedService,
        required this.latitude,
        required this.longitude,
        required this.address
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

  TextEditingController _serviceTimeController = TextEditingController();
  FocusNode _serviceTimeFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;


  List<Service>? selectedCategoryList =[];
  String selectedServiceSpecializatonType = "";
  int totalEstimatedTime = 0 , totalEstimatedPrice = 0;
  String selectedServiceIds = "";
  List<String> selectedListServiceIds =[];


  List<String> serviceModelList = [
    TextStrings.txt_mobile_mechanic,
    TextStrings.txt_pick_up,
    TextStrings.txt_take_vehicle
  ];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String selectedDateForApi = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.categoryList!.service![0].regularStatus = 1;

    selectedCategoryList = widget.selectedService;
    for(int i = 0; i<selectedCategoryList!.length ; i++){
      selectedListServiceIds.add(selectedCategoryList![i].id);
      selectedServiceIds = selectedCategoryList![i].id  + ',' + selectedServiceIds ;
      totalEstimatedPrice = totalEstimatedPrice + int.parse('${selectedCategoryList![i].maxPrice}');
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                      timeTextSelection(size),
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
          selectedCategoryList!.length != 0
              ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: selectedCategoryList!.length,
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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text("$totalEstimatedPrice",
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
            child:  Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: CustColors.light_navy,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: .5,
                      ),
                    ]),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                )
            ),
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
                for(int i=0; i<widget.categoryList!.service!.length; i++)
                  {
                    if(selectedCategoryList![index].id == widget.categoryList!.service![i].id)
                      {
                        this.widget.categoryList!.service![i].isChecked = false;
                      }
                  }
                selectedCategoryList!.removeAt(index);
              });
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Container(
                      height: size.height * 7 / 100,
                      width: size.width * 13 / 100,
                      decoration: BoxDecoration(
                          color: CustColors.whiteBlueish,
                          borderRadius: BorderRadius.circular(11.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child:selectedCategoryList![index].icon.toString() != ""
                            ? Image.network(selectedCategoryList![index].icon,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Text(
                  selectedCategoryList![index].serviceName,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Samsung_SharpSans_Medium",
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Text("₦ ${selectedCategoryList![index].maxPrice}",
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
                hintText: "Service date",
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


  Widget timeTextSelection(Size size) {
    return  InkWell(
      onTap: () async {
        _selectTime(context);
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
              "Select your service time",
              style: Styles.textLabelTitle,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              focusNode: _serviceTimeFocusNode,
              keyboardType: TextInputType.text,
              enabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z ]')),
              ],
              validator: InputValidator(
                  ch : 'Service Date').emptyChecking,
              controller: _serviceTimeController,
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/arrow_down.svg',height: 7,width: 7,)
                ),
                hintText: "Service time",
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
    return InkWell(
      onTap: (){
        print('$selectedListServiceIds >>>>>>>>>>>selectedListServiceIds ');
        print('${selectedListServiceIds.toString().replaceAll("[", "").replaceAll("]", "")} >>>>>>>>>>>selectedServiceIds ');
        print('${_serviceTypeController.text} >>>>>>>>>>>_serviceTypeController.text ');
        print('${_serviceDateController.text} >>>>>>>>>>>_serviceDateController.text ');
        print('${_serviceTimeController.text} >>>>>>>>>>>_serviceTimeController.text ');

        if(selectedListServiceIds.length == 0)
          {
            SnackBarWidget().setMaterialSnackBar('Select any service',_scaffoldKey);
          }
        else if(_serviceDateController.text == "")
          {
            SnackBarWidget().setMaterialSnackBar('Select service date',_scaffoldKey);
          }
        else if(_serviceTimeController.text == "")
          {
            SnackBarWidget().setMaterialSnackBar('Select service time',_scaffoldKey);
          }
        else if(_serviceTypeController.text == "")
          {
            SnackBarWidget().setMaterialSnackBar('Select service type',_scaffoldKey);
          }
        else
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  MechanicListScreen(
                      serviceIds: '${selectedListServiceIds.toString().replaceAll("[", "").replaceAll("]", "")}',
                      serviceDate: '${selectedDateForApi}',
                      serviceTime: '${_serviceTimeController.text}',
                      regularServiceType: '${_serviceTypeController.text}',
                      serviceType: 'regular',
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                      address: widget.address,
                      selectedService: selectedCategoryList,

                    )));
          }

      },
      child: Align(
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
      ),
    );
  }

  void _awaitReturnValueFromSecondScreenOnAdd(BuildContext context) async {
    selectedCategoryList = [];
    selectedListServiceIds =[];
    selectedServiceIds = "";
    totalEstimatedPrice = 0;
    selectedCategoryList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMoreRegularServicesListScreen(
            isAddService: true,
            isReturnData: true,
            categoryList: widget.categoryList,
            longitude: widget.longitude,
            latitude: widget.latitude,
            address: widget.address,
          ),
        ));

    setState(() {
      for(int i = 0; i<selectedCategoryList!.length ; i++){
          selectedListServiceIds.add(selectedCategoryList![i].id);
          selectedServiceIds = selectedCategoryList![i].id  + ',' + selectedServiceIds ;
          totalEstimatedPrice = totalEstimatedPrice + int.parse('${selectedCategoryList![i].maxPrice}');
      }
      print('totalEstimatedPrice >>>>>>>>>> $totalEstimatedPrice');
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
                        selectedServiceSpecializatonType = _serviceTypeList[index];
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
      initialDate: DateTime(2022,  DateTime.now().month,DateTime.now().day+1),
      firstDate:   DateTime(2022,  DateTime.now().month,DateTime.now().day+1),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: CustColors.light_navy,
              onPrimary: CustColors.roseText1,
              onSurface: CustColors.light_navy,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        String selectedDateFormated = selected.day.toString() + "/"
            + selected.month.toString() + "/" + selected.year.toString();
        print("selectedDateFormated : " + selectedDateFormated);
        _serviceDateController.text = selectedDateFormated.toString();
        //selectedDateForApi = new DateFormat("yyyy-MM-dd").parse(selected);
        selectedDateForApi = _homeCustomerBloc.dateConverter(selected);
        //selectedDateForApi = selected.year.toString() + "-" +  selected.month.toString() + "-" + selected.day.toString();
        //DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(scheduledDate);
      });
  }

  _selectTime(BuildContext context) async {
     TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
       builder: (context, child) {
         return Theme(
           data: ThemeData.light().copyWith(
             colorScheme: ColorScheme.light(
               primary: CustColors.light_navy,
               onPrimary: CustColors.roseText1,
               onSurface: CustColors.light_navy,
             ),
             dialogBackgroundColor:Colors.white,
           ),
           child: child!,
         );
       },
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        print('${picked.format(context)} >>>>selectedTime');
        _serviceTimeController.text = '${picked.format(context)}';
      });
  }



}