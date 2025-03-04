import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:tata/data/auth.dart';

final dio = Dio();
final baseUrl = "http://192.168.1.219:3000";

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

class BookingServices {
  static Map<String, dynamic>? bookingData;
  // testing
  static Future<Map<String, dynamic>> fetchDoctorAvailability(
      int doctorId) async {
    final response = await dio.get('$baseUrl/doctorAvailability/week/1');

    if (response.statusCode == 200) {
      // print('data: ${response.data}');
      return response.data;
    } else {
      throw Exception('Failed to load availability');
    }
  }

  static Future<void> postDoctorAvailability(List data) async {
    final response = await dio.post('$baseUrl/doctorAvailability', data: data);

    if (response.statusCode == 200) {
      print('data: ${response.data}');
      return response.data;
    } else {
      throw Exception('Failed to post availability');
    }
  }

  static Future<Map?> getNextAppointmentForBaby() async {
    try {
      
    } catch (e) {
      throw Exception('error getting next appointment: ${e}');
    }
  }

  static Future<Map?> getNextAppointmentForDoctor() async {
    try {
    } catch (e) {
      throw Exception('error getting next appointment: ${e}');
    }
  }

  static Future<Map?> getDoctorAvailability(int doctorId) async {
    try {
      final response =
          await dio.get('$baseUrl/doctorAvailability/week/${doctorId}');
      if (response.statusCode == 200) {
        // print('data: ${response.data}');
        final data = response.data['availability'];
        final booked = response.data['bookedAppointments'];
        return response.data;
      } else {
        throw Exception('Failed to load availability');
      }
    } catch (error) {
      return null;
    }
  }

  static Future<int?> updateAppointment(int appointment_id, Map data) async {
    try {
      Response response =
          await dio.patch('$baseUrl/appointments/$appointment_id', data: data);
      if (response.statusCode == 200) {
        return 1;
      }
      throw Exception('failed to update appointment: ${response.data}');
    } catch (e) {
      rethrow;
    }
  }

  static Future<List?> getRequestedAppointments() async {
    try {
      final id = (await Auth.getCurrentUser(type: "doctor"))!['id'];
      Response response = await dio.get('$baseUrl/appointments/requested/$id');
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception('failed to get requested appointments: ${response.data}');
    } catch (e) {
      rethrow;
    }
  }

  static Future<List?> fetchPreviousBookingsForBaby() async {
    try {

    } catch (e) {
      rethrow;
    }
  }

  static Future<Map> bookADoctor(Map<String, dynamic> data) async {
    try {
      data.addAll({"roomid": generateRandomString(20)});

      Response response = await dio.post('$baseUrl/appointments', data: data);
      if (response.statusCode != 200) throw Exception(response.data);
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
