import 'package:flutter/material.dart';

class SliderModel {
  String iconPath;
  String smallTitle;
  String largeTitle;
  String description;

  SliderModel(
      {required this.iconPath,
        required this.smallTitle,
        required this.largeTitle,
        required this.description});

}
List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];

  SliderModel sliderModel = new SliderModel(
    iconPath: "assets/image/ic_walk_through1.png",
    smallTitle: "WELCOME TO",
    largeTitle: "RESOLMECH",
    description: "WE CONNECT YOU WITH SERVICE PROVIDERS"
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
      iconPath: "assets/image/ic_walk_through2.png",
      smallTitle: "CAR IS IN TROUBLE ",
      largeTitle: "NEED HELP ? ",
      description: "A MECHANIC IN YOUR PALM! "
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
      iconPath: "assets/image/ic_walk_through3.png",
      smallTitle: "ARE YOU A ",
      largeTitle: "MECHANIC ? ",
      description: "LOTS OF CUSTOMERS WAITING FOR YOU "
  );
  slides.add(sliderModel);


  return slides;

}