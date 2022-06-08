import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'regularServices.dart';
import 'emergencyServices.dart';

class Addpricefault extends StatefulWidget{
  final int position;
  Addpricefault({required this.position});
  @override
  State<StatefulWidget> createState() {
    return _Addpricefault();
  }

}

class _Addpricefault extends State<Addpricefault> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  int? position;
 // _addpricefault(this.position);
  var regularServives01 = true;
  var emergencyServices01 = false;
  PageController _servicePage = PageController(initialPage: 0);
  TabController? _tabController;



  // @override
  // void initState(){
  //   super.initState();
  //   //getSharedPrefData();
  //   _listenApiResponse();
  // }

  @override
  void dispose() {
    super.dispose();
    _servicePage.dispose();
    _tabController=TabController(length: 2, vsync: this);
    _tabController!.addListener(() {

      setState(() {
        position=_tabController!.index;
        print("position 01 $position");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: Icon(Icons.arrow_back),*/
        backgroundColor: const Color(0xff173a8d),
        toolbarHeight: 80,
        elevation: 0,

        title: Container(
          child: Text('Add price & fault',
            style: TextStyle(
              fontFamily: 'SamsungSharpSans-Medium',
              fontSize: 16.7,
            ),),
        ),
        centerTitle: true,
      ),

      body:DefaultTabController(
        length: 2,

        child: Container(
          color: Color(0xfff9f9f9),
          //margin: EdgeInsets.only(right: 60),
          child: Column(
            children: [
              TabBar(
                onTap: (int index){
                  setState(() {
                    position=index;
                    print("position 02 $position");
                  });
                },
                controller: _tabController,
                 indicatorWeight: 8,
                //isScrollable: true,
                padding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.label,
                 indicator: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),shape: BoxShape.rectangle,color: Color(0xff173a8d)),
                labelPadding: EdgeInsets.all(0),
                indicatorPadding: EdgeInsets.only(left:30,right: 30),
                indicatorColor: Color(0xff173a8d),
                tabs: [
              Container(
                width: double.infinity,
                  //width: 150,
                  color: Colors.white,
                 padding: EdgeInsets.only(left: 15,bottom: 15,top: 15),
                  child: Text('Regular Services')),
                  Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 15,top: 15),
                      child: Text("Emergency Services",
                      textAlign: TextAlign.start,))
              ],),
              Flexible(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children:
                [
                  RegularServices(),
                  EmergencyServices()
                ],),
              )
            ],
          ),
        ),
      ),

      // Container(
      //   child: Column(
      //     children: [
      //      Padding(
      //       padding: const EdgeInsets.only(left: 15.0,top: 14.0),
      //       child: Row(
      //         children: [
      //           InkWell(
      //             onTap: (){
      //               _servicePage.jumpToPage(0);
      //             },
      //             child: Container(
      //               margin: EdgeInsets.only(right: 4,),
      //               child: Text('Regular services',
      //               style: TextStyle(
      //                 color: regularServives01 ==true
      //                 ? Colors.black
      //                 : Color(0xff9a9999),
      //                 fontFamily: 'SamsungSharpSans-Medium',
      //                 fontSize: 10,
      //                   fontWeight: FontWeight.bold,
      //               ),),
      //             ),
      //           ),
      //           regularServives01 == true
      //               ? Container(
      //               width: 78.2,
      //               height: 10,
      //               margin: EdgeInsets.only(top: 05),
      //               child: Text("----------",
      //               style: TextStyle(
      //                 fontWeight: FontWeight.w900
      //               ),)
      //           )
      //           : Container(
      //               width: 78.2,
      //               height: 4,
      //              // margin: EdgeInsets.only(top: 12),
      //           ),
      //           InkWell(
      //             onTap: (){
      //               _servicePage.jumpToPage(1);
      //             },
      //             child: Container(
      //               margin: EdgeInsets.only(left: 20,bottom: 1),
      //               child: Text('Emergency services',
      //               style: TextStyle(
      //                 color: emergencyServices01 == true
      //                     ? Colors.black
      //                     : Color(0xff9a9999),
      //                 fontFamily: 'SamsungSharpSans-Medium',
      //                 fontSize: 10,
      //                 fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),),
      //       SizedBox(height: 10,),
      //       Flexible(
      //           child: Container(
      //             child: PageView(
      //               controller: _servicePage,
      //               onPageChanged: _onPageViewChange,
      //               physics: new NeverScrollableScrollPhysics(),
      //               children: [
      //                 regularServices(servicePage:_servicePage),
      //                 emergencyServices(servicePage:_servicePage)
      //               ],
      //             ),
      //           ))
      // ],
      //   ),
      // ),
    );
  }

  _onPageViewChange(int page) async{
    setState(() {
      if (page == 0) {
        regularServives01 = true;
        emergencyServices01 = false;
      }else{
        regularServives01 = false;
        emergencyServices01 = true;
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}