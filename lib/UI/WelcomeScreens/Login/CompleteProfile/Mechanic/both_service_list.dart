import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/category_service_list_mdl.dart';



class BothServiceListScreen extends StatefulWidget {

  BothServiceListScreen();

  @override
  State<StatefulWidget> createState() {
    return _BothServiceListScreenState();
  }
}

class _BothServiceListScreenState extends State<BothServiceListScreen> {


  final ServiceListBloc _serviceListBloc = ServiceListBloc();
  final MechanicAddServiceListBloc _addServiceListBloc = MechanicAddServiceListBloc();


  List<CategoryList> allList = [];
  List<CategoryList> emergencyCategoryList = [];
  List<CategoryList> regularCategoryList = [];
  List<Service> emergencyServiceList = [];
  List<Service> regularServiceList = [];
  List<SelectedServicesMdl> emergencyServiceMdlList = [];
  List<SelectedServicesMdl> regularServiceMdlList = [];

  List<bool>? _emergencyIsChecked;
  List<bool>? _regularIsChecked;

  String title = "";
  late bool isRegularSelected;

  String authToken="", userCode = "";
  bool _isLoading = false;
  bool _isLoadingPage = true;
  bool isEmergencyServiceSelected = false, isRegularServiceSelected = false;
  double per = .10;
  String searchText = "";


