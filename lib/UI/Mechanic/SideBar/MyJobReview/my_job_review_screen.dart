import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_bloc.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  bool _isLoadingPage = false;
  List<MechanicReviewsDatum>? _mechanicReviewsData=[];

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
      //print('userId ' + userId.toString());
      _mechanicJobReviewBloc.postMechanicFetchMyJobReviewRequest
        (
          // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTYsInVzZXJUeXBlSWQiOjIsImlhdCI6MTY1MzI4MTc4OSwiZXhwIjoxNjUzMzY4MTg5fQ.enH-wp0ibqAPeaE9cGkSLSTUV5pOFe2MiuUMumcYBok",
      authToken,
          mechanicId );
    });
  }

  _listenApiResponse() {
    _mechanicJobReviewBloc.postMechanicMyJobReview.listen((value) {
      if(value.status == "error"){
        setState(() {
          _isLoadingPage = true;
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
          _isLoadingPage = true;
          _mechanicReviewsData = value.data!.mechanicReviewList!.mechanicReviewsData;

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
                 _isLoadingPage==false
                     ?Center(child: CircularProgressIndicator(color: CustColors.light_navy,))
                     :
                 ListView.builder(
                   shrinkWrap: true,
                   itemCount: _mechanicReviewsData!.length,
                   padding: EdgeInsets.only(left: 05, top: 05),
                   itemBuilder: (BuildContext context, int index) {
                     return Container(
                       margin: EdgeInsets.only(top:08.0,left: 23.0,right: 23.0,bottom: 08.0),
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
                                 padding: const EdgeInsets.only(
                                     left: 18
                                 ),
                                 child: CircleAvatar(
                                   radius: 28,
                                   child: ClipOval(
                                     child: Image.network(
                                       'https://i.picsum.photos/id/799/200/200.jpg?hmac=zFQHfBiAYFHDNrr3oX_pQDYz-YWPWTDB3lIszvP8rRY',
                                       //_mechanicReviewsData![index].bookings!.customer!.customer[0].profilePic;
                                     ),
                                   ),
                                 ),
                               ),
                             ), ),

                           Expanded(
                             flex:153,
                             child: Container(
                               //color: Colors.red,
                               padding: const EdgeInsets.only(
                                   left:28.0,
                                   //right:20,
                                   top: 20),
                               child: Column(
                                 crossAxisAlignment:CrossAxisAlignment.start,
                                 children: [
                                   //Text(_mechanicReviewsData[index].,
                                   Text(
                                     //'Lucko',
                                     _mechanicReviewsData![index].bookings!.customer!.firstName,
                                     style: TextStyle(
                                       fontFamily: 'Samsung_SharpSans_Medium',
                                       fontSize: 10.0,
                                     ),),
                                   SizedBox(height: 05),
                                   Text(
                                     //'Good service…and good..',
                                     _mechanicReviewsData![index].feedback,
                                     style: TextStyle(
                                       fontFamily: 'Samsung_SharpSans_Medium',
                                       fontSize: 10.0,
                                     ),),
                                   SizedBox(height: 05),
                                   Text(
                                     //'Steering wheel',
                                     _mechanicReviewsData![index].bookings!.bookService![0].service!.serviceName!,
                                     //_mechanicReviewsData![index].bookings!.bookService![0].service!.serviceName,

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
                                 //scolor: Colors.yellow,s
                                 child: Padding(
                                   padding: const EdgeInsets.only(
                                     //right: 12,
                                     // left:64,
                                       top: 20),
                                   child: Column(
                                     children: [
                                       RatingBar.builder(
                                         initialRating: _mechanicReviewsData![index].rating,
                                         minRating: 1,
                                         direction: Axis.horizontal,
                                         allowHalfRating: true,
                                         itemCount: 5,
                                         itemSize: 10,
                                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                         itemBuilder: (context, _) => Icon(
                                           Icons.star,
                                           color: const Color(0xff173a8d),
                                         ),
                                         onRatingUpdate: (rating) {
                                           print(rating);
                                         },
                                       ),
                                       SizedBox(height: 5),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 13.0),
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
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),

                     );
                   },),
               ]
           ),
         ),
       ),
     ),
   );
  }
}