class Report {
  final String type;
  final String time;
  final String road;
  final int id;

  Report({
    required this.type,
    required this.time,
    required this.road,
    required this.id,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      type: json['type'],
      time: json['time'],
      road: json['road'],
      id: json['id'],
    );
  }
}
