class RawRecord {
  final String latitude;
  final String longitude;

  RawRecord(this.latitude, this.longitude);

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory RawRecord.fromJson(Map<String, dynamic> json) {
    return RawRecord(
      json['latitude'] as String,
      json['longitude'] as String,
    );
  }
}
