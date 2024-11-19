import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tata/data/storage.dart';

final dio = Dio();
final baseUrl = "http://192.168.1.219:3000";

class PeriodicFollowUpServices {
  static Future<Map> addPeriodicFollowUp(Map data) async {
    try {
      Response response = await dio.post('$baseUrl/follow_up', data: data);
      if (response.statusCode != 200) {
        throw Exception(response.data);
      }
      return response.data;
    } catch (e) {
      throw Exception("erorr adding periodic follow up: $e");
    }
  }

  static Future<Map> getPeriodicFollowUp() async {
    try {
      Response response = await dio.get('$baseUrl/baby/periodicFollowUp');
      if (response.statusCode != 200) {
        throw Exception(response.data);
      }
      return response.data;
    } catch (e) {
      throw Exception("error getting periodicFollowUp: $e");
    }
  }

  static Future<List?> getAllFollowUps() async {
    try {
      final id = await Storage.get('id');
      Response response = await dio.get('$baseUrl/follow_up/$id');
      if (response.statusCode != 200) {
        throw Exception(response.data);
      }
      return response.data;
    } catch (e) {
      throw Exception("error getting history of periodic follow up: $e");
    }
  }
}
