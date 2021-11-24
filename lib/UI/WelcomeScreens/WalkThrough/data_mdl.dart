import 'package:flutter/material.dart';

class SliderModel{

  Widget imageAsset;
  //String backgroundAssetPath;
  String title;
  String desc;

  SliderModel({
    required this.imageAsset,
    //required this.backgroundAssetPath,
    required this.title,
    required this.desc
  });

  void setImageAsset(Widget getImageAsset){
    imageAsset = getImageAsset as Widget;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  Widget getImageAsset(){
    return imageAsset;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}

List<SliderModel> getSlides(){

  List<SliderModel> slides = <SliderModel>[];

  SliderModel sliderModel = new SliderModel(
    desc: "We provide services for Customers,  Mechanics, Spare parts vendors",
    title: "Our Services",
    imageAsset: Container(
        child: Stack(
          children: [
            Image.asset("assets/images/walkthrough_s1_background.png",
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0,75,0,0),
              child: Image.asset("assets/images/walkthrough_s1_icon.png",
                height: 250,
                width: 250,
              ),
            ),
          ],
        ),
      ),
    );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: "Sign up as a customer and fix your car repair and maintenance. ",
    title: "Customers",
    imageAsset: Stack(
      children: [
        Image.asset("assets/images/walkthrough_s2_background.jpg",
        ),
        Container(
          width: double.infinity,
          // color: Colors.pink,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, 125, 80, 0),
          child: Image.asset("assets/images/walkthrough_s2_icon.png",
         /* height: 200,
          width: 200,*/),

        ),
      ],
    ),
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: "Sign up as a mechanic and find customers  near you. ",
    title: "Mechanic",
    imageAsset: Stack(
      children: [
        Image.asset("assets/images/walkthrough_s3_background.jpg",
        ),
        Container(
          width: double.infinity,
          // color: Colors.pink,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, 95, 145, 0),
          child: Image.asset("assets/images/walkthrough_s3_icon.png",
            /* height: 200,
          width: 200,*/
          ),
        ),
      ],
    ),
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: "Sign up as a spare parts vendor and provide spare parts for mechanic and customers",
    title: "Spare parts vendors",
   imageAsset: Stack(
     children: [
       Container(
         color: Colors.white,
         child: Column(
           children: [
             /*Positioned(
               child: Image.asset("assets/images/walkthrough_s4_background1.png",
               ),),*/
             Expanded(
               flex: 5,
               child:
               Align(
                 alignment: Alignment.topRight,
                 child: Image.asset("assets/images/walkthrough_s4_background1.png",
                   height: 125,
                   width: 125,
                   ),
               ),
              /* Container(
                 width: double.infinity,
                 color: Colors.yellowAccent,
                 alignment: Alignment.topRight,
                 padding: EdgeInsets.only(bottom: 20.0,left: 20,),
                 child: Image.asset("assets/images/walkthrough_s4_background1.png",
                   alignment: Alignment.topRight,),
               ),*/
             ),
             Expanded(
               flex: 5,
               child: Container(
                 color: Colors.white,
                 alignment: Alignment.topCenter,
                 padding: EdgeInsets.only(top: 75,left: 150),
                 child:  Image.asset(
                   "assets/images/walkthrough_s4_background2.png",
                   height: 75,
                   width: 75,
               ),
             ),
            ),
           ],
         ),
       ),
       Container(
         width: double.infinity,
         // color: Colors.pink,
         alignment: Alignment.centerLeft,
         padding: EdgeInsets.fromLTRB(0, 0, 125, 125),
         child: Image.asset("assets/images/walkthrough_s4_icon.png",
           /* height: 200,
          width: 200,*/
         ),
       ),
     ],

   ),
  );
  slides.add(sliderModel);

  return slides;
}