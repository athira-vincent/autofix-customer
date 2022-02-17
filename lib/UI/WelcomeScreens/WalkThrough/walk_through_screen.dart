import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/WalkThrough/data_mdl.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    slides = getSlides();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [

              IndicatorWidget(isFirst: true,isSecond: false,isThird: false,isFourth: false,),

              Positioned(
                top: size.height * 0.134,
                left: size.width * 0.115,
                right: size.width * 0.115,
                child: Container(
                  width: size.width - 20,
                  //margin: EdgeInsets.only(left: size.width * 0.115,right: size.width * 0.115),
                  child: currentIndex == 0
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "SELECT LANGUAGE",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Samsung_SharpSans_Medium'),
                        ),
                      ),
                      Container(
                        child: DropdownButton(
                          value: selectedItem,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: language_list.map((String language){
                            return DropdownMenuItem(
                              value: language,
                              child: Text(language,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Samsung_SharpSans_Bold'
                              ),),
                            );
                          }).toList(),
                          onChanged: (var newVal){
                            setState(() {
                              print(newVal);
                              selectedItem = newVal.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  )
                      : Container(),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: size.height * 0.15,left: size.width * 0.115,right: size.width * 0.115),
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
                bottom: size.width * 0.06,
                left: size.width * 0.12,
                right: size.width * 0.12,
                child: Container(
                  width: size.width - 10,
                  child: currentIndex != slides.length - 1
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: GestureDetector(
                          onTap: () {
                            pageController.animateToPage(currentIndex + 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          },
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Corbel_Bold'),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: GestureDetector(
                          onTap: () {
                            //pageController.animateToPage(currentIndex - 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                            setIswalked();
                          },
                          child: Center(
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                  color: CustColors.azure,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Corbel_Bold'),
                            ),
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
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(.5),
                            border: Border.all(color: Colors.white, width: .3)),
                        height: 20.5,
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Corbel_Bold'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  void setIswalked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isWalked, true);
    prefs.setString(SharedPrefKeys.userLanguage, selectedItem);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => UserSelectionScreen()));
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

  final smallTitleStyle = TextStyle(
    color: CustColors.greyish_purple,
    fontSize: 23.3,
    height: 1.5,
    fontWeight: FontWeight.w300,
    fontFamily: 'Samsung_SharpSans_Regular',
  );

  final largeTitleStyle = TextStyle(
    color: CustColors.azure,
    fontSize: 36.7,
    fontFamily: 'Samsung_SharpSans_Medium',
    fontWeight: FontWeight.bold,
  );

  final descriptionStyle = TextStyle(
    color: CustColors.greyish_purple,
    fontSize: 13.3,
    fontFamily: 'Samsung_SharpSans_Regular',
    fontWeight: FontWeight.w200,
  );

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
            margin: EdgeInsets.only(top: size.width * 0.04),
            child: Image.asset(iconPath)
        ),

        Container(
          margin: EdgeInsets.only(top: size.width * 0.049),
          child: Text(smallTitle,style: smallTitleStyle,),
        ),

        Container(
            margin: EdgeInsets.only(top: size.width * 0.011),
            child: Text(largeTitle,style: largeTitleStyle,)
        ),

        Container(
            margin: EdgeInsets.only(top: size.width * 0.016),
            child: Text(description,style: descriptionStyle,))

      ],
    );
  }
}

