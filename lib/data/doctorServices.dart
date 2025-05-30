import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tata/data/auth.dart';

class DoctorServices {
  static final supabase = Supabase.instance.client;
  static Future<List> getTodaysAppointments() async {
    try {
      final doctorId = (await Auth.getCurrentUser(type: "doctor"))!['id'];
      final data = await supabase
          .from("appointments")
          .select("*")
          .eq("date", DateTime.now().toIso8601String().split('T')[0])
          .neq("status", "requested");
      return data;
    } catch (e) {
      print("error getting today's appointments: $e");
      rethrow;
    }
  }

  static Future<List> getAllDoctors() async {
    try {
      final doctors = await supabase
          .from("doctor")
          .select("*, users(name)")
          .eq("users.role", "doctor");

      return doctors;
    } catch (e) {
      print("error getting all doctors: $e");
      rethrow;
    }
  }

  static Future<Map?> getNextAppointment() async {
    try {
      final doctorId = (await Auth.getCurrentUser(type: "doctor"))!['id'];
      final response = await supabase
          .from("appointments")
          .select("*")
          .eq("doctor_id", doctorId)
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
