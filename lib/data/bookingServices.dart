import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:tata/data/storage.dart';

final dio = Dio();
final baseUrl = "http://192.168.1.11:3000";

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
    final id = await Storage.get('id');
    try {
      Response response = await dio.get('$baseUrl/appointments/next/$id');
      if (response.statusCode != 200) {
        throw Exception('failed: ');
      }
      print('${response.data}');
      Response doctorResponse =
          await dio.get('$baseUrl/doctor/${response.data['doctor_id']}');
      if (doctorResponse.statusCode != 200) {
        throw Exception('failed: ');
      }
      final data = Map.from(response.data);
      data.addAll(doctorResponse.data);
      print('data: $data');
      return data;
    } catch (e) {
      throw Exception('error getting next appointment: ${e}');
    }
  }

  static Future<Map?> getDoctorAvailability(int doctorId) async {
    try {
      final response =
          await dio.get('$baseUrl/doctorAvailability/week/${doctorId}');
      if (response.statusCode == 200) {
        print('data: ${response.data}');
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

  // -------
  static Future<Map> bookADoctor(Map data) async {
    try {
      Response response = await dio.post('$baseUrl/appointments', data: data);
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
