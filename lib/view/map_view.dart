import 'package:audioplayers/audioplayers.dart';
import 'package:d_map/api/api.dart';
import 'package:d_map/service/user_location.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: FutureBuilder(
              future: UserLocation().getUserLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  if (snapshot.data == null) {
                    return const Center(child: Text('No location data'));
                  }
                  return MyKakaoMap(
                    center: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ElevatedButton(
                    onPressed: _onOverlayStart,
                    child: const Text('Start'),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ElevatedButton(
                    onPressed: _onOverlayStop,
                    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.redAccent,
                          ),
                        ),
                    child: const Text('Stop'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onOverlayStart() async {
    bool hasPermission = await DashBubble.instance.hasOverlayPermission();
    if (hasPermission) {
      DashBubble.instance.startBubble(
        bubbleOptions: BubbleOptions(
          bubbleSize: 150,
          enableClose: false,
        ),
        onTap: _onTap,
      );
    } else {
      bool receivePermission = await DashBubble.instance.requestOverlayPermission();
      print(receivePermission);
    }
  }

  void _onOverlayStop() async {
    DashBubble.instance.stopBubble();
  }

  void _onTap() async {
    player.play(AssetSource('sounds/sound.mp3'));
    bool isSuccess = await Api.postReport();
    if (isSuccess) {
      print('Report success');
    } else {
      print('Report failed');
    }
  }
}

class MyKakaoMap extends StatefulWidget {
  const MyKakaoMap({
    super.key,
    required this.center,
  });

  final LatLng center;

  @override
  State<MyKakaoMap> createState() => _MyKakaoMapState();
}

class _MyKakaoMapState extends State<MyKakaoMap> {
  final _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KakaoMap(
      center: widget.center,
      markers: _markers,
    );
  }
}
