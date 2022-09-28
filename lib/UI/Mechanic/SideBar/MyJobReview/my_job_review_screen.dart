import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_bloc.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_job_review_mdl.dart';

class MechanicMyJobReviewScreen extends StatefulWidget {

  MechanicMyJobReviewScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyJobReviewScreenState();
  }
}

class _MechanicMyJobReviewScreenState extends State<MechanicMyJobReviewScreen> {

  String authToken = "", mechanicId = "" ;
  MechanicMyJobReviewBloc _mechanicJobReviewBloc = MechanicMyJobReviewBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoadingPage = true;
  List<MechanicReviewsDatum>? _mechanicReviewsData = [];

  @override
  void initState() {
    // TODO: implement initState
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
      _mechanicJobReviewBloc.postMechanicFetchMyJobReviewRequest
        (authToken, mechanicId);
    });
  }

  _listenApiResponse() {
    _mechanicJobReviewBloc.postMechanicMyJobReview.listen((value) {
      if(value.status == "error"){
        setState(() {
          _isLoadingPage = false;
          //SnackBarWidget().setMaterialSnackBar("Error",_scaffoldKey);
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
          _isLoadingPage = false;
          _mechanicReviewsData = value.data!.mechanicReviewList!.mechanicReviewsData;
          print(">>>>>>>>>> Review data" + _mechanicReviewsData.toString());
          print(">>>>>>>>>> Review data" + _mechanicReviewsData!.length.toString());

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

   return Scaffold(
     appBar: AppBar(
       leading: InkWell(
         onTap: (){
           Navigator.pop(context);
         },
           child: Icon(Icons.arrow_back)),
       backgroundColor: const Color(0xff173a8d),
       toolbarHeight: 60,
       title: Container(
         child: Text('Reviews',
           style: TextStyle(
             fontFamily: 'SamsungSharpSans-Medium',
             fontSize: 16.7,
           ),),
       ),
       centerTitle: true,
     ),
     backgroundColor: Colors.white,
     body: SafeArea(
       child: Container(
         height: size.height,
         width: size.width,
         child: Container(
           child: Stack(
               children: [
                 _isLoadingPage == true
                     ? Center(
                      child: CircularProgressIndicator(color: CustColors.light_navy,),)
                     : Container(
                        child: _mechanicReviewsData!.length != 0 && _mechanicReviewsData!.length != null ?
                         ListView.builder(
                           shrinkWrap: true,
                           itemCount: _mechanicReviewsData!.length,
                           padding: EdgeInsets.only(left: 05, top: 05),
                           itemBuilder: (BuildContext context, int index) {
                               print(" _mechanicReviewsData!.length >>>> " + _mechanicReviewsData!.length.toString());
                               return Container(
                                   margin: EdgeInsets.only(top:06.0,left: 22.0,right: 22.0,bottom: 06.0),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.white,
                                     border: Border.all(
                                       color: const Color(0xff35375b),
                                       width: 1,
                                     ),
                                   ),
                                   height: 100,
                                   width: double.infinity,
                                   alignment: Alignment.center,
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                     children: [
                                       Expanded(
                                         flex:69,
                                         child: Container(
                                           child: Padding(
                                             padding: EdgeInsets.all(6),
                                             child: CircleAvatar(
                                               radius: 30,
                                               child: ClipOval(
                                                 child: _mechanicReviewsData![index].bookings!.customer!.customer![0].profilePic != null &&
                                                     _mechanicReviewsData![index].bookings!.customer!.customer![0].profilePic != ""
                                                     ?
                                                   Image.network(
                                                     _mechanicReviewsData![index].bookings!.customer!.customer![0].profilePic,
                                                     width: 75,
                                                     height: 75,
                                                     fit: BoxFit.cover,
                                                   )
                                                     :
                                                 SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg',
                                                     width:75,
                                                     height:75,
                                                     fit:BoxFit.cover),
                                               ),
                                             ),
                                           ),
                                         ), ),
                                       Expanded(
                                         flex:153,
                                         child: Container(
                                           //color: Colors.red,
                                           padding: const EdgeInsets.only(
                                               left:15.0,
                                               //right:20,
                                               top: 20),
                                           child: Column(
                                             crossAxisAlignment:CrossAxisAlignment.start,
                                             children: [
                                               //Text(_mechanicReviewsData[index].,
                                               Text(
                                                 _mechanicReviewsData![index].bookings!.customer!.firstName,
                                                 //'Lucko',
                                                 style: TextStyle(
                                                   fontFamily: 'Samsung_SharpSans_Medium',
                                                   fontSize: 10.0,
                                                 ),),
                                               SizedBox(height: 06),
                                               Text(
                                                 //'Good service…and good..',
                                                 _mechanicReviewsData![index].feedback,
                                                 overflow: TextOverflow.ellipsis,
                                                 maxLines: 1,
                                                 style: TextStyle(
                                                   fontFamily: 'Samsung_SharpSans_Medium',
                                                   fontSize: 10.0,
                                                 ),),
                                               SizedBox(height: 06),
                                               Text(
                                                 _mechanicReviewsData![index].bookings!.bookService![0].service!.serviceName,
                                                 //'Steering wheel',
                                                 //_mechanicReviewsData![index].bookings!.service!.serviceName!,
                                                 overflow: TextOverflow.ellipsis,
                                                 style: TextStyle(
                                                     fontFamily: 'Samsung_SharpSans_Medium',
                                                     fontSize: 10.0,
                                                     color: const Color(0xff838181)
                                                 ),)
                                             ],
                                           ),
                                         ),
                                       ),
                                       Expanded(
                                         flex: 93,
                                         child: Align(
                                           alignment:Alignment.center,
                                           child: Container(
                                             child: Padding(
                                               padding: const EdgeInsets.only(
                                                 //right: 12,
                                                 // left:64,
                                                   top: 20),
                                               child: Column(
                                                 children: [
                                                   RatingBar.builder(
                                                     ignoreGestures: true,
                                                     initialRating: _mechanicReviewsData![index].rating,
                                                     minRating: 1,
                                                     direction: Axis.horizontal,
                                                     allowHalfRating: true,
                                                     itemCount: 5,
                                                     itemSize: 10,
                                                     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                     itemBuilder: (context, _) => Icon(
                                                       Icons.star,
                                                         color: CustColors.blue,
                                                     ),
                                                     onRatingUpdate: (rating) {
                                                       print(rating);
                                                     },
                                                   ),
                                                   _mechanicReviewsData![index].feedback.length > 20
                                                       ? SizedBox(height: 2.5) : Container(),
                                                   _mechanicReviewsData![index].feedback.length > 20
                                                       ? InkWell(
                                                          onTap: (){

                                                          },
                                                         child: Padding(
                                                           padding: const EdgeInsets.only(top: 8.0),
                                                           child: RichText(
                                                             text:TextSpan(text: 'Read More',
                                                                 style:TextStyle(
                                                                   fontFamily: 'SamsungSharpSans-Regular',
                                                                   fontSize: 10,
                                                                   color: const Color(0xff173a8d),
                                                                 ),
                                                                 recognizer: TapGestureRecognizer()
                                                             ),
                                                           ),
                                                         ),
                                                       )
                                                       : Container()
                                               ],
                                             ),
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
                         Container(
                           width: size.width,
                           height: size.height,
                           margin: EdgeInsets.only(top:08.0,left: 23.0,right: 23.0,bottom: 00.0),
                           alignment: Alignment.center,
                           child: Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(top: 150.0),
                                 child: SvgPicture.asset('assets/image/bg_review.svg',
                                   height: 200,
                                 ),
                              ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 50.0),
                                 child: Container(
                                   height: 50,
                                   width: 350,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color: CustColors.white_02,
                                       border: Border.all(
                                           color: const Color(0xff35375b),
                                           width: 0
                                       )
                                   ),
                                   child: Row(
                                     children:[
                                       Padding(
                                         padding: const EdgeInsets.only(left: 22.0),
                                         child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
                                             width: 30,
                                             height: 30),
                                       ),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 16.0),
                                     child: Text("Sorry you have no reviews to show.",
                                     style: TextStyle(
                                       fontSize: 10,
                                       fontFamily: 'Samsung_SharpSans_Regular'
                                     ),),
                                   ),
                                   ]
                                   )
                                 ),
                               ),
                           ]
                           )
                        ),
                     ),
              ]
           ),
         ),
      ),
    ),
   );
  }
}