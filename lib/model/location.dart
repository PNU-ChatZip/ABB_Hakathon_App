class location {
  final String latitude;
  final String longitude;
  final String type;
  final String time;
  final String userId;

  location(this.latitude, this.longitude, this.type, this.time, this.userId);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
        'time': time,
        'userId': userId,
      };

  factory location.fromJson(Map<String, dynamic> json) {
    return location(
      json['latitude'],
      json['longitude'],
      json['type'],
      json['time'],
      json['userId'],
    );
  }

  @override
  String toString() {
    return "$latitude,$longitude,$type,$time,$userId";
  }
}
