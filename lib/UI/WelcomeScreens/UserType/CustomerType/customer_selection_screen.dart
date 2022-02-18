import 'package:auto_fix/Widgets/user_category.dart';
import 'package:flutter/material.dart';

class CustomerSelectionScreen extends StatefulWidget {
  const CustomerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerSelectionScreenState();
  }
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
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
                  imagePath: "assets/image/CustomerType/img_corporate.png",),
                UserCategorySelectionWidget(titleText: "Government bodies",
                  imagePath: "assets/image/CustomerType/img_government_bodies.png",),

              ],
            ),
          ),
        ),
      ),
    );
  }

}