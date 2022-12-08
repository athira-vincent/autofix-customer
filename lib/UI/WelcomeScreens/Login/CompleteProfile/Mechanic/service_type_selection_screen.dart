import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/emergancy_service_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/regular_service_list.dart';
import 'package:auto_fix/Widgets/service_type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceTypeSelectionScreen extends StatefulWidget {

  ServiceTypeSelectionScreen();

  @override
  State<StatefulWidget> createState() {
    return _ServiceTypeSelectionScreenState();
  }
}

class _ServiceTypeSelectionScreenState extends State<ServiceTypeSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width:  size.width,
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(
              top: size.height * 0.040,
              bottom: size.height * 0.049,
              left: size.width * 0.06,
              right: size.width * 0.06
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context)!.text_select_your_services_on_both_categories,
                      style: Styles.serviceSelectionTitle01Style,)),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.026,
                      right: size.width * 0.06,
                      left: size.width * 0.06,
                      bottom: size.height * 0.035
                  ),
                  height: size.height * 0.82,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: InkWell(
                          onTap : (){
                            //Navigator.pop(context,"Regular");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegularServiceListScreen()));
                          },
                          child: ServiceTypeSelectionWidget(
                            imagePath: 'assets/image/img_service_regular.png',
                            titleText: Text(AppLocalizations.of(context)!.text_regular,
                                style: Styles.titleTextStyle),
                            //titleText: ,
                          ),
                        ),
                      ),

                      Center(
                        child: InkWell(
                          onTap: (){
                            //Navigator.pop(context,"Emergency");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EmergencyServiceListScreen()));
                          },
                          child: ServiceTypeSelectionWidget(
                            imagePath: 'assets/image/img_service_emergency.png',
                            titleText: Text(AppLocalizations.of(context)!.text_emergency,
                                style: Styles.titleTextStyle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}