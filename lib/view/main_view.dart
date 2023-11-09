import 'package:d_map/api/api.dart';
import 'package:d_map/util/style.dart';
import 'package:d_map/widget/MyKakaoMap.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';

import '../service/notification.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final NotificationManager notificationManager = NotificationManager();
  @override
  void initState() {
    super.initState();
    notificationManager.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 30,
              ),
              const Center(
                child: Text(
                  "Overlay",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: () async {
                  if (await DashBubble.instance.hasOverlayPermission()) {
                    DashBubble.instance.startBubble(
                      bubbleOptions: BubbleOptions(
                        bubbleIcon: "porthole",
                        bubbleSize: 200,
                        distanceToClose: 100,
                        enableClose: false,
                        startLocationX: 200,
                        startLocationY: 450,
                      ),
                      onTap: () {
                        print("click bubble");
                        Api().sendCurrentLocation("포트홀");
                        notificationManager.showNotification();
                      },
                      notificationOptions: NotificationOptions(
                        title: "D-MAP",
                        body: "D-MAP overlay is running.",
                      ),
                    );
                  } else {
                    await DashBubble.instance.requestOverlayPermission();
                  }
                },
                icon: const Icon(
                  Icons.play_circle_outline,
                  size: 40,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: () {
                  DashBubble.instance.stopBubble();
                },
                icon: const Icon(
                  Icons.pause_circle_outline,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 550,
          width: 400,
          child: MyKakaoMap(),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          print("포트홀 신고 클릭");
                                          await Api()
                                              .sendCurrentLocation("포트홀");
                                          notificationManager
                                              .showNotification();
                                        },
                                        icon: const Icon(
                                          Icons.build_outlined,
                                          size: 50,
                                        ),
                                      ),
                                      const Text("포트홀"),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          print("도로 막힘 신고 클릭");
                                          Api().sendCurrentLocation("도로 막힘");
                                          notificationManager
                                              .showNotification();
                                        },
                                        icon: const Icon(
                                          Icons.traffic_outlined,
                                          size: 50,
                                        ),
                                        tooltip: "도로 막힘 신고",
                                      ),
                                      const Text("도로 막힘"),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          print("차량 사고 신고 클릭");
                                          Api().sendCurrentLocation("차량 사고");
                                          notificationManager
                                              .showNotification();
                                        },
                                        icon: const Icon(
                                          Icons.car_crash_outlined,
                                          size: 50,
                                        ),
                                        tooltip: "차량 사고 신고",
                                      ),
                                      const Text("차량 사고"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyles.mainButtonStyle,
              child: const Text(
                "Share",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
