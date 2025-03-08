import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';
import 'package:crypto/crypto.dart';
import 'package:jose/jose.dart';

class NotificationHandler {
  static Future<void> saveDoctorToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    final id = (await Auth.getCurrentUser())!['id'];
    if (token != null) {
      await Supabase.instance.client
          .from('users')
          .update({'notification_token': token}).eq('id', id);
    }
  }

  static void listenForNewAppointments() {
    final supabase = Supabase.instance.client;
    supabase
        .from('appointments')
        .stream(primaryKey: ['id'])
        .eq('status', 'requested')
        .listen((data) {
          if (data.isNotEmpty) {
            sendPushNotification("New Appointment Request",
                "You have a new pending appointment!");
          }
        });
  }

  static Future<String> _getAccessToken() async {
    final jsonString =
        await rootBundle.loadString('assets/service-account.json');
    final serviceAccount = jsonDecode(jsonString);

    final clientEmail = serviceAccount['client_email'];
    final privateKey = serviceAccount['private_key'];
    final tokenUrl = "https://oauth2.googleapis.com/token";

    final iat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = iat + 3600; // Token expires in 1 hour

    final claims = {
      "iss": clientEmail,
      "scope": "https://www.googleapis.com/auth/firebase.messaging",
      "aud": tokenUrl,
      "exp": exp,
      "iat": iat
    };

    final builder = JsonWebSignatureBuilder()
      ..jsonContent = claims
      ..addRecipient(
        JsonWebKey.fromPem(privateKey),
        algorithm: "RS256",
      );

    final jwt = builder.build().toCompactSerialization();

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': jwt,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['access_token'];
    } else {
      throw Exception("❌ Failed to get access token: ${response.body}");
    }
  }

  static Future<void> sendPushNotification(String title, String body) async {
    final id = (await Auth.getCurrentUser())!['id'];
    String? token = await Supabase.instance.client
        .from('users')
        .select('notification_token')
        .eq('id', id)
        .single()
        .then((value) => value['notification_token']);

    if (token == null) {
      print("⚠️ No FCM token found for user.");
      return;
    }

    String accessToken = await _getAccessToken();

    var response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/tata-47a2e/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "message": {
          "token": token,
          "data": {
            "title": title,
            "body": body,
            "click_action":
                "FLUTTER_NOTIFICATION_CLICK", // Opens the app when clicked
          },
        }
      }),
    );

    if (response.statusCode == 200) {
      print("✅ Push notification sent successfully!");
    } else {
      print("❌ Failed to send notification: ${response.body}");
    }
  }
}
