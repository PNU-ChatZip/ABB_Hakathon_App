import 'package:d_map/util/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRecords(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<String>? records = snapshot.data;
          if (records == null || records.isEmpty) {
            return const Center(
              child: Text(
                "기록 없음",
                style: TextStyle(
                  color: ColorStyles.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return ListView(
            children: [
              for (int i = 0; i < records.length; i++)
                SizedBox(
                  height: 100,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                        onPressed: () {
                          print("click record #$i");
                        },
                        child: Text(records[i]),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            removeRecord(i);
                          });
                          print("remove record #$i");
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 20.0),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 16), // Set the font size
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: Colors.redAccent,
                                width: 2), // Set border color and width
                          ),
                        ),
                        child: const Text(
                          "신고 취소",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "데이터 불러오기 실패",
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(143, 148, 251, 1),
            ),
          );
        }
      },
    );
  }

  Future<List<String>> getRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? records = prefs.getStringList('records');
    if (records == null) {
      return [];
    } else {
      return records;
    }
  }

  void removeRecord(int recordId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> records = prefs.getStringList('records')!;
    records.removeAt(recordId);
    await prefs.setStringList('records', records);
  }
}
