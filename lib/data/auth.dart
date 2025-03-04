import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  static final supabase = Supabase.instance.client;

  static Future<Object?> signUp(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      final result = await signIn(email, password);
      return result;
    } catch (e) {
      print('error signin up: $e');
      return e;
    }
  }

  static Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final user = await supabase.auth
          .signInWithPassword(email: email, password: password);
      return user;
    } catch (e) {
      print("error signing in: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<Map?> getCurrentUser({String type = "user"}) async {
    final email = await getCurrentUserEmail();
    if (email == null) return null;
    try {
      if (type == "user") {
        return await supabase
            .from("users")
            .select("*")
            .eq("email", email)
            .single();
      } else {
        final userId = (await getCurrentUser())!['id'];
        return await supabase
            .from(type)
            .select("*")
            .eq("user_id", userId)
            .single();
      }
    } catch (e) {
      print("error getting user: $e");
    }
  }

  static Future<Map?> saveUser(Map data, {String type = "users"}) async {
    try {
      return await supabase.from(type).insert(data).select("*").single();
    } catch (e) {
      print('error saving user: $e');
    }
  }

  static String? getCurrentUserEmail() {
    return supabase.auth.currentUser?.email;
  }

  static Future resetPassword() async {}
}
