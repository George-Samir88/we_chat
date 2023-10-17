import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelper {
  final String _baseUrl = 'https://fcm.googleapis.com/fcm/send';
  final Dio _dio;
  final String bearerToken =
      'AAAAKHkD12k:APA91bEhKP53i36Q23kE2WgcsXJouoKRQMvCE4LUc8wip5_nirOwVk2gmJDy5aR2PVEzalXhKxZdj5Tk1RfBfSRvE2xwYQY6-JW_VtOYNexfyYlAwJn9X6qrn1to3CyhhLCDBBfPReYr';

  DioHelper(this._dio);

  Future<Map<String, dynamic>?> post(
      {required Map<String, dynamic> data}) async {
    try {
      var response = await _dio.post(
        '$_baseUrl',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );
      return response.data;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
