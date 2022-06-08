import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacypolicy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Privacypolicy();
  }

}
class _Privacypolicy extends State<Privacypolicy>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        backgroundColor: const Color(0xff173a8d),
        toolbarHeight: 60,
        elevation: 0,
        title: Container(
          child: Text('Privacy policy',
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
            initialUrl: "https://autofix-web.techlabz.in/privacy-policy",
            ),
        ),
      ),
      );
  }
}