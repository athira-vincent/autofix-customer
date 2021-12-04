import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';

class SliderModel {
  Widget imageAsset;
  //String backgroundAssetPath;
  String title;
  String desc;

  SliderModel(
      {required this.imageAsset,
      //required this.backgroundAssetPath,
      required this.title,
      required this.desc});

  void setImageAsset(Widget getImageAsset) {
    imageAsset = getImageAsset as Widget;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  Widget getImageAsset() {
    return imageAsset;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];

  SliderModel sliderModel = new SliderModel(
    desc: "We provide services for Customers, Mechanics, \n"
        "Spare parts vendors.",
    title: "Our Services",
    imageAsset: Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/walkthrough_s1_background.png",
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(ScreenSize().setValue(63.8),
                ScreenSize().setValue(92.3), ScreenSize().setValue(63.8), 0),
            child: Image.asset(
              "assets/images/walkthrough_s1_icon.png",
            ),
          ),
        ],
      ),
    ),
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: "Sign up as a customer and fix your car repair and \nmaintenance. ",
    title: "Customers",
    imageAsset: Stack(
      children: [
        Image.asset(
          "assets/images/walkthrough_s2_background.jpg",
        ),
        Container(
          width: double.infinity,
          // color: Colors.pink,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(
              0, ScreenSize().setValue(100.4), ScreenSize().setValue(60.8), 0),
          child: Image.asset(
            "assets/images/walkthrough_s2_icon.png",
            /* height: 200,
          width: 200,*/
          ),
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
        Image.asset(
          "assets/images/walkthrough_s3_background.jpg",
        ),
        Container(
          width: double.infinity,
          // color: Colors.pink,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, 95, 145, 0),
          child: Image.asset(
            "assets/images/walkthrough_s3_icon.png",
            /* height: 200,
          width: 200,*/
          ),
        ),
      ],
    ),
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc:
        "sign up as a spare parts vendor to enjoy auto-fix connecting services",
    title: "Spare parts \nvendors",
    imageAsset: Stack(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/walkthrough_s4_background1.png",
                    height: 125,
                    width: 125,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 75, left: 150),
                  child: Image.asset(
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
          child: Image.asset(
            "assets/images/walkthrough_s4_icon.png",
          ),
        ),
      ],
    ),
  );
  slides.add(sliderModel);

  return slides;
}
