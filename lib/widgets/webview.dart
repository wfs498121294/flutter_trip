//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// class WebView extends StatefulWidget {
//
//   final String url;
//   final String statusBarColor;
//   final String title;
//   final bool hideAppBar;
//   final bool backForbid;
//
//   // control + enter 弹出构造方法
//     const WebView({required this.url, required this.statusBarColor, required this.title, required this.hideAppBar,
//      required this.backForbid});
//
//   // const WebView({
//   //   Key? key,
//   //   required this.url,
//   //   required this.statusBarColor,
//   //   required this.title,
//   //   required this.hideAppBar,
//   //   this.backForbid = false,
//   // }): super(key: key);
//
//   @override
//   State<WebView> createState() => _WebViewState();
// }
//
// class _WebViewState extends State<WebView> {
//
//   final webViewReference = FlutterWebviewPlugin();
//   late StreamSubscription <String> _onUrlChanged;
//   late StreamSubscription <WebViewStateChanged> _onStateChanged;
//   late StreamSubscription <WebViewHttpError> _onHttpError;
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     webViewReference.close();
//     _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {
//
//     });
//     _onStateChanged = webViewReference.onStateChanged.listen((WebViewStateChanged state) {
//
//      switch(state.type){
//
//        case WebViewState.shouldStart:
//          // TODO: Handle this case.
//          break;
//        case WebViewState.startLoad:
//          // TODO: Handle this case.
//          break;
//        case WebViewState.finishLoad:
//          // TODO: Handle this case.
//          break;
//        case WebViewState.abortLoad:
//          // TODO: Handle this case.
//          break;
//      }
//    });
//
//     _onHttpError = webViewReference.onHttpError.listen((WebViewHttpError error) {
//
//     });
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     // 取消监听
//     _onUrlChanged.cancel();
//     _onStateChanged.cancel();
//     _onHttpError.cancel();
//     webViewReference.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     String statusBarColorStr = widget.statusBarColor;
//     Color  backButtonColor;
//     if(statusBarColorStr == "faff"){
//       backButtonColor = Colors.black;
//     }
//     else{
//       backButtonColor = Colors.white;
//     }
//
//     return Scaffold(
//       body: Column(
//         children: [
//           _appBar(Color(int.parse("0xff"+statusBarColorStr)), backButtonColor),
//           Expanded(child: WebviewScaffold(url: widget.url,withZoom: false,withLocalStorage: true,hidden: true
//             ,)
//           )
//         ],
//       ),
//     );
//   }
//
//   _appBar(Color backgroundColor,Color backButtonColor){
//
//     if(widget.hideAppBar){
//       return Container(
//          color: backgroundColor,
//          height: 30,
//       );
//     }
//     else{
//       return FractionallySizedBox( // 可以撑满组件的宽度
//         widthFactor: 1,
//         child: Stack(
//           children: [
//             GestureDetector(
//               child: Container(
//                 margin: const EdgeInsets.only(left: 10),
//                 child: Icon(
//                   Icons.close,
//                   color: backgroundColor,
//                   size: 16,
//                 ),
//               ),
//             ),
//             Positioned(
//                 child: Center(
//                     child: Text(widget.title,style: TextStyle(color: backButtonColor,fontSize: 20))
//                 ),
//               left: 0,
//               right: 0,
//             )
//           ],
//         ),
//       );
//     }
//
//   }
// }
