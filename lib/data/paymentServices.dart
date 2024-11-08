import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const String paymobApiKey =
    "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RrNU1UWXhMQ0p1WVcxbElqb2lNVGN6TURFNU16RTJOeTQwTWpJek1UWWlmUS5XdC1RdHMzT1QtU1ZRalFaWTlrZVZ6SXdHSGJxVlRYOThRVXhyRVo4Z0YyNkxJN2xmNDVTRVllelhhU3Y4WlRSVV93TlpXS2lQR0xoampUZ2d3NGJrdw==";
const String paymobAuthURL = "https://accept.paymob.com/api/auth/tokens";
const String paymobOrderURL = "https://accept.paymob.com/api/ecommerce/orders";
const String paymobPaymentKeyURL =
    "https://accept.paymob.com/api/acceptance/payment_keys";
final baseUrl = '';
final dio = Dio();

class PaymentServices {
  /*
  static Future<String?> getAuthToken() async {
    try {
      final response = await http.post(
        Uri.parse("https://accept.paymob.com/api/auth/tokens"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "api_key": paymobApiKey, // Replace with your actual Paymob API key
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data["token"];
      } else {
        print("Failed to get auth token. Status Code: ${response.statusCode}");
        throw Exception(
            "Failed with status code: ${response.statusCode} - ${response.body}");
      }
    } on http.ClientException catch (e) {
      print("Client Exception: $e");
      throw Exception("ClientException occurred: $e");
    } on FormatException catch (e) {
      print("Format Exception: $e");
      throw Exception("FormatException occurred: Invalid JSON format - $e");
    } catch (e) {
      print("Unhandled Exception: $e");
      throw Exception("Unexpected error: $e");
    }
  }

  static Future<String?> createOrder(String authToken, int amount) async {
    final String uniqueOrderId =
        "order_${DateTime.now().millisecondsSinceEpoch}";
    final response = await http.post(
      Uri.parse(
          'https://accept.paymob.com/api/ecommerce/orders'), // Use your actual endpoint here
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Set content type to JSON
      },
      body: jsonEncode({
        'amount': amount,
        'currency': 'EGP',
        'merchant_id': "999161",
        "merchant_order_id": uniqueOrderId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('order id: ${data['id']}');
      return data['id']; // Adjust based on your API response structure
    } else {
      print("Failed to create order: ${response.body}");
      return null;
    }
  }

  static Future<String?> getPaymentKey(
      String authToken, String orderId, int amountCents) async {
    final response = await http.post(Uri.parse(paymobPaymentKeyURL), body: {
      "auth_token": authToken,
      "amount_cents": amountCents.toString(),
      "currency": "EGP",
      "order_id": orderId,
      "integration_id": "4849579", // Replace with your actual integration ID
      "billing_data": {
        "apartment": "NA",
        "email": "test@example.com",
        "floor": "NA",
        "first_name": "Test",
        "street": "Test",
        "building": "NA",
        "phone_number": "+201234567890",
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "Cairo",
        "country": "EGY",
        "last_name": "User",
        "state": "NA"
      }
    });

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data["token"];
    }
    return null;
  }
  */
  static Future<String> payWithPaymob(int amount) async {
    try {
      String token = await getToken();
      int orderId =
          await getOrderId(token: token, amount: (amount * 100).toString());
      String paymentKey = await getPaymentKey(
          token: token,
          orderId: orderId.toString(),
          amount: (amount * 100).toString());
      return paymentKey;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getToken() async {
    try {
      Response response =
          await dio.post(paymobAuthURL, data: {'api_key': paymobApiKey});
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> getOrderId(
      {required String token, required String amount}) async {
    try {
      Response response = await dio.post(paymobOrderURL, data: {
        'auth_token': token,
        'delivery_needed': false,
        'amount_cents': amount,
        'currency': "EGP",
        "items": [],
      });
      print('id: ${response.data}');
      return response.data['id'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getPaymentKey(
      {required String token,
      required String orderId,
      required String amount}) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final data = {
        "auth_token": token,
        "amount_cents": amount,
        "currency": "EGP",
        "order_id": orderId,
        "integration_id": "4849579", // Replace with your actual integration ID
        "billing_data": {
          "apartment": "NA",
          "email": "test@example.com",
          "floor": "NA",
          "first_name": "Test",
          "street": "Test",
          "building": "NA",
          "phone_number": "+201234567890",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "Cairo",
          "country": "EGY",
          "last_name": "User",
          "state": "NA",
        },
      };
      print(data);
      Response response = await dio.post(paymobPaymentKeyURL, data: data);
      return response.data['token'];
    } catch (e) {
      print("payment key error: $e");
      rethrow;
    }
  }
}
