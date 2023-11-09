import 'package:d_map/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/style.dart';
import '../model/Record.dart';

class MileageView extends StatefulWidget {
  const MileageView({super.key});

  @override
  State<MileageView> createState() => _MileageViewState();
}

class _MileageViewState extends State<MileageView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Map<String, dynamic> userData = snapshot.data!;
          final userId = userData["id"];
          List<Record> records = userData["completed"];
          return ListView(
            children: [
              SizedBox(
                height: 150,
                width: 400,
                child: Card(
                  margin: const EdgeInsets.only(top: 30),
                  surfaceTintColor: ColorStyles.mainColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID : $userId"),
                          Text("마일리지 : ${records.length * 100}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              for (int i = 0; i < records.length; i++)
                Card(
                  surfaceTintColor: ColorStyles.mainColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: ColorStyles.mainColor,
                        size: 60,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (String detail in prettyRecord(records[i]))
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  detail,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else if (snapshot.hasError) {
          Navigator.pop(context);
          return const Text("logout");
        } else {
          return const Text("Load..");
        }
      },
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await _prefs;
    List<Record> completedRecords = await Api().getCompletedRecords();
    Map<String, dynamic> userData = {};
    if (prefs.getString("id") == null) return {};
    userData["id"] = prefs.getString("id");
    userData["completed"] = completedRecords;
    return userData;
  }

  List<String> prettyRecord(Record record) {
    List<String> stringList = record.toString().split(",");
    stringList[1] = "신고 시각 : ${stringList[1]}";
    List<String> loc = stringList[2].trim().split(" ");
    loc.removeRange(0, 2);
    stringList[2] = "위치 : ${loc.join(" ")}";
    return stringList;
  }
}
