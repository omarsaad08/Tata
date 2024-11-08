import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final dio = Dio();
final baseUrl = "192.168.1.219";

class BabyServices {
  static Future<Map?> getBaby(String email) async {
    try {
      Response response = await dio.get('$baseUrl/baby');
      print('baby data: ${response.data}');
      return response.data;
    } catch (e) {
      throw Exception("error getting a baby: ${e}");
    }
  }

  static Future<void> setNewBaby(Map data) async {
    try {
      Response response =
          await dio.post('$baseUrl/baby', data: json.encode(data));
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error setting a new baby: ${e}");
    }
  }

  static Future<void> updateBaby(Map data) async {
    try {
      Response response =
          await dio.put('$baseUrl/baby', data: json.encode(data));
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error updating baby's data: ${e}");
    }
  }

  static Future<void> deleteBaby() async {
    try {
      Response response = await dio.delete('$baseUrl/baby');
      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception("error deleting baby's data: ${e}");
    }
  }
}
