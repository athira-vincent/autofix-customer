import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class NoResultFoundScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoResultFoundScreenState();
  }
}

class _NoResultFoundScreenState extends State<NoResultFoundScreen> {
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: _setValue(26.8), left: _setValue(36.2)),
                    child: Image.asset(
                      'assets/images/back.png',
                      width: _setValue(10.6),
                      height: _setValue(19.1),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: _setValue(19.3),
                      left: _setValue(76.5),
                      right: _setValue(76.5)),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/no_result_found.png',
                    width: _setValue(189),
                    height: _setValue(189),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: _setValue(14.6)),
                      alignment: Alignment.center,
                      child: Text(
                        'Service not found',
                        style: TextStyle(
                            fontSize: _setValue(25),
                            color: CustColors.blue,
                            fontFamily: 'Corbel_Bold'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: _setValue(14.6)),
                      alignment: Alignment.center,
                      child: Text(
                        '!',
                        style: TextStyle(
                            fontSize: _setValue(25),
                            color: CustColors.red,
                            fontFamily: 'Corbel_Bold'),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: _setValue(11)),
                  alignment: Alignment.center,
                  child: Text(
                    'Go to previous page and search with another keyword!!',
                    style: TextStyle(
                        fontSize: _setValue(13),
                        color: CustColors.textgrey,
                        fontFamily: 'Corbel_Regular'),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Image.asset(
                'assets/images/white_arc.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
