import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dio = Dio();
final baseUrl = "http://192.168.1.219:3000";

class DoctorServices {
  static final supabase = Supabase.instance.client;
  static Future<List> getAllDoctors() async {
    try {
      final doctors = await supabase
          .from("doctor")
          .select("*, users(name)")
          .eq("users.role", "doctor");

      print("data: $doctors");
      return doctors;
    } catch (e) {
      print("error getting all doctors: $e");
      rethrow;
    }
  }

  static Future<Map> getDoctor() async {
    try {
      Response response = await dio.get('$baseUrl/doctor');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception("error getting a doctor: $e");
    }
  }

  static Future<void> addDoctor(Map data) async {
    try {
      Response response =
          await dio.post('$baseUrl/doctor', data: json.encode(data));
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error adding a doctor to the system: $e");
    }
  }

  static Future<void> updateDoctor(Map data) async {
    try {
      Response response = await dio.put('$baseUrl/doctor');
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error updating doctor's data: ${e}");
    }
  }

  static Future<void> deleteDoctor() async {
    try {
      Response response = await dio.delete('$baseUrl/doctor');
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error deleting doctor: ${e}");
    }
  }
}
