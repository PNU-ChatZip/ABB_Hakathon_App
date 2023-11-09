class Record {
  final String type;
  final String time;
  final String road;
  final int id;

  Record(this.type, this.time, this.road, this.id);

  Map<String, dynamic> toJson() {
    return {'type': type, 'time': time, 'road': road, 'id': id};
  }

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      json['type'] as String,
      json['time'] as String,
      json['road'] as String,
      json['id'],
    );
  }

  @override
  String toString() {
    return "$type,$time,$road";
  }
}
