import 'package:tata/data/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class BabyServices {
  static final supabase = Supabase.instance.client;

  static String getDateRange(int dateRange) {
    switch (dateRange) {
      case 0:
      case 1:
      case 2:
        return "0-3";
      case 3:
      case 4:
      case 5:
        return "3-6";
      case 6:
      case 7:
      case 8:
        return "7-9";
      case 9:
      case 10:
      case 11:
      case 12:
        return "9-12";
      default:
        return "0-3";
    }
  }

  static Future<Map<String, dynamic>?> getLastFollowUp(Object id) async {
    try {
      final response = await supabase
          .from("follow_up")
          .select("*")
          .eq("baby_id", id)
          .order("follow_up_date", ascending: false)
          .limit(1)
          .maybeSingle();

      return response;
    } catch (e) {
      print("Error getting last follow-up: $e");
      return null;
    }
  }

  static int daysRemaining(String dateString) {
    // Parse the input date string
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime inputDate = format.parse(dateString);

    // Add two weeks (14 days) to the input date
    DateTime targetDate = inputDate.add(Duration(days: 14));
    print("target: $targetDate");
    // Get today's date without time
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);

    // Calculate the difference in days
    int remainingDays = targetDate.difference(today).inDays;

    // Ensure it doesn't return a negative number (if the date has passed)
    return remainingDays > 0 ? remainingDays : 0;
  }

  static Future<Map?> getNextAppointment() async {
    try {
      final babyId = (await Auth.getCurrentUser(type: "baby"))!['id'];
      final response = await supabase
          .from("appointments")
          .select("*")
          .eq("baby_id", babyId)
          .gte("date", DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .order("date", ascending: true)
          .order("time", ascending: true)
          .limit(1)
          .maybeSingle();
      print("appointment: $response");
      return response;
    } catch (e) {
      print("error fetching next appointment: $e");
      return null;
    }
  }
}
