import 'package:d_map/util/style.dart';
import 'package:d_map/view/main_view.dart';
import 'package:d_map/view/record_view.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        onTap: (index) {
          setState(() {
            _currentIdx = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: _currentIdx == 0 ? ColorStyles.mainColor : Colors.black,
              ),
              label: "HOME"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive,
                size: 30,
                color: _currentIdx == 1 ? ColorStyles.mainColor : Colors.black,
              ),
              label: "RECORD"),
        ],
        selectedItemColor: ColorStyles.mainColor,
      ),
    );
  }

  Widget getPage() {
    late Widget page;

    switch (_currentIdx) {
      case 0:
        page = const MainView();
        break;

      case 1:
        page = const RecordView();
        break;
    }

    return page;
  }
}
