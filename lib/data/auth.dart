import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:tata/data/notificationHandler.dart';

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
      final user = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
      print("response: $user");
      return user;
    } on AuthException catch (e) {
      print("Authentication Error: ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<Map?> getCurrentUser({String type = "user"}) async {
    final email = getCurrentUserEmail();
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
    return null;
  }

  static Future<Map?> saveUser(Map data, {String type = "users"}) async {
    try {
      return await supabase.from(type).insert(data).select("*").single();
    } catch (e) {
      print('error saving user: $e');
    }
    return null;
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

  static Future resetPassword() async {}
}
