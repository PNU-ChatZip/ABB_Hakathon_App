class location {
  final String latitude;
  final String longitude;
  final String type;
  final String time;

  location(this.latitude, this.longitude, this.type, this.time);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
        'time': time,
      };

  factory location.fromJson(Map<String, dynamic> json) {
    return location(
      json['latitude'],
      json['longitude'],
      json['type'],
      json['time'],
    );
  }
}
