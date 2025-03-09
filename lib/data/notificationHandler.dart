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
  static String? _cachedToken;
  static int? _tokenExpiryTime;

  /// Save FCM Token to Supabase
  static Future<void> saveDoctorToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      final id = (await Auth.getCurrentUser())?['id'];

      if (token != null && id != null) {
        await Supabase.instance.client
            .from('users')
            .update({'notification_token': token}).eq('id', id);
        print("✅ FCM Token saved to database.");
      }
    } catch (e) {
      print("❌ Error saving FCM token: $e");
    }
  }

  /// Listen for new appointments and send notifications
  static void listenForNewAppointments() {
    final supabase = Supabase.instance.client;
    supabase
        .from('appointments')
        .stream(primaryKey: ['id'])
        .eq('status', 'requested')
        .listen((data) async {
          if (data.isNotEmpty) {
            for (var appointment in data) {
              String appointmentDate = appointment['date']; // تاريخ الموعد
              String appointmentTime = appointment['time']; // وقت الموعد

              String message =
                  "لديك طلب موعد جديد بتاريخ $appointmentDate في تمام الساعة $appointmentTime.";

              sendPushNotification("طلب موعد جديد", message);
            }
          }
        });
  }

  /// Get FCM Access Token
  static Future<String> _getAccessToken() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (_cachedToken != null &&
        _tokenExpiryTime != null &&
        currentTime < _tokenExpiryTime!) {
      print("🔄 Using cached access token.");
      return _cachedToken!;
    }

    print("🚀 Generating a new access token...");

    try {
      // Load service account JSON
      final jsonString =
          await rootBundle.loadString('assets/service-account.json');
      final serviceAccount = jsonDecode(jsonString);
      final clientEmail = serviceAccount['client_email'];
      final privateKey = (serviceAccount['private_key'] as String)
          .replaceAll(r'\n', '\n')
          .trim(); // Ensure correct format

      final tokenUrl = "https://oauth2.googleapis.com/token";

      // Create JWT claims
      final iat = currentTime;
      final exp = iat + 3600; // Token valid for 1 hour

      final claims = {
        "iss": clientEmail,
        "sub": clientEmail,
        "scope": "https://www.googleapis.com/auth/firebase.messaging",
        "aud": tokenUrl,
        "exp": exp,
        "iat": iat
      };

      // Sign JWT with private key
      final builder = JsonWebSignatureBuilder()
        ..jsonContent = claims
        ..addRecipient(
          JsonWebKey.fromPem(privateKey),
          algorithm: "RS256",
        );

      final jwt = builder.build().toCompactSerialization();

      // Request Access Token
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
        _cachedToken = jsonResponse['access_token'];
        _tokenExpiryTime = exp;
        print("✅ Access Token Received.");
        return _cachedToken!;
      } else {
        print("❌ Failed to get access token: ${response.body}");
        throw Exception("Failed to get access token: ${response.body}");
      }
    } catch (e) {
      print("❌ Error generating access token: $e");
      rethrow;
    }
  }

  /// Send Push Notification
  static Future<void> sendPushNotification(String title, String body) async {
    try {
      final id = (await Auth.getCurrentUser())?['id'];
      if (id == null) {
        print("⚠️ User ID not found, cannot send notification.");
        return;
      }

      // Get FCM Token from database
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

      // Get Access Token
      String accessToken = await _getAccessToken();

      // Send Notification
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
            "notification": {
              "title": title,
              "body": body,
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
            },
          }
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Push notification sent successfully!");
      } else {
        print("❌ Failed to send notification: ${response.body}");
      }
    } catch (e) {
      print("❌ Error sending push notification: $e");
    }
  }
}
