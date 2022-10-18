import 'package:flutter/material.dart';
import '../../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SliderModel {
  String iconPath;
  String smallTitle;
  String largeTitle;
  String description;

  SliderModel(
      {required this.iconPath,
        required this.smallTitle,
        required this.largeTitle,
        required this.description,
      });

}
List<SliderModel> getSlides(BuildContext context) {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = new SliderModel(
    iconPath: "assets/image/ic_walk_through1.png",
    smallTitle: AppLocalizations.of(context)!.text_walk_through1_small_title,
    largeTitle: AppLocalizations.of(context)!.text_walk_through1_large_title,
    description: AppLocalizations.of(context)!.text_walk_through1_description,
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
      iconPath: "assets/image/ic_walk_through2.png",
    smallTitle: AppLocalizations.of(context)!.text_walk_through2_small_title,
    largeTitle: AppLocalizations.of(context)!.text_walk_through2_large_title,
    description: AppLocalizations.of(context)!.text_walk_through2_description,
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
      iconPath: "assets/image/ic_walk_through3.png",
      smallTitle: AppLocalizations.of(context)!.text_walk_through3_small_title,
      largeTitle: AppLocalizations.of(context)!.text_walk_through3_large_title,
      description: AppLocalizations.of(context)!.text_walk_through3_description,
  );
  slides.add(sliderModel);


  return slides;

}