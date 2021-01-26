import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  String url;
  HomePage({this.url});
  @override
  _WebViewWebPageState createState() => _WebViewWebPageState();
}

class _WebViewWebPageState extends State<HomePage> {
  bool sidebar = false;

  Future<bool> _onBack() async {
    bool goBack;
    var value = await webView.canGoBack();
    if (value) {
      webView.goBack();
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Confirmation ',
              style: TextStyle(color: Colors.orangeAccent)),
          // Are you sure?
          content: new Text('Do you want exit app ? '),
          // Do you want to go back?
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  goBack = true;
                });
              },
              child: new Text('Yes'), // Yes
            ),
          ],
        ),
      );
      if (goBack) Navigator.pop(context); // If user press Yes pop the page
      return goBack;
    }
  }

  Future<void> _refresh() async {
    webView.reload();
  }

  double progress = 0;
  InAppWebViewController webView;

  @override
  void initState() {
    print(widget.url);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.refresh),
        //     onPressed: (){
        //   _refresh();
        // }),
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          // title: Center(child: Text("FlashTrade",style: TextStyle(color: Colors.black ,fontStyle: FontStyle.italic),)),
        ),
        body: Container(
            child: Column(
                children: <Widget>[
          (progress != 1.0)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent)),
                    // Container(
                    //        height: _height / 1.1365,
                    //        width: _width,
                    //        child:
                    //            Center(child: Image.asset('assets/splash.png')))
                  ],
                )
              : null, //
          // Should be removed while showing
          Expanded(
            child: Container(
              child: InAppWebView(
                initialUrl: "https://${widget.url}",
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                    debuggingEnabled: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {},
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    sidebar = true;
                  });
                },
                onReceivedServerTrustAuthRequest:
                    (InAppWebViewController controller,
                        ServerTrustChallenge challenge) async {
                  return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED);
                },
                androidOnPermissionRequest: (InAppWebViewController controller,
                    String origin, List<String> resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          )
        ].where((Object o) => o != null).toList())),
      ),
    ); //Remove null widgets
  }
}
