import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/WalkThrough/data_mdl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughPages  extends StatefulWidget {
  @override
  WalkThroughPagesState createState() => WalkThroughPagesState();
}

class WalkThroughPagesState extends State<WalkThroughPages> {

  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: slides.length,
            onPageChanged: (val){
              setState(() {
                currentIndex = val;
              });
            },
            itemBuilder: (context, index){
              return SliderTile(imageAsset: slides[index].getImageAsset(),
                title: slides[index].getTitle(),
                desc: slides[index].getDesc(),
              );
            },
          ),

          Positioned(
            height: 25,
            bottom: 33.3,
            left: 23.5,
            right: 23.5,
            child: currentIndex != slides.length - 1 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: GestureDetector(
                    onTap: (){
                      pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                      color: Colors.white,
                      child: Text(
                        "Next",
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: GestureDetector(
                    onTap: (){
                      //pageController.animateToPage(currentIndex - 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                      setIswalked();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
            :
            InkWell(
              child: GestureDetector(
                onTap: (){
                  setIswalked();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
                  color: Colors.white,
                  child: Text(
                      "Get Started"
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setIswalked()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isWalked, true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserSelectionScreen()));
  }
}

class SliderTile extends StatelessWidget {
  Widget imageAsset;
  String title, desc;
  SliderTile({Key? key,
    required this.imageAsset,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final smallTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 17,
     height: 1.5,
     fontFamily: 'Corbel_Regular',
  );

  final largeTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 33,
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
              aspectRatio: 1.56,
              child: Container(
                width: double.infinity,
                //alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/walkthrough_blue_filled_arc.png",
                    ),
                  ),
                ),
                child: Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(left: 23.5,right: 20,bottom: 70,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 12.5),
                        child: Text(title,style: largeTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 19,),
                        child: Text(desc,
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