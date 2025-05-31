import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';

class PeriodicFollowUpServices {
  static final supabase = Supabase.instance.client;
  static Future<Map?> addPeriodicFollowUp(Map data) async {
    try {
      return await supabase
          .from("follow_up")
          .insert(data)
          .select("healthy")
          .single();
    } catch (e) {
      throw Exception("erorr adding periodic follow up: $e");
    }
  }

  static Future<List?> getAllFollowUps() async {
    try {
      final id = (await Auth.getCurrentUser(type: "baby"))!["id"];
      final data =
          await supabase.from("follow_up").select("*").eq("baby_id", id);
      return data;
    } catch (e) {
      print("error getting follow ups: $e");
    }
    return null;
  }

  static Future<void> deleteFollowUp(int followUpId) async {
    try {
      await supabase.from("follow_up").delete().eq("id", followUpId);
    } catch (e) {
      throw Exception("error deleting follow up: $e");
    }
  }
}
