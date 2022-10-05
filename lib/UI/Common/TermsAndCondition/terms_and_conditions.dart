import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TermsAndConditon();
  }

}
class _TermsAndConditon extends State<TermsAndConditon>{
  bool? isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

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
          child: Text('General Terms & Conditions',
            style: TextStyle(
              fontFamily: 'SamsungSharpSans-Medium',
              fontSize: 16.7,
            ),),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: WebView(
                initialUrl: "https://autofix-web.techlabz.in/terms-and-conditions",
                onProgress: (val){
                  print("finish >>> $val" );
                  if(val == 100){
                    setState(() {
                      isLoading = false;
                    });
                  }else{
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: isLoading!,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    CustColors.light_navy),
              ),
            ),
          )
        ],
      ),
      );
  }
}