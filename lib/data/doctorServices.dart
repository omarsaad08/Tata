import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

final dio = Dio();
final baseUrl = "";

class DoctorServices {
  static Future<List> getAllDoctors() async {
    try {
      Response response = await dio.get('$baseUrl/doctor');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception('error fetching docs: $e');
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
