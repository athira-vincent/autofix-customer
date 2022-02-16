import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
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

  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            IndicatorWidget(isFirst: true,isSecond: false,isThird: false,isFourth: false,),

            Positioned(
              top: size.height * 0.100,
              child: Container(
                margin: EdgeInsets.only(),
                child: currentIndex == 0
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
                              child: Container(
                                width: 74.3,
                                height: 26.5,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.5,
                                ),
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Corbel_Bold'),
                                ),
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
                            child: Container(
                              width: 74.3,
                              height: 26.5,
                              padding: EdgeInsets.symmetric(
                                vertical: 5.5,
                                ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white, width: .3)),
                              child: Center(
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Corbel_Bold'),
                              ),
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(.5),
                          border: Border.all(color: Colors.white, width: .3)),
                      height: 20.5,
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Corbel_Bold'),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.09,left: size.width * 0.118,right: size.width * 0.118),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 5,
                    left: 10,
                    right: 10),
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
                        child: Container(
                          width: 74.3,
                          height: 26.5,
                          padding: EdgeInsets.symmetric(
                            vertical: 5.5,
                          ),
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Corbel_Bold'),
                            ),
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
                        child: Container(
                          width: 74.3,
                          height: 26.5,
                          padding: EdgeInsets.symmetric(
                            vertical: 5.5,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white, width: .3)),
                          child: Center(
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                  color: CustColors.azure,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Corbel_Bold'),
                            ),
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(.5),
                          border: Border.all(color: Colors.white, width: .3)),
                      height: 20.5,
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
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
    );
  }

  void setIswalked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isWalked, true);
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
    fontFamily: 'Corbel_Bold',
  );

  final largeTitleStyle = TextStyle(
    color: CustColors.azure,
    fontSize: 36.7,
    fontFamily: 'Corbel_Bold',
    fontWeight: FontWeight.bold,
  );

  final descriptionStyle = TextStyle(
    color: CustColors.greyish_purple,
    fontSize: 13.3,
    fontFamily: 'Corbel_Bold',
    fontWeight: FontWeight.w100,
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
            child: Image.asset(iconPath)
        ),

        Text(smallTitle,style: smallTitleStyle,),

        Text(largeTitle,style: largeTitleStyle,),

        Text(description,style: descriptionStyle,)

      ],
    );
  }
}
