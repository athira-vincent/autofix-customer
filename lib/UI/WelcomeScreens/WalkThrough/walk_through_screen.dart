import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/WalkThrough/data_mdl.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Provider/locale_provider.dart';
import '../../../l10n/l10n.dart';
import '../../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WalkThroughPages extends StatefulWidget {
  @override
  WalkThroughPagesState createState() => WalkThroughPagesState();

}

class WalkThroughPagesState extends State<WalkThroughPages> {

  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  List<String> language_list =  [
    TextStrings.app_language_name_english,
    TextStrings.app_language_name_igbo,
    TextStrings.app_language_name_hausa,
    TextStrings.app_language_name_yoruba,
  ];

 late String selectedItem = language_list[0];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("dkjdkjdhkhdk $context");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Builder(
        builder: (context) {
          slides = getSlides(context);
          return SafeArea(
            child: Stack(
              children: [

                IndicatorWidget(isFirst: true,isSecond: false,isThird: false,isFourth: false,),

                Positioned(
                  top: size.height * 0.110,
                  left: size.width * 0.115,
                  right: size.width * 0.06,
                  child: Container(
                    //width: size.width - 200,
                    //margin: EdgeInsets.only(left: size.width * 0.115,right: size.width * 0.115),
                    child: currentIndex == 0
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Text(
                              AppLocalizations.of(context)!.text_select_language,
                              style: Styles.SelectLanguageWalkThroughStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: size.height * 0.038,
                            width: size.width * 0.554,
                            padding: EdgeInsets.only(left: 5,right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.7),
                              border: Border.all(width: 0.3, color: CustColors.warm_grey),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selectedItem,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: language_list.map((String language){
                                  return DropdownMenuItem(
                                    value: language,
                                    child: Text(language,
                                      style: Styles.LanguageWalkThroughStyle,),
                                  );
                                }).toList(),
                                onChanged: (var newVal) async {
                                  SharedPreferences shdPre = await SharedPreferences.getInstance();
                                  if(newVal=="English")
                                  {
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, '');
                                    //final provider = Provider.of<LocaleProvider>(context, listen: false);
                                    //provider.setLocale(L10n.all.elementAt(0));
                                    MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'en'));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, 'en');
                                  }
                                  else if(newVal=="Igbo")
                                  {
                                    //final provider = Provider.of<LocaleProvider>(context, listen: false);
                                    //provider.setLocale(L10n.all.elementAt(1));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, '');
                                    MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'ig'));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, 'ig');
                                  }
                                  else if(newVal=="Hausa")
                                  {
                                    //final provider = Provider.of<LocaleProvider>(context, listen: false);
                                    //provider.setLocale(L10n.all.elementAt(2));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, '');
                                    MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'ha'));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, 'ha');
                                  }
                                  else if(newVal=="Yoruba")
                                  {
                                    //final provider = Provider.of<LocaleProvider>(context, listen: false);
                                    //provider.setLocale(L10n.all.elementAt(3));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, '');
                                    MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'yo'));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, 'yo');
                                  }
                                  else
                                  {
                                    //final provider = Provider.of<LocaleProvider>(context, listen: false);
                                    //provider.setLocale(L10n.all.elementAt(0));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, '');
                                    MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: 'en'));
                                    shdPre.setString(SharedPrefKeys.userLanguageCode, 'en');
                                  }
                                  setState(() {
                                    print(newVal);
                                    selectedItem = newVal.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.165,
                      left: size.width * 0.115,
                      right: size.width * 0.117),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: slides.length,
                    onPageChanged: (val) {
                      setState(() {
                        currentIndex = val;
                      });
                    },
                    itemBuilder: (context, index) {
                      return SliderTile(
                        iconPath: slides[index].iconPath,
                        smallTitle: slides[index].smallTitle,
                        largeTitle: slides[index].largeTitle,
                        description: slides[index].description,
                      );
                    },
                  ),
                ),

                Positioned(
                  bottom: size.height * 0.06,
                  left: size.width * 0.12,
                  right: size.width * 0.12,
                  child: Container(
                    width: size.width - 10,
                    child: currentIndex != slides.length - 1
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            pageController.animateToPage(currentIndex + 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.next,
                              style: Styles.nextWalkThroughStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //pageController.animateToPage(currentIndex - 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                            setIswalked();
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.text_skip,
                              style: Styles.skipWalkThroughStyle,
                            ),
                          ),
                        ),
                      ],
                    )
                        : InkWell(
                      child: GestureDetector(
                        onTap: () {
                          setIswalked();
                        },
                        child: Container(
                          width: 10,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(.5),
                              border: Border.all(color: Colors.white, width: .3)),
                          height: 20.5,
                          child: Text(
                            AppLocalizations.of(context)!.text_get_started, //'Get Started',
                            style: Styles.nextWalkThroughStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  void setIswalked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isWalked, true);
    prefs.setString(SharedPrefKeys.userLanguage, selectedItem);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

}

class SliderTile extends StatelessWidget {
  String iconPath;
  String smallTitle;
  String largeTitle;
  String description;
  SliderTile({
    Key? key,
    required this.iconPath,
    required this.smallTitle,
    required this.largeTitle,
    required this.description,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      //alignment: Alignment.bottomCenter,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: size.height * 0.43,
            width: size.width * 0.734,
           // margin: EdgeInsets.only(top: size.width * 0.04),
            child: Image.asset(iconPath)
        ),

        Container(
          margin: EdgeInsets.only(top: size.width * 0.060),
          child: Text(smallTitle,style: Styles.smallTitleStyle,),
        ),

        Container(
            margin: EdgeInsets.only(top: size.width * 0.018),
            child: Text(largeTitle,style: Styles.largeTitleStyle,)
        ),

        Container(
            margin: EdgeInsets.only(top: size.width * 0.018),
            child: Text(description,style: Styles.descriptionStyle,))

      ],
    );
  }
}

