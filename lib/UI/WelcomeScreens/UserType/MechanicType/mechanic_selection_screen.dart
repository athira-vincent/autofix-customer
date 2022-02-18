import 'package:auto_fix/Widgets/user_category.dart';
import 'package:flutter/material.dart';

class MechanicSelectionScreen extends StatefulWidget {
  const MechanicSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicSelectionScreenState();
  }
}

class _MechanicSelectionScreenState extends State<MechanicSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                UserCategorySelectionWidget(titleText: "Individual",
                  imagePath: "assets/image/MechanicType/img_individual.png",),
                UserCategorySelectionWidget(titleText: "Corporate",
                  imagePath: "assets/image/MechanicType/img_corporate.png",),
              ],
            ),
          ),
        ),
      ),
    );
  }

}