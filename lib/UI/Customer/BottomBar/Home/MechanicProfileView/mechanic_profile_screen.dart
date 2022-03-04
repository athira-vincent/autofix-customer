import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Constants/cust_colors.dart';
import '../../../../../Constants/styles.dart';

class MechanicProfileViewScreen extends StatefulWidget {

  MechanicProfileViewScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicProfileViewScreenState();
  }
}

class _MechanicProfileViewScreenState extends State<MechanicProfileViewScreen> {


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";

  double _setValue(double value) {
    return value * per + value;
  }
  double _setValueFont(double value) {
    return value * perfont + value;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            uploadVechicleImage(size),
          ],
        ),
      ),
    );
  }


  Widget uploadVechicleImage(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,10),
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedGray.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Text('1200 Km'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,110,155,0),
                        child: Text('Away'),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90,10,0,0),
                    child: Container(
                      width: 125.0,
                      height: 125.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:Container(
                              child:CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child:  SvgPicture.asset('assets/image/CustomerType/upload_car_avathar.svg'),
                                  )))

                      ),
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,0,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedWhite.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,10,0),
                        child: Text('Reviews'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,110,10,0),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ],

        ),
      ),
    );
  }


}
