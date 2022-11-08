import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/cust_colors.dart';
import '../../../WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_mdl.dart';
import 'add_price_fault_bloc.dart';
import 'add_price_fault_mdl.dart';
import 'emrg_reglr_add_price_mdl.dart';
import 'update_time_add_price_mdl.dart';

class RegularServices extends StatefulWidget{
  RegularServices({Key? key,}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegularServices();
  }

}

class _RegularServices extends State<RegularServices>  with AutomaticKeepAliveClientMixin{
  String authToken = "", mechanicId = "",
      search="" ;
  int page=0,size=100;
  bool saveloading = false;
  bool _isLoadingPage = false;
  List<bool> _selectionList=[];
  AddPriceFaultReviewBloc _addPriceFaultReviewBloc=AddPriceFaultReviewBloc();
  MechanicServiceAdd? _MechanicServiceAdd;
  AddPriceServiceList? _AddPriceServiceList;
  List<String>? _timeList=[];
  List<String>? _priceList=[];

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  int checkID=0;
  int tempCounter = 0;
  List<String> _lodingIdList=[];
  List<String>? _timeListEmergency=[];
  List<String>? _priceListEmergency=[];
  List<String>? _serviceIdEmergency=[];


  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    _listenApiResponse();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
      print('userFamilyId ' + authToken.toString());
      //print('userId ' + userId.toString());
      /*_addPriceFaultReviewBloc.postAddFetchPriceFaultReviewRequest(
          authToken,
          mechanicId);*/
      _selectionList.clear();
      _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
          authToken,
          page,
          size,
          search,
          mechanicId,
          2);
    });
  }

  _listenApiResponse(){
    _addPriceFaultReviewBloc.EnrgRegAddPriceMdlResponse.listen((value) {
      print("pieuiey 001 ${value.data}");
      if(value.data == "error"){
        setState(() {
          _isLoadingPage = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.data.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }else{
        setState(() {
          _isLoadingPage = true;
          _AddPriceServiceList = value.data!.addPriceServiceList!;
          _selectionList=[];
          _timeList = [];
          _priceList = [];

          for(int i=0;i<_AddPriceServiceList!.data!.length;i++){
            //if(_AddPriceServiceList!.data![i].status==1) {
            if(_AddPriceServiceList!.data![i].mechanicService!.length > 0){
              _selectionList.add(true);
              _timeList!.add(_AddPriceServiceList!.data![i].mechanicService![0].time.toString());
              _priceList!.add(_AddPriceServiceList!.data![i].mechanicService![0].fee.toString());
            }
            else{
              _selectionList.add(false);
              _timeList!.add("10:00");
              _priceList!.add(_AddPriceServiceList!.data![i].minPrice);
            }
            print("fddfds ${_timeList}");
            print("ewqr ${_priceList}");

          };
          print("vhvhfhjfh 01 ${_AddPriceServiceList!.data!.length}");
        });
      }
    });

    _addPriceFaultReviewBloc.TimePriceServiceDetailsMdlResponse.listen((value) {
      if(value.data == "error"){
        setState(() {
          saveloading = false;
          print('abcdefg02');
          //_isLoadingPage = true;
          //SnackBarWidget().setMaterialSnackBar("Error",_scaffoldKey);
          if(checkID!=0) {
            if(checkID==value)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.data.toString(),
                    style: const TextStyle(
                        fontFamily: 'Roboto_Regular', fontSize: 14)),
                duration: const Duration(seconds: 2),
                backgroundColor: CustColors.light_navy,
              ));
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }else{
        setState(() {
          //_selectionList.clear();
          print('abcdefg01');
          _isLoadingPage = false;
          saveloading = false;
          tempCounter = 0;
          _lodingIdList = [];
          _serviceIdEmergency = [];
          _timeListEmergency = [] ;
          _priceListEmergency = [];
          getSharedPrefData();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Service List Updated',
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
          //_isLoadingPage = true;
          _MechanicServiceAdd = value.data!.mechanicServiceAdd as MechanicServiceAdd?;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff9f9f9),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left:15,right:15,top: 26.0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      onChanged: (value){
                        if(value.length!=0){
                          _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
                              authToken,
                              page,
                              size,
                              value,
                              mechanicId,
                              2);
                        }else{
                          _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
                              authToken,
                              page,
                              size,
                              search,
                              mechanicId,
                              2);
                        }
                      },
                      cursorColor: CustColors.light_navy,
                      //style: TextStyle(),
                      decoration:
                      InputDecoration(
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: BorderSide(color: Colors.white)
                        // ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search, color: CustColors.light_navy),
                        hintText: 'Search Your  Service',
                        contentPadding: EdgeInsets.only(top: 1),
                      ),
                    ),
                  ),
                ),
              ),
              _isLoadingPage==false?Center(child: CircularProgressIndicator(color: CustColors.light_navy)):
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _AddPriceServiceList!.data!.length,
                    itemBuilder: (BuildContext context, int index){
                      TextEditingController _textEditContoller=TextEditingController();
                      _textEditContoller.text=_timeList![index];
                      TextEditingController _textEditContoller01=TextEditingController();
                      _textEditContoller01.text=_priceList![index];
                      _textEditContoller.addListener(() {
                        _timeList!.removeAt(index);
                        _timeList!.insert(index, _textEditContoller.text);

                      });
                      _textEditContoller01.addListener(() {
                        _priceList!.removeAt(index);
                        _priceList!.insert(index,
                            _textEditContoller01.text);
                      });
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:150,
                                  child: Row(
                                    children:[
                                      InkWell(
                                        onTap:(){
                                          setState(() {
                                            bool s = _selectionList[index];
                                            print(_selectionList[index].toString());
                                            _selectionList.removeAt(index);
                                            _selectionList.insert(index,!s );
                                            print(_selectionList[index].toString());
                                            if(!_selectionList[index]){
                                              _textEditContoller.text=(_AddPriceServiceList!.data![0].mechanicService!.length>0)?_AddPriceServiceList!.data![0].mechanicService![0].time:"10:00";
                                              _textEditContoller01.text=(_AddPriceServiceList!.data![0].mechanicService!.length>0)?_AddPriceServiceList!.data![0].mechanicService![0].fee:"1000";
                                              setState(() {

                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          child: Row(
                                              children:[
                                                Container(
                                                  decoration: BoxDecoration(color:_selectionList[index] ? const Color(0xff173a8d):Colors.transparent,
                                                      borderRadius: BorderRadius.circular(2),
                                                      border: Border.all(width: 1,color:_selectionList[index]?Colors.transparent: const Color(0xff173a8d))
                                                  ),
                                                  width: 15,
                                                  height: 15,
                                                ),
                                                Container(
                                                  width:140,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:08.0),
                                                    child: Text(
                                                      //_mechanicDetails!.mechanicService![index].service!.serviceName,
                                                      _AddPriceServiceList!.data![index].serviceName.toString(),
                                                      //'Towing service',
                                                      softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'SamsungSharpSans-Medium',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left:07.0,bottom: 05),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffd3dcf2)
                                        ),
                                        borderRadius: BorderRadius.circular(05)
                                    ),
                                    height: 30,
                                    width: 72,
                                    child: TextButton(
                                      // height: 30,
                                      // width: 60,
                                      // decoration: BoxDecoration(
                                      //   border: Border.all(color: const Color(0xffc7c0c0),
                                      //   width: 1),
                                      //   borderRadius: BorderRadius.circular(05)
                                      // ),
                                      onPressed: () {

                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        //primary: Color(0xffd3dcf2),
                                        // shape:
                                        // RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:10.0,bottom: 4),
                                        child:
                                        InkWell(
                                          onTap: ()async {
                                            if(_selectionList[index]){
                                              print(" _timeController.text >>> ${_textEditContoller.text}" );
                                              Duration? _durationResult = await showDurationPicker(
                                                  snapToMins: 5.0,
                                                  context: context,
                                                  initialTime: Duration(
                                                    //hours: 2,
                                                      minutes: int.parse(_textEditContoller.text.toString().replaceAll(":00", "")),
                                                      seconds: 00,
                                                      milliseconds: 0)
                                              );
                                              print("_durationResult >>>" + _durationResult!.inMinutes.toString() + ":00");
                                              print(" _timeController.text02 >>> ${_textEditContoller.text}" );
                                              if(_durationResult != null){
                                                setState(() {
                                                  _textEditContoller.text = "";
                                                  _textEditContoller.text = _durationResult.inMinutes.toString() + ":00";
                                                  print(" _timeController.text03 >>> ${_textEditContoller.text}" );
                                                });
                                              }
                                            }
                                          },
                                          child: TextFormField(
                                            cursorColor: CustColors.light_navy,
                                            keyboardType: TextInputType.datetime,
                                            decoration: InputDecoration(
                                                border: InputBorder.none
                                            ),
                                            enabled: false,
                                            showCursor: false,
                                            controller: _textEditContoller,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0,bottom: 05),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffd3dcf2)
                                        ),
                                        borderRadius: BorderRadius.circular(05)
                                    ),
                                    height: 30,
                                    width: 72,
                                    child: TextButton(
                                      onPressed: () {  },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:10.0,bottom: 4),
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.trim().isEmpty){
                                              return "Fill field";
                                            }
                                            if(int.parse(value) < int.parse(_AddPriceServiceList!.data![index].minPrice) ){
                                              return _AddPriceServiceList!.data![index].minPrice +"-" + _AddPriceServiceList!.data![index].maxPrice;
                                            }
                                            if(int.parse(value) > int.parse(_AddPriceServiceList!.data![index].maxPrice)){
                                              return _AddPriceServiceList!.data![index].minPrice +"-" + _AddPriceServiceList!.data![index].maxPrice;
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          cursorColor: CustColors.light_navy,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                            errorStyle: TextStyle(
                                              color: Colors.red,
                                              fontSize: 9,
                                            )
                                          ),
                                          enabled: _selectionList[index],
                                          controller: _textEditContoller01,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                          ],
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      // child: Padding(
                                      //   padding: const EdgeInsets.only(left:5.0),
                                      //   child: Row(
                                      //     children: [
                                      //       Padding(
                                      //         padding: const EdgeInsets.only(right: 5.0),
                                      //         child: Text('₦',
                                      //
                                      //           style: TextStyle(
                                      //             fontSize: 12,
                                      //             fontWeight: FontWeight.w500,
                                      //             color: Colors.black
                                      //           ),),
                                      //       ),
                                      //       SizedBox(height: 10,),
                                      //       Text(
                                      //         _mechanicDetails!.mechanicService![index].fee,
                                      //         //'800',
                                      //       style: TextStyle(
                                      //         fontSize: 12,
                                      //           fontWeight: FontWeight.w500,
                                      //         color: Colors.black,
                                      //       ),),
                                      //       Padding(
                                      //         padding: const EdgeInsets.only(left: 5.0),
                                      //         child: Icon(Icons.edit,
                                      //         size: 12,
                                      //         color: const Color(0xff173a8d),),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: Divider(height: 02),
                          )
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/Group 3460.svg",
                            width: 30,
                            height: 30),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text("Edited prices should need approval from admin."
                                "So please wait for the approval from adminside."
                                "click save changes to send modified rates to"
                                " adminside",
                              style: TextStyle(
                                fontFamily: 'SamsungSharpSans-Regular',
                                fontSize: 12,
                              ),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 230.0,top: 24),
                child: saveloading?CircularProgressIndicator(color: CustColors.light_navy):
                Container(
                  height: 40,
                  width: 130,
                  child: TextButton(
                    onPressed: () async {
                      SharedPreferences shdPre = await SharedPreferences.getInstance();
                      setState(() {

                        for(int i =0;i<_selectionList.length;i++)
                        {
                          if(_selectionList[i])
                          {
                            print(" >>>> _lodingIdList.add(_selectionList[i].toString()); >>> ${_lodingIdList.toString()}" );
                            _lodingIdList.add(_selectionList[i].toString());
                            _timeListEmergency?.add('${_timeList![i]}');
                            _priceListEmergency?.add('${_priceList![i]}');
                            _serviceIdEmergency?.add('${_AddPriceServiceList?.data?[i].id}');
                          }
                        }

                        print('$_timeListEmergency >>>>_timeListEmergency ');
                        print('$_priceListEmergency >>>>_priceListEmergency ');
                        print('$_serviceIdEmergency >>>>_serviceIdEmergency ');

                        if(_lodingIdList.length == 0)
                        {
                          saveloading = false;
                        }
                        else
                        {
                          saveloading = true;
                        }
                        // _addPriceFaultReviewBloc.postUpdateAddPriceFaultReviewRequest(
                        //     authToken,
                        //     mechanicId,
                        //     "${_timeListEmergency}",
                        //     "${_priceListEmergency}",
                        //     "${_serviceIdEmergency}",
                        String time = "[";
                        for(int i=0; i<_timeListEmergency!.length; i++){
                          time = time + """\"${_timeListEmergency![i]}\", """;
                        }
                        time = time+"]";

                        String fee = "[";
                        for(int i=0;i<_priceListEmergency!.length;i++){
                          fee = fee + """\"${_priceListEmergency![i]}\", """;
                        }
                        fee = fee + "]";
                        //print("hdgjdv 001 $s");
                        _addPriceFaultReviewBloc.postTimeServicePriceAddReviewRequest(
                          authToken,
                          _serviceIdEmergency.toString().replaceAll("[", "").replaceAll("]", ""),
                          fee, time, "2"
                        );
                      });
                    },
                    child: Text('Save changes',
                      style: TextStyle(
                        fontFamily: 'SamsungSharpSans-Medium',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Color(0xff173a8d),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
      //backgroundColor: const Color(0xff9f9f9),
    );
  }

  @override
  bool get wantKeepAlive => true;

  /*void onTap() {
    Picker(
      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
        const NumberPickerColumn(begin: 0, end: 999, suffix: Text(' hours')),
        const NumberPickerColumn(begin: 0, end: 60, suffix: Text(' minutes'), jump: 15),
      ]),
      delimiter: <PickerDelimiter>[
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ),
        )
      ],
      hideHeader: true,
      confirmText: 'OK',
      confirmTextStyle: TextStyle(inherit: false, color: Colors.red, fontSize: 22),
      title: const Text('Select duration'),
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List<int> value) {
        // You get your duration here
        Duration _duration = Duration(hours: picker.getSelectedValues()[0], minutes: picker.getSelectedValues()[1]);
      },
    ).showDialog(context);
  }*/

}















//   String authToken = "", mechanicId = "",
//    search="" ;
//   int page=0,size=10;
//       bool _isLoadingPage = false;
//   bool saveloading = false;
//   List<bool> _selectionList=[];
//   AddPriceFaultReviewBloc _addPriceFaultReviewBloc=AddPriceFaultReviewBloc();
//   MechanicDetails? _mechanicDetails;
//   UpdateTimeFees? _updateTimeFees;
//   AddPriceServiceList? _AddPriceServiceList;
//   List<String>? _timeList=[];
//   List<String>? _priceList=[];
//   AutovalidateMode _autoValidate = AutovalidateMode.disabled;
//   @override
//   void initState() {
//     super.initState();
//     getSharedPrefData();
//     _listenApiResponse();
//
//   }
//   Future<void> getSharedPrefData() async {
//     print('getSharedPrefData');
//     SharedPreferences shdPre = await SharedPreferences.getInstance();
//     setState(() {
//       authToken = shdPre.getString(SharedPrefKeys.token).toString();
//       mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
//       // page = shdPre.getPre.getString(SharedPrefKeys.page).toString();
//       // search = shdPre.getPre.getString(SharedPrefKeys.search).toString();
//       print('userFamilyId ' + authToken.toString());
//       //print('userId ' + userId.toString());
//       // _addPriceFaultReviewBloc.postAddFetchPriceFaultReviewRequest(
//       //    authToken,
//       //     mechanicId);
//       _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
//           authToken,
//           page,
//           size,
//           search,
//           mechanicId,
//           2);
//        // (
//        //    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTYsInVzZXJUeXBlSWQiOjIsImlhdCI6MTY1MzYzNTM5MCwiZXhwIjoxNjUzNzIxNzkwfQ.9X7mXkvlVX6XxXuXxs5go-Sfp1Mn7IrNXgKoZ_Y-WFs",
//        //    //authToken,
//        //    mechanicId );
//     });
//   }
//   _listenApiResponse(){
//     _addPriceFaultReviewBloc.EnrgRegAddPriceMdlResponse.listen((value) {
//       print("pieuiey 001 ${value.data}");
//       if(value.data == "error"){
//         setState(() {
//           _isLoadingPage = true;
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(value.data.toString(),
//                 style: const TextStyle(
//                     fontFamily: 'Roboto_Regular', fontSize: 14)),
//             duration: const Duration(seconds: 2),
//             backgroundColor: CustColors.light_navy,
//           ));
//         });
//       }else{
//         setState(() {
//           _isLoadingPage = true;
//           _AddPriceServiceList = value.data!.addPriceServiceList;
//           _selectionList=[];
//           for(int i=0;i<_AddPriceServiceList!.data!.length;i++){
//             //if(_AddPriceServiceList!.data![i].status==1) {
//             if(_AddPriceServiceList!.data![i].mechanicService!.length>0){
//               _selectionList.add(true);
//             }
//             else{
//               _selectionList.add(false);
//             }
//             print("fddfds ${_timeList}");
//             if(_AddPriceServiceList!.data![i].mechanicService!.length>0) {
//               _timeList!.add(
//                   _AddPriceServiceList!.data![i].mechanicService![0].time);
//             }else{
//               _timeList!.add("12:00");
//             }
//             print("ewqr ${_priceList}");
//             if(_AddPriceServiceList!.data![i].mechanicService!.length>0) {
//               _priceList!.add(
//                   _AddPriceServiceList!.data![i].mechanicService![0].fee);
//             }
//             else{
//               _priceList!.add(_AddPriceServiceList!.data![i].minPrice);
//             }
//           };
//           print("vhvhfhjfh 01 ${_AddPriceServiceList!.data!.length}");
//         });
//       }
//     });
//     _addPriceFaultReviewBloc.UpdateAddPriceFaultMdlResponse.listen((value) {
//       if(value.data == "error"){
//         setState(() {
//           _isLoadingPage = true;
//           saveloading=false;
//           //SnackBarWidget().setMaterialSnackBar("Error",_scaffoldKey);
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(value.data.toString(),
//                 style: const TextStyle(
//                     fontFamily: 'Roboto_Regular', fontSize: 14)),
//             duration: const Duration(seconds: 2),
//             backgroundColor: CustColors.light_navy,
//           ));
//
//         });
//       }else{
//         setState(() {
//           //_isLoadingPage = true;
//           saveloading = false;
//           getSharedPrefData();
//           _updateTimeFees = value.data!.updateTimeFees;
//           //_selectionList=[];
//         });
//
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     //print('>>>>>>>>>>>>>>>>  +++  ${_AddPriceServiceList!.data!.length.toString()}');
//     return Scaffold(
//       backgroundColor: const Color(0xff9f9f9),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//              Container(
//               child: Padding(
//                 padding: const EdgeInsets.only(left:15,right:15,top: 26.0),
//                 child: Container(
//                   height: 35,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.white
//                     ),
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: TextField(
//                     onChanged: (value){
//                       _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
//                           authToken,
//                           page,
//                           size,
//                           value,
//                           mechanicId,
//                           2);
//                     },
//                     decoration:
//                     InputDecoration(
//                       // border: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(10),
//                       //   borderSide: BorderSide(color: Colors.white)
//                       // ),
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: Icon(Icons.search),
//                       hintText: 'Search Your  Service',
//                       contentPadding: EdgeInsets.only(top: 1),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//               _isLoadingPage==false?Center(child: CircularProgressIndicator(color:CustColors.light_navy)):
//               _AddPriceServiceList!.data!.length != 0 ||  _AddPriceServiceList!.data!.length != null
//               ? Container(
//                 child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: _AddPriceServiceList!.data!.length,
//                     itemBuilder: (BuildContext context, int index){
//                       TextEditingController _textEditContoller=TextEditingController();
//                       _textEditContoller.text=_timeList![index];
//                       TextEditingController _textEditContoller01=TextEditingController();
//                       _textEditContoller01.text=_priceList![index];
//                       _textEditContoller.addListener(() {
//                         _timeList!.removeAt(index);
//                         _timeList!.insert(index, _textEditContoller.text);
//
//                       });
//                       _textEditContoller01.addListener(() {
//                         _priceList!.removeAt(index);
//                         _priceList!.insert(index, _textEditContoller01.text);
//                       });
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 16.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex:290,
//                                     child: Row(
//                                      children:[
//                                        InkWell(
//                                          onTap:(){
//                                            setState(() {
//                                              bool s=!_selectionList[index];
//                                              _selectionList.removeAt(index);
//                                              _selectionList.insert(index,s );
//                                              if(!_selectionList[index]){
//                                                _textEditContoller.text=(_AddPriceServiceList!.data![0].mechanicService!.length>0)?_AddPriceServiceList!.data![0].mechanicService![0].time:"12:00";
//                                                _textEditContoller01.text=(_AddPriceServiceList!.data![0].mechanicService!.length>0)?_AddPriceServiceList!.data![0].mechanicService![0].fee:"1000";
//                                                setState(() {
//
//                                                });
//                                              }
//                                            });
//                                          },
//                                         child: Container(
//                                           height: 30,
//                                           //color: Colors.yellow,
//                                           child: Row(
//                                             children:[
//                                               Container(
//                                             // child: Icon(Icons.square,
//                                             // size: 8,),
//
//                                             decoration: BoxDecoration(color:_selectionList[index]? const Color(0xff173a8d):Colors.transparent,
//                                               borderRadius: BorderRadius.circular(2),
//                                               border: Border.all(width: 1,color:_selectionList[index]?Colors.transparent: const Color(0xff173a8d))
//                                             ),
//                                             width: 15,
//                                             height: 15,
//                                       ),
//                                               Container(
//                                                 width:140,
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.only(left:08.0),
//                                                   child: Text(
//                                                     //_mechanicDetails!.mechanicService![index].service!.serviceName,
//                                                     _AddPriceServiceList!.data![index].serviceName.toString(),
//                                                     //'Towing service',
//                                                     softWrap: true,
//                                                     overflow: TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                       fontFamily: 'SamsungSharpSans-Medium',
//                                                       fontSize: 14,
//                                                       fontWeight: FontWeight.w500,
//                                                     ),),
//                                                 ),
//                                               ),
//                                       ]
//                                           ),
//                                         ),
//                                     ),
//
//                                     ],
//                                     ),
//                                   ),
//
//                                   Expanded(
//                                     flex:120,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left:20.0,bottom: 05),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: const Color(0xffd3dcf2)
//                                             ),
//                                             borderRadius: BorderRadius.circular(05)
//                                         ),
//                                         height: 30,
//                                         width: 72,
//                                         child: TextButton(
//                                           onPressed: () {  },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: EdgeInsets.zero,
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(left:15.0,bottom: 4),
//                                             child:
//                                             TextFormField(
//                                               keyboardType: TextInputType.number,
//                                               decoration: InputDecoration(
//                                               border: InputBorder.none
//                                               ),
//                                               enabled: _selectionList[index],
//                                               controller: _textEditContoller,
//
//                                               inputFormatters: [
//                                                 LengthLimitingTextInputFormatter(2),
//                                                 FilteringTextInputFormatter.allow(
//                                                     RegExp('[0-9 :]')),
//                                               ],
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex:110,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left:05.0,bottom: 05),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: const Color(0xffd3dcf2)
//                                           ),
//                                           borderRadius: BorderRadius.circular(05)
//                                         ),
//                                         height: 30,
//                                         width: 72,
//                                         child: TextButton(
//
//                                           onPressed: () {  },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: EdgeInsets.zero,
//
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(left:15.0,bottom: 4),
//                                             child:
//                                             TextFormField(
//                                               //maxLength: 4,
//
//                                               // validator: (value){
//                                               //   if(int.parse(value!) < int.parse(_AddPriceServiceList!.data![0].minPrice) ||
//                                               //       int.parse(value) > int.parse(_AddPriceServiceList!.data![0].maxPrice)){
//                                               //     return _AddPriceServiceList!.data![0].minPrice +"_" + _AddPriceServiceList!.data![0].maxPrice;
//                                               //   }
//                                               //   else {
//                                               //     return null;
//                                               //   }
//                                               // },
//
//                                               keyboardType: TextInputType.number,
//
//                                               decoration: InputDecoration(
//                                                   border: InputBorder.none
//                                               ),
//                                               enabled: _selectionList[index],
//                                               controller: _textEditContoller01,
//                                               maxLines: 1,
//                                               inputFormatters: [
//                                                 LengthLimitingTextInputFormatter(4),
//                                                 FilteringTextInputFormatter.allow(
//                                                     RegExp('[0-9 ]')),
//                                               ],
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           //),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 15.0,right: 15.0),
//                             child: Divider(height: 02),
//                           )
//                         ],
//                       );
//                     }),
//               )
//               : Container(),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0),
//                 child: Container(
//                   height: 80,
//                   width: double.infinity,
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left:15.0),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset("assets/images/Group 3460.svg",
//                         width: 30,
//                         height: 30),
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 12.0),
//                             child: Text("Edited prices should need approval from admin."
//                               "So please wait for the approval from adminside."
//                               "click save changes to send modified rates to"
//                               " adminside",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontFamily: 'SamsungSharpSans-Regular',
//                               fontSize: 12,
//                             ),),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 230.0,top: 24),
//                 child: saveloading?CircularProgressIndicator(color: CustColors.light_navy):
//                 Container(
//                   height: 40,
//                   width: 130,
//                   child: TextButton(
//                       onPressed: () async {
//                         SharedPreferences shdPre = await SharedPreferences.getInstance();
//                         setState(() {
//                           for(int i=0;i<_AddPriceServiceList!.data!.length;i++){
//                             if(_selectionList[i]){
//                               saveloading = true;
//                               _addPriceFaultReviewBloc.postUpdateAddPriceFaultReviewRequest(
//                                   authToken,
//                                   mechanicId,
//                                   _timeList![i], _priceList![i], 2
//                               // _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
//                               //     authToken,
//                               //     page,
//                               //     size,
//                               //     search,
//                               //     mechanicId,
//                               //   2,
//                               );
//                               _isLoadingPage=false;
//                               setState(() {
//                                 _autoValidate = AutovalidateMode.always;
//                               });
//                             }else{
//
//                             }
//                           }
//
//                         });
//                       },
//                       child: Text('Save Changes',
//                       style: TextStyle(
//                         fontFamily: 'SamsungSharpSans-Medium',
//                         fontSize: 12,
//                         color: Colors.white,
//                       ),
//                       ),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       primary: Color(0xff173a8d),
//                       shape:
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10)
//     ],
//           ),
//         ),
//       ),
//       //backgroundColor: const Color(0xff9f9f9),
//     );
//   }
//
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
//
// }