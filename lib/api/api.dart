import 'dart:convert';
import 'package:d_map/model/coordinate.dart';
import 'package:d_map/service/storage.dart';
import 'package:d_map/service/user_location.dart';
import 'package:http/http.dart' as http;

import 'package:d_map/model/report.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String baseUrl = dotenv.get('API_BASE_URL');

  static Future<List<Report>> getReports() async {
    try {
      String? userId = await Storage.getString('name');
      if (userId == null) {
        throw Exception('Failed to load userId from storage');
      }
      final response = await http.get(Uri.parse('$baseUrl/get-location-userId?userId=$userId'));
      print(response);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((e) => Report.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load reports status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> postReport() async {
    try {
      String? userId = await Storage.getString('name');
      if (userId == null) {
        throw Exception('Failed to load userId from storage');
      }
      Coordinate? coordinate = await UserLocation().getUserLocation();
      if (coordinate == null) {
        throw Exception('Failed to load user location');
      }
      final response = await http.post(
        Uri.parse('$baseUrl/send-location'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'latitude': coordinate.latitude.toString(),
          'longitude': coordinate.longitude.toString(),
          'type': '포트홀',
          'time': '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to post report status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> deleteReport(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/delete-location?id=$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete report status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
