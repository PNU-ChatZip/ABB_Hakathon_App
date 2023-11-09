import 'package:d_map/api/api.dart';
import 'package:d_map/model/RawRecord.dart';
import 'package:d_map/util/myGeolocator.dart';
import 'package:d_map/util/style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Record.dart';

class MyKakaoMap extends StatefulWidget {
  const MyKakaoMap({super.key});

  @override
  State<MyKakaoMap> createState() => _MyKakaoMapState();
}

class _MyKakaoMapState extends State<MyKakaoMap> {
  late KakaoMapController mapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final LatLng? userLocation = snapshot.data;
          return KakaoMap(
            onMapCreated: ((controller) async {
              mapController = controller;
              List<RawRecord> records = await Api().getRawRecords();
              for (int i = 0; i < records.length; i++) {
                markers.add(
                  Marker(
                    markerId: UniqueKey().toString(),
                    latLng: LatLng(
                      double.parse(records[i].latitude),
                      double.parse(records[i].longitude),
                    ),
                  ),
                );
              }

              setState(() {});
            }),
            markers: markers.toList(),
            center: userLocation,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorStyles.mainColor,
            ),
          );
        }
      },
    );
  }
}

Future<LatLng> getLocation() async {
  Position position = await determinePosition();
  return LatLng(position.latitude, position.longitude);
}