  _listenServiceListResponse() {
    _serviceListBloc.serviceListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          //_isLoading = false;
          _isLoadingPage = false;
        });

      } else {

        setState(() {
          print("success postServiceList >>>>>>>  ${value.status}");
          print("success postServiceList >>>>>>>  ${value.data}");
          _isLoadingPage = false;
          //print(value.data!.serviceListAll!.length);
          //allServiceList = value.data!.serviceListAll!;

          allList = [];
          emergencyCategoryList = [];
          emergencyServiceList = [];
          emergencyServiceMdlList = [];
          regularCategoryList = [];
          regularServiceList = [];
          regularServiceMdlList = [];

          allList = value.data!.categoryList!;

          print("allList.length.toString() >>> " + allList.length.toString());
             int count=0;
          for(int i = 0; i < allList.length; i++){
            if(allList[i].catType.toString() == "1"){
              emergencyCategoryList.add(allList[i]);
              for(int x = 0; x < allList[i].service!.length; x++){
                emergencyServiceList.add(allList[i].service![x]);
                emergencyServiceMdlList.add(
                    SelectedServicesMdl(i,x,
                        allList[i].service![x].id.toString(),
                        allList[i].service![x].minPrice,
                        allList[i].service![x].maxPrice,
                        "10:00",
                        allList[i].service![x].minPrice,
                        false));
              }
            }
            else{
              regularCategoryList.add(allList[i]);
              for( int y = 0; y < allList[i].service!.length; y++){
                regularServiceList.add(allList[i].service![y]);
                regularServiceMdlList.add(
                    SelectedServicesMdl(count,y,
                        allList[i].service![y].id.toString(),
                        allList[i].service![y].minPrice,
                        allList[i].service![y].maxPrice,
                        "10:00",
                        allList[i].service![y].minPrice,
                         false));
                print("jggshsh #$i *** count $count $y name ${ allList[i].service![y].serviceName}");
              }
              count = count + 1;
            }
          }

          print("emergencyCategoryList.length >>> "+ emergencyCategoryList.length.toString());
          print("emergencyServiceList.length >>> "+ emergencyServiceList.length.toString());
          print("emergencyServiceMdlList.length >>> "+ emergencyServiceMdlList.length.toString());

          print("regularCategoryList.length >>> "+ regularCategoryList.length.toString());
          print("regularServiceList.length >>> "+ regularServiceList.length.toString());
          print("regularServiceMdlList.length >>> "+ regularServiceMdlList.length.toString());

          _emergencyIsChecked = List<bool>.filled(emergencyServiceMdlList.length, false);
          _regularIsChecked = List<bool>.filled(regularServiceMdlList.length, false);

          print("_regularIsChecked!.length >>> " + _regularIsChecked!.length.toString());

          print(_emergencyIsChecked!.length);
        });
      }
    });
  }

  _listenAddServiceListResponse() {
    _addServiceListBloc.postAddServiceList.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          //_isLoading = false;
        });

      } else {

        setState(() async {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          print("success refNumber: userCode, >>>>>>>  ${userCode}");
          SharedPreferences _shdPre = await SharedPreferences.getInstance();
          _shdPre.setInt(SharedPrefKeys.isWorkProfileCompleted, 3);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WaitAdminApprovalScreen(refNumber: '$userCode',) ));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isRegularSelected = false;
    getSharedPrefData();
    _listenServiceListResponse();
    _listenAddServiceListResponse();

    //_regularIsChecked = List<bool>.filled(regularServiceList.length, false);
    //_emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userCode = shdPre.getString(SharedPrefKeys.userCode).toString();
      print('authToken >>>>>>> '+authToken.toString());
      _serviceListBloc.postServiceListRequest(authToken, "", null, null, "" );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustColors.materialBlue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width:  size.width,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 6 /100,
                right: size.width * 5.9 / 100,
                bottom: size.height * 2.7 / 100,
                top: size.height * 3.2 / 100,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isRegularSelected = !isRegularSelected ;
                        print("isRegularSelected >>>>>> " +isRegularSelected.toString());
                        //searchText = "";
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: size.height * 0.8 / 100
                      ),
                      child: Text(isRegularSelected ? "Emergency " : "Regular",
                          softWrap: true,
                          style: Styles.hiddenTextBlack,
                      ),
                    ),
                  ),

                  Expanded(
                      child: isRegularSelected ? regularServiceListUi(size) : emergencyServiceListUi(size)
                  ),

                  _isLoadingPage == true
                      ?
                  Container()
                      :
                  nextButtons(size),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget regularServiceListUi(Size size) {
   return Container(
     color: CustColors.pale_grey,
     child: Column(
       children: [
         Container(
             margin: EdgeInsets.only(
                 left: size.width * 30 / 100 ,
                 right: size.width * 30 / 100,
                 top: size.height * 2.7 / 100
             ),
             child: const Text("Regular",
                softWrap: true,
                style: Styles.TitleTextBlack,
             )
         ),

         Container(
           margin: EdgeInsets.only(
             top: size.height * 3 / 100,
             left: size.width * 3 / 100,
             right: size.width * 3 / 100,
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
                 margin: EdgeInsets.only(left: ScreenSize().setValue(20)),
                 child: Icon(
                   Icons.search,
                   size: 20,
                   color: CustColors.light_navy,
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
                       cursorColor: CustColors.light_navy,
                       onChanged: (text) {
                         setState(() {
                           if(text.isNotEmpty){
                             //searchText = text;
                             _serviceListBloc.postServiceListRequest(authToken, text, null, null, text );
                           }else{
                             //searchText = text;
                             _serviceListBloc.postServiceListRequest(authToken, "", null, null, "" );
                           }
                         });
                         //_allMakeBloc.searchMake(text);
                       },
                       textAlign: TextAlign.left,
                       style: Styles.searchTextStyle01,
                       decoration: InputDecoration(
                           hintText: "Search Your Service",
                           border: InputBorder.none,
                           contentPadding: new EdgeInsets.only(bottom: 15),
                           hintStyle: Styles.searchTextStyle01
                       ),

                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
         _isLoadingPage == true
             ?
         const Center(
           child: CircularProgressIndicator(color: CustColors.light_navy,),)
             :
         Expanded(
           child: Container(
             margin: EdgeInsets.only(
                 top: size.height * 0.020,
                 bottom: size.height * 0.018
             ),
             color: CustColors.pale_grey,
             height: size.height * 0.82, //0.764
             child: Container(
               margin: EdgeInsets.only(
                   left: size.width * 0.020,
                   right: size.width * 0.020,
                   //top: size.height * 0.03,
                   bottom: size.height * 0.032
               ),
               child: Column(
                 children: [
                   Expanded(
                     child: Container(
                       child:  regularCategoryList.length != 0
                           ? ListView.builder(
                               itemBuilder: (BuildContext context, int i) =>
                                   _buildTiles(regularCategoryList[i],size, i),
                               itemCount: regularCategoryList.length,
                             )
                           : Center(
                              child: Text('No Results found.'),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ),
       ],
     ),
   );
  }

  Widget emergencyServiceListUi(Size size) {
    return Container(
      color: CustColors.pale_grey,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: size.height * 2.7 / 100
              ),
              child: Text("Emergency",
                softWrap: true,
                style: Styles.TitleTextBlack,)
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.height * 3 / 100,
              left: size.width * 3 / 100,
              right: size.width * 3 / 100,
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
                  margin: EdgeInsets.only(left: ScreenSize().setValue(20)),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: CustColors.light_navy,
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
                        cursorColor: CustColors.light_navy,
                        onChanged: (text) {
                          setState(() {
                            if(text.isNotEmpty){
                              //searchText = text;
                              _serviceListBloc.postServiceListRequest(authToken, text, null, null,"" );
                            }else{
                              searchText = text;
                              _serviceListBloc.postServiceListRequest(authToken, "", null, null, "" );
                            }
                          });
                          //_allMakeBloc.searchMake(text);
                        },
                        textAlign: TextAlign.left,
                        style: Styles.searchTextStyle01,
                        decoration: InputDecoration(
                            hintText: "Search Your Service",
                            border: InputBorder.none,
                            contentPadding: new EdgeInsets.only(bottom: 15),
                            hintStyle: Styles.searchTextStyle01
                        ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoadingPage == true
              ?
          Container(
            margin: EdgeInsets.only(
              top: 10
            ),
            child: const Center(
              child: CircularProgressIndicator(color: CustColors.light_navy,),),
          )
              :
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.022,
                  bottom: size.height * 0.018
              ),
              color: CustColors.pale_grey,
              height: size.height * 0.82, //0.764
              child: Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.020,
                    right: size.width * 0.020,
                    //top: size.height * 0.03,
                    bottom: size.height * 0.032
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: emergencyServiceList.length != 0
                            ? ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: emergencyServiceList.length,
                              itemBuilder: (context, index) {

                            TextEditingController _rateController=TextEditingController();
                            TextEditingController _timeController = TextEditingController();
                            _rateController.text = emergencyServiceMdlList[index].fee;
                            _timeController.text = emergencyServiceMdlList[index].time;
                            _rateController.addListener(() {
                              var temp =   SelectedServicesMdl(0,index,
                                  emergencyServiceMdlList[index].serviceId,
                                  emergencyServiceMdlList[index].minAmount,
                                  emergencyServiceMdlList[index].maxAmount,
                                  emergencyServiceMdlList[index].time,
                                  _rateController.text,
                                  emergencyServiceMdlList[index].isEnable);
                              emergencyServiceMdlList.removeAt(index);
                              emergencyServiceMdlList.insert(index,temp);
                            });
                            _timeController.addListener(() {
                              var temp =   SelectedServicesMdl(0,index,
                                  emergencyServiceMdlList[index].serviceId,
                                  emergencyServiceMdlList[index].minAmount,
                                  emergencyServiceMdlList[index].maxAmount,
                                  _timeController.text,
                                  emergencyServiceMdlList[index].fee,
                                  emergencyServiceMdlList[index].isEnable);
                              emergencyServiceMdlList.removeAt(index);
                              emergencyServiceMdlList.insert(index,temp);
                            });
                            //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                            //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                            //_rateController.text = regularServiceList![index].minAmount.toString();
                            return InkWell(
                                onTap: () {
                                  final brandName = emergencyServiceList[index];

                                  print(">>>>>");
                                  //print(brandId);
                                  //Navigator.pop(context);
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: .5,
                                        child: Checkbox(
                                          activeColor: CustColors.light_navy,
                                          value: _emergencyIsChecked![index],
                                          onChanged: (bool? val){
                                            setState(() {
                                              this._emergencyIsChecked![index] = val!;

                                              print("sgsjhgj 001 $val");
                                              if(val){
                                                var temp =   SelectedServicesMdl(0,index,
                                                    emergencyServiceMdlList[index].serviceId,
                                                    emergencyServiceMdlList[index].minAmount,
                                                    emergencyServiceMdlList[index].maxAmount,
                                                    emergencyServiceMdlList[index].time,
                                                    emergencyServiceMdlList[index].fee,
                                                    val);
                                                emergencyServiceMdlList.removeAt(index);
                                                emergencyServiceMdlList.insert(index,
                                                    temp);
                                              }else{
                                                //serviceSpecialisationList.remove(regularServiceList[index]);
                                                var temp= SelectedServicesMdl(0,index,
                                                    emergencyServiceMdlList[index].serviceId,
                                                    emergencyServiceMdlList[index].minAmount,
                                                    emergencyServiceMdlList[index].maxAmount,
                                                    emergencyServiceMdlList[index].time,
                                                    emergencyServiceMdlList[index].fee,
                                                    val);
                                                emergencyServiceMdlList.removeAt(index);
                                                emergencyServiceMdlList.insert(index,temp
                                                );
                                              }
                                              print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                            });
                                          },
                                        ),
                                      ),

                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          '${emergencyServiceList[index].serviceName.toString()}',
                                        ),
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "Fill field";
                                            }
                                            else if(int.parse(value) < int.parse(emergencyServiceList[index].minPrice) ){
                                              return emergencyServiceList[index].minPrice + " - " + emergencyServiceList[index].maxPrice;
                                            }
                                            else if(int.parse(value) > int.parse(emergencyServiceList[index].maxPrice)){
                                              return emergencyServiceList[index].minPrice + " - " + emergencyServiceList[index].maxPrice;
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                              /*border: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal: 6.0,
                                              ),*/
                                              errorStyle: TextStyle(
                                                fontFamily: "Samsung_SharpSans_Medium",
                                                fontSize: 5,
                                                letterSpacing: .3,
                                              )
                                          ),
                                          cursorColor: CustColors.light_navy,
                                          keyboardType: TextInputType.number,
                                          /*inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],*/
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                          controller: _rateController,
                                          style: Styles.searchTextStyle02,
                                          enabled: _emergencyIsChecked![index],
                                          //readOnly: _regularIsChecked![index],
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width / 100 * 4,
                                      ),
                                      //Text("00 : 30")
                                      Flexible(
                                        child: InkWell(
                                          onTap: () async{
                                            if(_emergencyIsChecked![index]){
                                              Duration? _durationResult = await showDurationPicker(
                                                  snapToMins: 5.0,
                                                  context: context,
                                                  initialTime: Duration(
                                                    //hours: 2,
                                                      minutes: int.parse(_timeController.text.toString().replaceAll(":00", "")),
                                                      seconds: 00,
                                                      milliseconds: 0)
                                              );
                                              print("_durationResult >>>" + _durationResult!.inMinutes.toString() + ":00");
                                              if(_durationResult != null){
                                                setState(() {
                                                  _timeController.text = "";
                                                  _timeController.text = _durationResult.inMinutes.toString() + ":00";
                                                });
                                              }
                                            }
                                          },
                                          child: TextFormField(
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Fill field";
                                              }
                                              else{
                                                return null;
                                              }
                                            },
                                            cursorColor: CustColors.light_navy,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            keyboardType: TextInputType.datetime,
                                            //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                            controller: _timeController,
                                            style: Styles.searchTextStyle02,
                                            enabled: false,
                                            //readOnly: _regularIsChecked![index],
                                          ),
                                        ),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTiles(CategoryList root, Size size,int parentIndex) {
    print('parentIndex >>>>>>>>>>>>>>>>>>_buildTiles  $parentIndex');

    print('root >>>>>>>>>>>>>>>>>>root.service!.length. $root');
    if (root.service!.isEmpty) return ListTile(title: Text(root.catName));
    return ExpansionTile(
      key: PageStorageKey<CategoryList>(root),
      iconColor: CustColors.light_navy,
      textColor: CustColors.light_navy,
      title: Text(
        root.catName,
      ),
      //children: root.service.map(Text(root.service[0].serviceName)).toList(),
      children: <Widget>[
        //ListTile(title: Text(root.service![0].serviceName),)
        root.service!.length != 0 ?
        ListView.builder(
          key: PageStorageKey<CategoryList>(root),
          physics: ClampingScrollPhysics(),
          //controller: _scrollController,
          shrinkWrap: true,
          //scrollDirection: Axis.vertical,
          itemCount:  root.service!.length,
          itemBuilder: (context, index) {
            print('index >>>>>>>>>xxxxxxx>>>>>> parentIndex  $parentIndex');
            print('index >>>>>>>>>xxxxxxx>>>>>> child index. $index');

            TextEditingController _rateController = TextEditingController();
            TextEditingController _timeController = TextEditingController();
            //_rateController.text = root.service![index].minPrice.toString();
            _rateController.text = regularServiceMdlList[getItemIndex(parentIndex,index)].fee;
            _timeController.text = regularServiceMdlList[getItemIndex(parentIndex,index)].time;
            _rateController.addListener(() {
              int itemIndex = getItemIndex(parentIndex, index);
              var temp =   SelectedServicesMdl(parentIndex, index,
                  regularServiceMdlList[itemIndex].serviceId,
                  regularServiceMdlList[itemIndex].minAmount,
                  regularServiceMdlList[itemIndex].maxAmount,
                  regularServiceMdlList[itemIndex].time,
                  _rateController.text,
                  regularServiceMdlList[itemIndex].isEnable);
              regularServiceMdlList.removeAt(itemIndex);
              regularServiceMdlList.insert(itemIndex,temp);
            });
            _timeController.addListener(() {
              int itemIndex = getItemIndex(parentIndex,index);
              var temp =   SelectedServicesMdl(parentIndex, index,
                  regularServiceMdlList[itemIndex].serviceId,
                  regularServiceMdlList[itemIndex].minAmount,
                  regularServiceMdlList[itemIndex].maxAmount,
                  _timeController.text,
                  regularServiceMdlList[itemIndex].fee,
                  regularServiceMdlList[itemIndex].isEnable);
              regularServiceMdlList.removeAt(itemIndex);
              regularServiceMdlList.insert(itemIndex,temp);
            });

            return Container(
              child: Row(
                children: [
                  Transform.scale(
                    scale: .5,
                    child: Checkbox(
                      activeColor: CustColors.light_navy,
                      value: _regularIsChecked![getItemIndex(parentIndex,index)],
                      //value: false,
                      onChanged: (bool? val){
                        setState(() {
                          this._regularIsChecked![getItemIndex(parentIndex,index)] = val!;

                          print("sgsjhgj 001 $val");
                          if(val){
                            int itemIndex = getItemIndex(parentIndex,index);
                            print("Checkbox itemIndex >>>>>>>>>> " + itemIndex.toString());
                            var temp =   SelectedServicesMdl(parentIndex,index,
                                regularServiceMdlList[itemIndex].serviceId,
                                regularServiceMdlList[itemIndex].minAmount,
                                regularServiceMdlList[itemIndex].maxAmount,
                                regularServiceMdlList[itemIndex].time,
                                regularServiceMdlList[itemIndex].fee,
                                val);
                            regularServiceMdlList.removeAt(itemIndex);
                            regularServiceMdlList.insert(itemIndex, temp);
                          }else{
                            int itemIndex = getItemIndex(parentIndex,index);
                            print("Checkbox itemIndex >>>>>>>>>> " + itemIndex.toString());
                            //serviceSpecialisationList.remove(regularServiceList[index]);
                            var temp= SelectedServicesMdl(parentIndex,index,
                                regularServiceMdlList[itemIndex].serviceId,
                                regularServiceMdlList[itemIndex].minAmount,
                                regularServiceMdlList[itemIndex].maxAmount,
                                regularServiceMdlList[itemIndex].time,
                                regularServiceMdlList[itemIndex].fee,
                                 val);
                            regularServiceMdlList.removeAt(itemIndex);
                            regularServiceMdlList.insert(itemIndex,temp);
                          }
                          //print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${root.service![index].serviceName.toString()}',
                    ),
                  ),
                  Container(
                    width: size.width * 15 / 100,
                    height: size.height * 4 / 100,
                    padding: EdgeInsets.only(
                        top: size.height * 1 / 100,
                        bottom: size.width * 1 / 100
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.8),
                      ),
                      border: Border.all(
                          color: CustColors.pinkish_grey02,
                          width: 0.3
                      ),
                      //color: Colors.redAccent,
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 6.0,
                          ),
                            errorStyle: TextStyle(
                              fontFamily: "Samsung_SharpSans_Medium",
                              fontSize: 5,
                              letterSpacing: .3,
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Fill field";
                          }
                          else if(int.parse(value) < int.parse(regularServiceMdlList[getItemIndex(parentIndex,index)].minAmount)){
                            return regularServiceMdlList[getItemIndex(parentIndex,index)].minAmount + " - " + regularServiceMdlList[getItemIndex(parentIndex,index)].maxAmount;
                          }
                          else if(int.parse(value) > int.parse(regularServiceMdlList[getItemIndex(parentIndex,index)].maxAmount)){
                            return regularServiceMdlList[getItemIndex(parentIndex,index)].minAmount + " - " + regularServiceMdlList[getItemIndex(parentIndex,index)].maxAmount;
                          }
                          else{
                            return null;
                          }
                        },
                        cursorColor: CustColors.light_navy,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //initialValue: '${regularServiceList[index].serviceName.toString()}',
                        controller: _rateController,
                        style: Styles.searchTextStyle02,
                        enabled: _regularIsChecked![getItemIndex(parentIndex,index)],
                        //readOnly: _regularIsChecked![getItemIndex(parentIndex,index)],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 100 * 4,
                  ),
                  Container(
                    width: size.width * 15 / 100,
                    height: size.height * 4 / 100,
                    padding: EdgeInsets.only(
                        top: size.height * 1 / 100,
                        bottom: size.width * 1 / 100
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.8),
                      ),
                      border: Border.all(
                          color: CustColors.pinkish_grey02,
                          width: 0.3
                      ),
                      //color: Colors.redAccent,
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () async{
                          if(_regularIsChecked![getItemIndex(parentIndex,index)]){
                            Duration? _durationResult = await showDurationPicker(
                                snapToMins: 5.0,
                                context: context,
                                initialTime: Duration(
                                  //hours: 2,
                                    minutes: int.parse(_timeController.text.toString().replaceAll(":00", "")),
                                    seconds: 00,
                                    milliseconds: 0)
                            );
                            print("_durationResult >>>" + _durationResult!.inMinutes.toString() + ":00");
                            if(_durationResult != null){
                              setState(() {
                                _timeController.text = "";
                                _timeController.text = _durationResult.inMinutes.toString() + ":00";
                              });
                            }
                          }
                        },
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.5,
                              horizontal: 6.0,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Fill field";
                            }
                            else{
                              return null;
                            }
                          },
                          cursorColor: CustColors.light_navy,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.datetime,
                          controller: _timeController,
                          style: Styles.searchTextStyle02,
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
            :
        Container(),
      ],

    );
  }


  int getItemIndex(int parentIndex, int childIndex){
    int itemIndex = regularServiceMdlList.indexWhere((item) => item.parentIndex == parentIndex && item.childIndex == childIndex);
    print("itemIndex >>>>>>>>111 " + itemIndex.toString());
    return itemIndex;
  }

  Widget nextButtons(Size size) {
    return InkWell(
      onTap: (){
        // Map<List<AllServiceFeeData>?, String> myData = new Map();
        //SelectedData data = SelectedData(selectedServiceList,"rate");

        print(">>>>>>> emergencyServiceMdlList.length ${emergencyServiceMdlList.length}");
        print(">>>>>>> emergencyServiceMdlList.length ${regularServiceMdlList.length}");

        List<SelectedServicesMdl> selectedService=[];


        for(int i=0;i<emergencyServiceMdlList.length;i++){
          print("time 001 ${emergencyServiceMdlList[i].isEnable}");
          if(emergencyServiceMdlList[i].isEnable){
            isEmergencyServiceSelected = true;
            selectedService.add(emergencyServiceMdlList[i]);
          }else{
            print("no data to print");
          }
          //print("fgdhj 001 ${selectedServiceMdlList[i].amount}");
          //print("time 001 ${selectedServiceMdlList[i].time}");
          //print("time 001 ${selectedServiceMdlList[i].isEnable}");
        }

        for(int i=0;i<regularServiceMdlList.length;i++){
          print("time 001 ${regularServiceMdlList[i].isEnable}");
          if(regularServiceMdlList[i].isEnable){
            selectedService.add(regularServiceMdlList[i]);
            isRegularServiceSelected = true;
          }else{
            print("no data to print");
          }
        }

        if(isRegularServiceSelected && isEmergencyServiceSelected){
          String serviceId="";
          String feeList = "[";
          String timeList = "[";

          for(int m = 0 ; m< selectedService.length; m++){
            if( m != selectedService.length-1){
              serviceId = serviceId + "${selectedService[m].serviceId}" + ", ";
              feeList = feeList + """ "${selectedService[m].fee}",""";
              timeList = timeList + """ "${selectedService[m].time}",""";
            }else{
              serviceId = serviceId + "${selectedService[m].serviceId}" ;
              feeList = feeList + """ "${selectedService[m].fee}" """;
              timeList = timeList + """ "${selectedService[m].time}" """;
            }
          }
          serviceId = serviceId ;
          feeList = feeList + "]";
          timeList = timeList + "]";

          print(" >>>> serviceId" +serviceId + " >>>> feeList " + feeList + " >>>>>>>> timeList" + timeList);

          _addServiceListBloc.postMechanicAddServicesRequest(
              authToken,
              serviceId,  feeList, timeList, null);     // catType - 1/2 - doubt
        }else if(isRegularServiceSelected){
          Fluttertoast.showToast(
            msg: "select emergency services!!",
            backgroundColor: CustColors.light_navy,
            timeInSecForIosWeb: 1,
          );
        }else if(isEmergencyServiceSelected){
          Fluttertoast.showToast(
            msg: "select regular services!!",
            backgroundColor: CustColors.light_navy,
            timeInSecForIosWeb: 1,
          );
        }else{
          Fluttertoast.showToast(
            msg: "select services!!",
            backgroundColor: CustColors.light_navy,
            timeInSecForIosWeb: 1,
          );
        }


      },
      child: Container(
        height: size.height * 0.045,
        width: size.width * 0.246,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 8, bottom: 6,left: 75,right: 75),
        //padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: CustColors.light_navy,
          border: Border.all(
            color: CustColors.blue,
            style: BorderStyle.solid,
            width: 0.70,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child:  Text(
          "Next",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Corbel_Bold',
              fontSize: ScreenSize().setValueFont(14.5),
              fontWeight: FontWeight.w800),
        ),
      ),
    ) ;
  }

}

class SelectedServicesMdl{
  final int parentIndex;
  final int childIndex;
  final String serviceId;
  final String minAmount;
  final String maxAmount;
  final String fee;
  final String time;
  final bool isEnable;
  SelectedServicesMdl(this.parentIndex,
      this.childIndex,this.serviceId,
      this.minAmount, this.maxAmount,
      this.time,this.fee, this.isEnable);
}