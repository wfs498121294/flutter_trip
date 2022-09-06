
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebViewPage extends StatefulWidget {
  // const WebViewPage({Key? key,this.cookieManager}) : super(key: key);
  // final CookieManager? cookieManager;

  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  // control + enter 弹出构造方法
   WebViewPage({required this.url, required this.statusBarColor, required this.title, required this.hideAppBar,
    required this.backForbid});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  // 判断url是否是首页
  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
    }
    return contain;
  }
  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor;
    Color backButtonColor;
    if (statusBarColorStr == "faff") {
      backButtonColor = Colors.black;
    }
    else {
      backButtonColor = Colors.white;
    }

    // return const Scaffold(
    //   body:WebView(
    //     initialUrl: 'https://flutter.dev',
    //   )
    // );

    return Scaffold(
      body: Column(
        children: [
          _appBar(
              Color(int.parse("0xff" + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print("WebView is loading (progress : $progress%)");
              },
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
          )
        ],
      ),
    );
  }

  _appBar(Color backgroundColor,Color backButtonColor){

    if(widget.hideAppBar){
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    else{
      return FractionallySizedBox( // 可以撑满组件的宽度
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backgroundColor,
                  size: 16,
                ),
              ),
            ),
            Positioned(
              child: Center(
                  child: Text(widget.title,style: TextStyle(color: backButtonColor,fontSize: 20))
              ),
              left: 0,
              right: 0,
            )
          ],
        ),
      );
    }
  }
}
