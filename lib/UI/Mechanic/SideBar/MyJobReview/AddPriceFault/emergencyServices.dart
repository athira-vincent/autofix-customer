import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/cust_colors.dart';
import 'add_price_fault_bloc.dart';
import 'add_price_fault_mdl.dart';
import 'emrg_reglr_add_price_mdl.dart';
import 'update_time_add_price_mdl.dart';

class EmergencyServices extends StatefulWidget{
  EmergencyServices({Key? key,}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EmergencyServices();
  }

}
class _EmergencyServices extends State<EmergencyServices>{
  String authToken = "", mechanicId = "",
      search="" ;
  int page=0,size=10;
  bool _isLoadingPage = false;
  List<bool> _selectionList=[];
  AddPriceFaultReviewBloc _addPriceFaultReviewBloc=AddPriceFaultReviewBloc();
  MechanicDetails? _mechanicDetails;
  UpdateTimeFees? _updateTimeFees;
   AddPriceServiceList? _AddPriceServiceList;
  List<String>? _timeList=[];
  List<String>? _priceList=[];
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
      // page = shdPre.getPre.getString(SharedPrefKeys.page).toString();
      // search = shdPre.getPre.getString(SharedPrefKeys.search).toString();
      print('userFamilyId ' + authToken.toString());
      //print('userId ' + userId.toString());
      _addPriceFaultReviewBloc.postAddFetchPriceFaultReviewRequest(
          authToken,
          mechanicId);
      _addPriceFaultReviewBloc.postEnrgRegAddPriceReviewRequest(
          authToken,
          page,
          size,
          search,
          mechanicId,
          1);
      // (
      //    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTYsInVzZXJUeXBlSWQiOjIsImlhdCI6MTY1MzYzNTM5MCwiZXhwIjoxNjUzNzIxNzkwfQ.9X7mXkvlVX6XxXuXxs5go-Sfp1Mn7IrNXgKoZ_Y-WFs",
      //    //authToken,
      //    mechanicId );
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
            backgroundColor: CustColors.peaGreen,
          ));
        });
      }else{
        setState(() {
          _isLoadingPage = true;
          _AddPriceServiceList = value.data!.addPriceServiceList!;
          _selectionList=[];
          for(int i=0;i<_AddPriceServiceList!.data!.length;i++){
            //if(_AddPriceServiceList!.data![i].status==1) {
            if(_AddPriceServiceList!.data![i].mechanicService!.length>0){
              _selectionList.add(true);
            }
            else{
              _selectionList.add(false);
            }
            print("fddfds ${_timeList}");
            if(_AddPriceServiceList!.data![i].mechanicService!.length>0) {
              _timeList!.add(
                  _AddPriceServiceList!.data![i].mechanicService![0].time);
            }else{
              _timeList!.add("12:00");
            }
            print("ewqr ${_priceList}");
            if(_AddPriceServiceList!.data![i].mechanicService!.length>0) {
              _priceList!.add(
                  _AddPriceServiceList!.data![i].mechanicService![0].fee);
            }
            else{
              _priceList!.add(_AddPriceServiceList!.data![i].minPrice);
            }
          };
          print("vhvhfhjfh 01 ${_AddPriceServiceList!.data!.length}");
        });
      }
    });
    _addPriceFaultReviewBloc.UpdateAddPriceFaultMdlResponse.listen((value) {
      if(value.data == "error"){
        setState(() {
          _isLoadingPage = true;
          //SnackBarWidget().setMaterialSnackBar("Error",_scaffoldKey);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.data.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      }else{
        setState(() {
          _isLoadingPage = true;
          _updateTimeFees = value.data!.updateTimeFees;
          _selectionList=[];
          // for(int i=0;i<_mechanicDetails!.mechanicService!.length;i++){
          //   if(_mechanicDetails!.mechanicService![i].status==1) {
          //     _selectionList.add(true);
          //   }
          //   else{
          //     _selectionList.add(false);
          //   }
          // };
          print("ldjgjgj ${_mechanicDetails!.firstName}");
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9f9f9),
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
                      decoration:
                      InputDecoration(
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: BorderSide(color: Colors.white)
                        // ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Your  Service',
                        contentPadding: EdgeInsets.only(top: 1),
                      ),
                    ),
                  ),
                ),
              ),
              _isLoadingPage==false?Center(child: CircularProgressIndicator()):
              Container(
                child: ListView.builder(
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
                        _priceList!.insert(index, _textEditContoller01.text);
                      });
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 34.0,right: 16.0,top: 16.0),
                            // child: InkWell(
                            //   onTap:(){
                            //     setState(() {
                            //       bool s=!_selectionList[index];
                            //       _selectionList.removeAt(index);
                            //       _selectionList.insert(index,s );
                            //       if(!_selectionList[index]){
                            //         _textEditContoller.text=_mechanicDetails!.mechanicService![index].time;
                            //         setState(() {
                            //
                            //         });
                            //       }
                            //     });
                            //   },
                            child: Row(
                              children: [
                                Expanded(
                                  flex:150,
                                  child: Row(
                                    children:[
                                      InkWell(
                                        onTap:(){
                                          setState(() {
                                            bool s=!_selectionList[index];
                                            _selectionList.removeAt(index);
                                            _selectionList.insert(index,s );
                                            if(!_selectionList[index]){
                                              _textEditContoller.text=_AddPriceServiceList!.data![0].mechanicService![0].time;
                                              _textEditContoller01.text=_AddPriceServiceList!.data![0].mechanicService![0].fee;
                                              setState(() {

                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          // child: Icon(Icons.square,
                                          // size: 8,),

                                          decoration: BoxDecoration(color:_selectionList[index]? const Color(0xff173a8d):Colors.transparent,
                                              borderRadius: BorderRadius.circular(2),
                                              border: Border.all(width: 1,color:_selectionList[index]?Colors.transparent: const Color(0xff173a8d))
                                          ),
                                          width: 13,
                                          height: 13,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:23.0,right:27.0),
                                        child: Text(
                                          //_mechanicDetails!.mechanicService![index].service!.serviceName,
                                          _AddPriceServiceList!.data![index].serviceName.toString(),
                                          //'Towing service',
                                          style: TextStyle(
                                            fontFamily: 'SamsungSharpSans-Medium',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),),
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
                                      onPressed: () {  },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        //primary: Color(0xffd3dcf2),
                                        // shape:
                                        // RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:15.0,bottom: 4),
                                        child:
                                        TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                          enabled: _selectionList[index],
                                          controller: _textEditContoller,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9 :]')),
                                          ],
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
                                        padding: const EdgeInsets.only(left:15.0,bottom: 4),
                                        child:
                                        TextFormField(

                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                          enabled: _selectionList[index],
                                          controller: _textEditContoller01,
                                          inputFormatters: [
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
                          //),
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
                                "adminside",
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
                child: Container(
                  height: 40,
                  width: 130,
                  child: TextButton(
                    onPressed: () async {
                      SharedPreferences shdPre = await SharedPreferences.getInstance();
                      setState(() {
                        for(int i=0;i<_AddPriceServiceList!.data!.length;i++){
                          if(_selectionList[i]){
                            _addPriceFaultReviewBloc.postUpdateAddPriceFaultReviewRequest(
                                authToken,
                                mechanicId,
                                _timeList![i], _priceList![i], 1
                            );
                          }
                        }

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
            ],
          ),
        ),
      ),
      //backgroundColor: const Color(0xff9f9f9),
    );
  }

}