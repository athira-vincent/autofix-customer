import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpAndSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpAndSupport();
  }

}
class _HelpAndSupport extends State<HelpAndSupport>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)
        ),
        backgroundColor: const Color(0xff173a8d),
        toolbarHeight: 60,
        elevation: 0,
        title: Container(
          child: Text('Terms & conditions',
            style: TextStyle(
              fontFamily: 'SamsungSharpSans-Medium',
              fontSize: 16.7,
            ),),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: WebView(
            initialUrl: "https://autofix-web.techlabz.in/about-us",
            ),
        ),
      ),
      );
  }
}