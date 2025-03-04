import 'package:flutter/material.dart';
import 'package:tata/data/bookingServices.dart';
import 'package:tata/presentation/components/theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Payment extends StatefulWidget {
  final url;
  final data;
  const Payment({super.key, required this.url, required this.data});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  InAppWebViewController? _webViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startPayment();
  }

  void startPayment() {
    _webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(widget.url)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("الدفع", style: TextStyle(color: clr(0))),
          centerTitle: true,
          backgroundColor: clr(1)),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
        )),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          startPayment();
        },
        onLoadStop: (controller, url) async {
          if (url != null &&
              url.queryParameters.containsKey("success") &&
              url.queryParameters["success"] == 'true') {
            print("payment success");
          } else if (url != null &&
              url.queryParameters.containsKey("success") &&
              url.queryParameters["success"] == 'false') {
            print("payment failed");
          }

          Map? bookingResponse;
          bookingResponse = await BookingServices.bookADoctor(widget.data);
          Navigator.pushReplacementNamed(context, "bookingFinal",
              arguments: bookingResponse);
        },
      ),
    );
  }
}
