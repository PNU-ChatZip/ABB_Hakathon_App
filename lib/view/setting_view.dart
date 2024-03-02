import 'package:d_map/api/api.dart';
import 'package:d_map/model/report.dart';
import 'package:d_map/service/storage.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    Storage.getString('name').then((value) {
      setState(() {
        if (value != null) {
          name = value;
        }
      });
    });

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  '내 정보 관리',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('이름'),
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: MediaQuery.of(context).size.width,
                  child: const ReportView(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReportView extends StatelessWidget {
  const ReportView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.getReports(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Report> reports = snapshot.data!;
          return ReportCardList(reports: reports);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ReportCardList extends StatefulWidget {
  const ReportCardList({super.key, required this.reports});

  final List<Report> reports;

  @override
  State<ReportCardList> createState() => _ReportCardListState();
}

class _ReportCardListState extends State<ReportCardList> {
  void onDelete(int id) {
    widget.reports.removeWhere((element) => element.id == id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.reports
            .map(
              (report) => ReportCard(
                report: report,
                onDelete: onDelete,
              ),
            )
            .toList(),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report, required this.onDelete});

  final Report report;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(report.time, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () {
                  onDeleteReport(context);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(report.road),
          ),
        ],
      ),
    );
  }

  void onDeleteReport(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Center(child: Text('삭제하시겠습니까?')),
        actions: <Widget>[
          TextButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('확인'),
            onPressed: () async {
              Navigator.of(context).pop();
              bool isSuccess = await Api.deleteReport(report.id);
              if (isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('삭제되었습니다.'),
                    duration: Duration(seconds: 1),
                  ),
                );
                onDelete(report.id);
              }
            },
          ),
        ],
      ),
    );
  }
}
