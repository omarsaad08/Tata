import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

final dio = Dio();
final baseUrl = "";

class PeriodicFollowUpServices {
  static Future<Map> addPeriodicFollowUp(Map data) async {
    try {
      Response response = await dio.post('$baseUrl/baby/periodicFollowUp');
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

  static Future<Map> getHistoryOfPeriodicFollowUpForABaby() async {
    try {
      Response response = await dio.get('$baseUrl/baby/periodicFollowUp');
      if (response.statusCode != 200) {
        throw Exception(response.data);
      }
      return response.data;
    } catch (e) {
      throw Exception("error getting history of periodic follow up: $e");
    }
  }
}
