import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:tata/data/notificationHandler.dart';

class Auth {
  static final supabase = Supabase.instance.client;

  static Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      print('error signing up: $e');
      return null;
    }
  }

  static Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      print("Authentication Error: ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
      throw Exception("Failed to sign out");
    }
  }

  static Future<Map?> getCurrentUser({String type = "user"}) async {
    try {
      final email = getCurrentUserEmail();
      if (email == null) return null;

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
      return null;
    }
  }

  static Future<Map?> saveUser(Map data, {String type = "users"}) async {
    try {
      return await supabase.from(type).insert(data).select("*").single();
    } catch (e) {
      print('error saving user: $e');
      return null;
    }
  }

  static String? getCurrentUserEmail() {
    return supabase.auth.currentUser?.email;
  }

  static Future<bool> doesUserExist(String email,
      {String type = "users"}) async {
    try {
      // Step 1: Find the user by email in the `users` table
      final userResult = await supabase
          .from('users')
          .select('*')
          .eq('email', email)
          .maybeSingle();

      if (userResult == null) return false;

      // Step 2: If checking for "users" type, return true since user exists
      if (type == "users") return true;

      // Step 3: Check if the user has a related entry in either "doctors" or "babies"
      final userId = userResult['id'];
      final subUser = await supabase
          .from(type)
          .select('*')
          .eq('user_id', userId)
          .maybeSingle();

      return subUser != null;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: '${Uri.base.origin}/reset-password',
      );
      return true;
    } catch (e) {
      print('Error resetting password: $e');
      return false;
    }
  }

  static Future<bool> resendVerificationEmail(String email) async {
    try {
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      return true;
    } catch (e) {
      print('Error resending verification email: $e');
      return false;
    }
  }
}
