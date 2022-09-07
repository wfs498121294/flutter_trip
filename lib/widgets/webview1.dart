
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebViewPage extends StatefulWidget {
  // const WebViewPage({Key? key,this.cookieManager}) : super(key: key);
  final CookieManager? cookieManager;

  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  // control + enter 弹出构造方法
   WebViewPage({required this.url, required this.statusBarColor, required this.title, required this.hideAppBar,
    required this.backForbid, this.cookieManager});

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
      // appBar: AppBar(
      //   title: const Text('Flutter WebView example'),
      //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      //   actions: <Widget>[
      //     NavigationControls(_controller.future),
      //     SampleMenu(_controller.future, widget.cookieManager),
      //   ],
      // ),
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
                if(_isToMain(url)){
                  if(widget.backForbid){//禁止返回
                    // _controller.loadUrl(url);
                  }
                }
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

    // if(widget.hideAppBar ?? false){
    //   return Container(
    //     color: backgroundColor,
    //     height: 30,
    //   );
    // }
    // else{
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
        color: backgroundColor,
        child: FractionallySizedBox( // 可以撑满组件的宽度
          widthFactor: 1,
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
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
        ),
      );
    }
  // }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            onPressed: () async {
              String? url;
              if (controller.hasData) {
                url = await controller.data!.currentUrl();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.hasData
                        ? 'Favorited $url'
                        : 'Unable to favorite',
                  ),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          );
        });
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,
  loadLocalFile,
  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller, CookieManager? cookieManager, {Key? key})
      : cookieManager = cookieManager ?? CookieManager(),
        super(key: key);

  final Future<WebViewController> controller;
  late final CookieManager cookieManager;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          key: const ValueKey<String>('ShowPopupMenu'),
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.showUserAgent:
                _onShowUserAgent(controller.data!, context);
                break;
              case MenuOptions.listCookies:
                _onListCookies(controller.data!, context);
                break;
              case MenuOptions.clearCookies:
                _onClearCookies(context);
                break;
              case MenuOptions.addToCache:
                _onAddToCache(controller.data!, context);
                break;
              case MenuOptions.listCache:
                _onListCache(controller.data!, context);
                break;
              case MenuOptions.clearCache:
                _onClearCache(controller.data!, context);
                break;
              case MenuOptions.navigationDelegate:
                // _onNavigationDelegateExample(controller.data!, context);
                break;
              case MenuOptions.doPostRequest:
                _onDoPostRequest(controller.data!, context);
                break;
              case MenuOptions.loadLocalFile:
                // _onLoadLocalFileExample(controller.data!, context);
                break;
              case MenuOptions.loadFlutterAsset:
                _onLoadFlutterAssetExample(controller.data!, context);
                break;
              case MenuOptions.loadHtmlString:
                // _onLoadHtmlStringExample(controller.data!, context);
                break;
              case MenuOptions.transparentBackground:
                // _onTransparentBackground(controller.data!, context);
                break;
              case MenuOptions.setCookie:
                _onSetCookie(controller.data!, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.showUserAgent,
              enabled: controller.hasData,
              child: const Text('Show user agent'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCookies,
              child: Text('List cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.addToCache,
              child: Text('Add to cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCache,
              child: Text('List cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('Clear cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.navigationDelegate,
              child: Text('Navigation Delegate example'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.doPostRequest,
              child: Text('Post Request'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.loadHtmlString,
              child: Text('Load HTML string'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.loadLocalFile,
              child: Text('Load local file'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.loadFlutterAsset,
              child: Text('Load Flutter Asset'),
            ),
            const PopupMenuItem<MenuOptions>(
              key: ValueKey<String>('ShowTransparentBackgroundExample'),
              value: MenuOptions.transparentBackground,
              child: Text('Transparent background example'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.setCookie,
              child: Text('Set cookie'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onShowUserAgent(
      WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    await controller.runJavascript(
        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
  }

  Future<void> _onListCookies(
      WebViewController controller, BuildContext context) async {
    final String cookies =
    await controller.runJavascriptReturningResult('document.cookie');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  Future<void> _onAddToCache(
      WebViewController controller, BuildContext context) async {
    await controller.runJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  Future<void> _onListCache(
      WebViewController controller, BuildContext context) async {
    await controller.runJavascript('caches.keys()'
    // ignore: missing_whitespace_between_adjacent_strings
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  Future<void> _onClearCache(
      WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Cache cleared.'),
    ));
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _onSetCookie(
      WebViewController controller, BuildContext context) async {
    await cookieManager.setCookie(
      const WebViewCookie(
          name: 'foo', value: 'bar', domain: 'httpbin.org', path: '/anything'),
    );
    await controller.loadUrl('https://httpbin.org/anything');
  }

  Future<void> _onDoPostRequest(
      WebViewController controller, BuildContext context) async {
    final WebViewRequest request = WebViewRequest(
      uri: Uri.parse('https://httpbin.org/post'),
      method: WebViewRequestMethod.post,
      headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
    await controller.loadRequest(request);
  }

  // Future<void> _onLoadLocalFileExample(
  //     WebViewController controller, BuildContext context) async {
  //   final String pathToIndex = await _prepareLocalFile();
  //
  //   await controller.loadFile(pathToIndex);
  // }

  Future<void> _onLoadFlutterAssetExample(
      WebViewController controller, BuildContext context) async {
    await controller.loadFlutterAsset('assets/www/index.html');
  }
}


  Widget _getCookieList(String cookies) {
    if (cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
    cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }


class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : assert(_webViewControllerFuture != null),
        super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller!.reload();
              },
            ),
          ],
        );
      },
    );
  }
}
