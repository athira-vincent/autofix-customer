// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  late WebViewController controller;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill Form"),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: WebView(
        javascriptChannels: _createJavascriptChannels(context),
        initialUrl: "https://app.banqmart.com/show-Form/10/10287/23",
        javascriptMode: JavascriptMode.unrestricted,
        onWebResourceError: (error) {
          print("error webview 01 $error");
        },
        onWebViewCreated: (WebViewController webViewController) async {
          controller = webViewController;
          _controller.complete(webViewController);
        },
      ),
    );
  }

  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
          name: 'Snackbar',
          onMessageReceived: (JavascriptMessage message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message.message)));
          }),
    };
  }
}
