import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

class BookingServices {
  static Map<String, dynamic>? bookingData;
  static final supabase = Supabase.instance.client;
  static Future<void> postDoctorAvailability(List data) async {
    try {
      for (var day in data) {
        await supabase.from("doctor_availability").insert(day);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Map?> getNextAppointment(String type) async {
    final user = await Auth.getCurrentUser(type: type);
    try {
      final booking = await supabase
          .from("appointments")
          .select("*")
          .eq("${type}_id", user!['id'])
          .gte("appointment_date", DateTime.now().toIso8601String())
          .order('appointment_date', ascending: true)
          .limit(1)
          .maybeSingle();
      return booking;
    } catch (e) {
      print("error fetching next appointment: $e");
      return null;
    }
  }

  static Future<int?> updateAppointment(int appointmentId, Map data) async {
    return null;
  
    // to be made
  }

  static Future<List?> getRequestedAppointments() async {
    return null;
  
    // to be made
  }

  static Future<List?> fetchPreviousBookingsForBaby() async {
    return null;
  }

  static Future<Map?> bookADoctor(Map<String, dynamic> data) async {
    try {
      data.addAll({"roomid": generateRandomString(20)});
      final booking =
          await supabase.from("appointments").insert(data).select("*").single();
      return booking;
    } catch (e) {
      print("could not book this session: $e");
      return null;
    }
  }

  static Future<void> cancelAppointment(Map data) async {}
}
