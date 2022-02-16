import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/WalkThrough/data_mdl1.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughPages1 extends StatefulWidget {
  @override
  WalkThroughPages1State createState() => WalkThroughPages1State();
}

class WalkThroughPages1State extends State<WalkThroughPages1> {
  List<SliderModel1> slides = <SliderModel1>[];
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);
  double _setValue(double value) {
    return value * per + value;
  }

  double per = .10;
  double perfont = .10;
  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: slides.length,
              onPageChanged: (val) {
                setState(() {
                  currentIndex = val;
                });
              },
              itemBuilder: (context, index) {
                return SliderTile(
                  imageAsset: slides[index].getImageAsset(),
                  title: slides[index].getTitle(),
                  desc: slides[index].getDesc(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: _setValue(27.8),
                    left: _setValue(23.3),
                    right: _setValue(23.3)),
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
                                width: _setValue(74.3),
                                height: _setValue(26.5),
                                padding: EdgeInsets.symmetric(
                                  vertical: _setValue(5.5),
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
                                width: _setValue(74.3),
                                height: _setValue(26.5),
                                padding: EdgeInsets.symmetric(
                                  vertical: _setValue(5.5),
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
                            width: _setValue(86.5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(.5),
                                border:
                                    Border.all(color: Colors.white, width: .3)),
                            height: _setValue(26.5),
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
  Widget imageAsset;
  String title, desc;
  SliderTile({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final smallTextStyle = TextStyle(
    color: Colors.white,
    fontSize: ScreenSize().setValueFont(13.3),
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: 'Corbel_Regular',
  );

  final largeTextStyle = TextStyle(
    color: Colors.white,
    fontSize: ScreenSize().setValueFont(29.5),
    fontFamily: 'Corbel_Bold',
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        imageAsset,
        Wrap(
          children: [
            AspectRatio(
              aspectRatio: 1.50,
              child: Container(
                width: double.infinity,
                //alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/walkthrough_blue_filled_arc.png",
                    ),
                  ),
                ),
                child: Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(
                      left: 23.5, right: 20, bottom: 70, top: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(
                          title,
                          style: largeTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          desc,
                          style: smallTextStyle,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
