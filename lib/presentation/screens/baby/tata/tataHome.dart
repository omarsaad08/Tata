import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TataHome extends StatefulWidget {
  const TataHome({super.key});

  @override
  State<TataHome> createState() => _TataHomeState();
}

class _TataHomeState extends State<TataHome> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'https://tataegypt.netlify.app/services'), // Replace with your desired URL
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          print('Started loading: $url');
        },
        onLoadStop: (controller, url) {
          print('Finished loading: $url');
        },
        onProgressChanged: (controller, progress) {
          print('Loading progress: $progress%');
        },
      ),
    );
  }
}
