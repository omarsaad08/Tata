import 'package:dio/dio.dart';
import 'package:tata/models/payment_method_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tata/models/visaResponseModel.dart';
import 'package:flutter/material.dart';

class BookingPaymentServices {
  static PaymentMethod? paymentMethod;
  static VisaResponseModel? visaResponseModel;
  static final accessToken =
      'd83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd';
  static final baseUrl = 'http://192.168.1.219:3000';
  static final dio = Dio(BaseOptions(headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  }));

  static Future<void> getPaymentMethod() async {
    dio.interceptors.add(PrettyDioLogger());
    final apiUrl = 'https://staging.fawaterk.com/api/v2/getPaymentmethods';
    try {
      Response response = await dio.get(apiUrl);
      paymentMethod = PaymentMethod.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> processPaymentMethod(
      int index, BuildContext context) async {
    try {
      final requestData = {
        'payment_method_id': 2,
        'cartTotal': '100',
        'currency': 'EGP',
        'customer': {
          'first_name': 'test',
          'last_name': 'test',
          'email': 'test@test.test',
          'phone': '01000000000',
          'address': 'test address',
        },
        'redirectionUrls': {
          'successUrl': '$baseUrl/payment/success',
          'failUrl': '$baseUrl/payment/fail',
          'pendingUrl': 'https://dev.fawaterk.com/pending',
        },
        'cartItems': [
          {
            'name': 'test',
            'price': '100',
            'quantity': '1',
          },
        ],
      };
      Response response = await dio.post(
          'https://staging.fawaterk.com/api/v2/invoiceInitPay',
          data: requestData);
      visaResponseModel = VisaResponseModel.fromJson(response.data);
      if (paymentMethod!.data![index].paymentId! == 2) {
        print('url: ${visaResponseModel!.data!.paymentData!.redirectTo!}');
        Navigator.pushNamed(context, 'paymentWebView',
            arguments: visaResponseModel!.data!.paymentData!.redirectTo!);
      }
    } catch (e) {
      print(e);
    }
  }
}
