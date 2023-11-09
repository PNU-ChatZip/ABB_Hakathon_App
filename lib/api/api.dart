import 'dart:convert';
import 'package:d_map/model/Record.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:d_map/widget/MyKakaoMap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/location.dart';

class Api {
  final String _baseUrl = dotenv.get("URL");

  Future<void> sendCurrentLocation(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      LatLng currentLocation = await getLocation();
      print("${currentLocation.latitude} ${currentLocation.longitude}");
      String userId = prefs.getString("id")!;
      // Creating the location object.
      var loc = location(
        currentLocation.latitude.toString(),
        currentLocation.longitude.toString(),
        type,
        DateTime.now().toIso8601String(),
        userId,
      );

      // Creating the URL.
      Uri url = Uri.parse('$_baseUrl/send-location');

      // Sending the HTTP request.
      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loc.toJson()),
      );

      // Handling the response.
      if (response.statusCode == 200) {
        print('Location sent successfully.');
        final List<String>? records = prefs.getStringList('records');
        if (records == null) {
          await prefs.setStringList('records', [loc.toString()]);
        } else {
          records.add(loc.toString());
          await prefs.setStringList('records', records);
        }
      } else {
        print('Failed to send location. Status Code: ${response.statusCode}');
        throw Exception(
            'Failed to send location. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to send location: $e');
      // Here you would handle the error, e.g., showing a snackbar if this is a Flutter app.
      // Since the context is not passed to this function, you cannot show a Snackbar directly here.
    }
  }

  Future<List<Record>> getRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? userId = prefs.getString("id");
      if (userId == null) throw Exception("fail to call userId");
      var url = Uri.parse("$_baseUrl/get-location-userId?userId=$userId");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        print('get records successfully.');
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        print(jsonData);

        List<Record> records =
            jsonData.map<Record>((json) => Record.fromJson(json)).toList();
        records.forEach((record) => print(record.toString()));
        return records;
      } else {
        print('Failed to get records. Status Code: ${response.statusCode}');
        throw Exception(
            'Failed to get records. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      print("[Fail] API Call miss with getRecords()");
    }

    return [];
  }

  Future<void> removeRecord(int id) async {
    var url = Uri.parse("$_baseUrl/delete-location?id=$id");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      print('remove record successfully.');
    } else {
      print('Failed to remove record. Status Code: ${response.statusCode}');
      throw Exception(
          'Failed to get record. Status Code: ${response.statusCode}');
    }
  }
}
