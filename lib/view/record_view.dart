import 'package:d_map/api/api.dart';
import 'package:d_map/util/style.dart';
import 'package:flutter/material.dart';

import '../model/Record.dart';

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api().getRecords(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Record>? records = snapshot.data;
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
                  height: 150,
                  width: 400,
                  child: Card(
                    surfaceTintColor: ColorStyles.mainColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (String detail in prettyRecord(records[i]))
                                Container(
                                  padding: EdgeInsets.all(5),
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
                        OutlinedButton(
                          onPressed: () async {
                            await Api().removeRecord(records[i].id);
                            print("remove record #${records[i].id}");
                            setState(() {});
                          },
                          style: ButtonStyles.closeButtonStyle,
                          child: const Text(
                            "취소",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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

  List<String> prettyRecord(Record record) {
    List<String> stringList = record.toString().split(",");
    stringList[1] = "신고 시각 : ${stringList[1]}";
    stringList[2] = "위치 : ${stringList[2]}";
    return stringList;
  }
}
