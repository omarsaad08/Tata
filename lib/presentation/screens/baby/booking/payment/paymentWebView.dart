import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:iconsax/iconsax.dart';

class PaymentWebView extends StatefulWidget {
  String url;
  PaymentWebView({super.key, required this.url});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  InAppWebViewController? _webViewController;
  bool result = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Icon(Iconsax.close_circle5),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'paymentResult',
                arguments: result);
            // Navigator.pop(context);
          },
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.url), // Replace with your desired URL
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          print('Started loading: $url');
          if (url != null) {
            final urlString = url.toString();
            if (urlString.contains('success')) {
              result = true;
              Navigator.pushReplacementNamed(context, 'paymentResult',
                  arguments: 1);
            } else if (urlString.contains('fail')) {
              Navigator.pushReplacementNamed(context, 'paymentResult',
                  arguments: 0);
              // Optionally, navigate to a failure screen or take another action
            }
          }
        },
        onLoadStop: (controller, url) {
          print('Finished loading: $url');
          if (url != null) {
            final urlString = url.toString();
            if (urlString.contains('success')) {
              print('payment success');
              result = true;
              Navigator.pushReplacementNamed(context, 'paymentResult',
                  arguments: 1);
            } else if (urlString.contains('fail')) {
              print('payment fail');
              Navigator.pushReplacementNamed(context, 'paymentResult',
                  arguments: 0);
              // Optionally, navigate to a failure screen or take another action
            }
          }
        },
        onProgressChanged: (controller, progress) {
          print('Loading progress: $progress%');
        },
      ),
    );
  }
}
