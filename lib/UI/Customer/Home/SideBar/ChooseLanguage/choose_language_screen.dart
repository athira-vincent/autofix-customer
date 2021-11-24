import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseLanguageScreenState();
  }
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      child: Text('English'),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      child: Text('Igbo'),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      child: Text('Hausa'),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      child: Text('Yoruba'),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
