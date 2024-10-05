import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HospitalServices {
  final dio = Dio();
  final baseUrl = "";
  Future<void> setupHospital() async {
    try {
      Response response = await dio.post('$baseUrl/hospital');
      if (response.statusCode != 200)
        throw Exception("error setting up the hospital");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> getHospital() async {
    try {
      Response response = await dio.get('$baseUrl/hospital');
      print('hospital data: ${response.data}');
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> updateHospital() async {
    try {
      Response response = await dio.put('$baseUrl/hospital');
      print('hospital data: ${response.data}');
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteHospital() async {
    try {
      Response response = await dio.delete('$baseUrl/hospital');
      if (response.statusCode == 200) print("hospital deleted successfuly");
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<List> getDoctors() async {}
  Future<void> addDoctor() async {}
  Future<void> removeDoctor() async {}
}
