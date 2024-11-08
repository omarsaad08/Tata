import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tata/data/storage.dart';
import 'package:dio/dio.dart';

final auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/calendar', // Full access to user's calendar
    'https://www.googleapis.com/auth/calendar.events', // Access to create and modify events
  ],
);
final dio = Dio();
final baseUrl = 'http://192.168.1.219:3000';

class Auth {
  static Future<int?> signupWithEmail(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('logged in successfuly: ${credential}');
      return 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 1;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 2;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<User?> signinWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return userCredential.user;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  static Future<int?> saveUser(Map data, String type) async {
    try {
      Response response = await dio.post('$baseUrl/$type', data: data);
      if (response.statusCode != 200) {
        throw Exception('error');
      }
      print('data: ${response.data}');
      await Storage.saveIdAndType(response.data['id'].toString(), type);
      return 0;
    } catch (e) {
      print('e: $e');
    }
  }

  static Future<Map?> getUser(String id, String type) async {
    try {
      Response response = await dio.get('$baseUrl/$type/$id');
      if (response.statusCode != 200) {
        throw Exception('error');
      }
      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map?> getUserWithEmail(String email, String type) async {
    try {
      Response response = await dio.get('$baseUrl/$type/email/$email');
      if (response.statusCode != 200) {
        throw Exception("error");
      }
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
