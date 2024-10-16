import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final dio = Dio();
final baseUrl = "http://192.168.103.224:3000";

class BookingServices {
  // testing
  static Future<Map<String, dynamic>> fetchDoctorAvailability(
      int doctorId) async {
    final response = await dio.get('$baseUrl/doctorAvailability/week/1');

    if (response.statusCode == 200) {
      print('data: ${response.data}');
      return response.data;
    } else {
      throw Exception('Failed to load availability');
    }
  }

  // -------
  static Future<Map> bookADoctor(Map data) async {
    try {
      Response response =
          await dio.post('http://192.168.103.224:3000/appointments');
      if (response.statusCode != 200) throw Exception(response.data);
      print('data: ${response.data}');
      return response.data;
    } catch (e) {
      throw Exception("error bookinga  doctor's appointment: $e");
    }
  }

  // to get any doctor's free time in a specific hospital
  static Future<Object> getFreeTimeThisWeek() async {
    try {
      Response response = await dio.get('$baseUrl/booking/freeThisWeek');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception("error getting free time for booking this week: $e");
    }
  }

  static Future<void> cancelAppointment(Map data) async {
    try {
      Response response =
          await dio.delete('$baseUrl/booking', data: json.encode(data));
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error cancelling appointment: ${e}");
    }
  }

  // it should be also a space for the doctor to add a record for the baby's case
  static Future<void> updateBooking(Map data) async {
    try {
      Response response =
          await dio.put('$baseUrl/booking', data: json.encode(data));
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error updating an appointment: $e");
    }
  }

  static Future<List> getHistoryOfBookingForABaby() async {
    try {
      Response response = await dio.get('$baseUrl/booking/baby');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception("error getting histoy of booking for a baby");
    }
  }

  static Future<List> getHistoryOfBookingForADoctor() async {
    try {
      Response response = await dio.get('$baseUrl/booking/doctor');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception("error getting hisoty of booking for a doctor: $e");
    }
  }

  static Future<List> getTodaysBookingsForHospital() async {
    try {
      Response response = await dio.get('$baseUrl/booking/hospital');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception("error getting todays' bookings for a hospital: $e");
    }
  }

  static Future<List> getTodaysBookingsForDoctor() async {
    try {
      Response response = await dio.get('$baseUrl/booking/doctor');
      if (response.statusCode != 200) throw Exception(response.data);
      return response.data;
    } catch (e) {
      throw Exception("error getting today's bookings for a doctor: $e");
    }
  }
}
