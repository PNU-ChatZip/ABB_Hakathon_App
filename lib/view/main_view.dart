import 'package:d_map/util/style.dart';
import 'package:d_map/widget/MyKakaoMap.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 50,
              ),
              const Center(
                child: Text(
                  "화면 오버레이",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: () {},
                icon: const Icon(
                  Icons.play_circle_outline,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: () {},
                icon: const Icon(
                  Icons.pause_circle_outline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 500,
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
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.build_outlined,
                                          size: 50,
                                        ),
                                        tooltip: "포트홀 신고",
                                      ),
                                      const Text("포트홀"),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
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
                                        onPressed: () {},
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
              child: const Text("신고하기"),
            ),
          ],
        )
      ],
    );
  }
}
