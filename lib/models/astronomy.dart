class AstronomyData {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;

  AstronomyData({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });

  factory AstronomyData.fromJson(Map<String, dynamic> json) {
    return AstronomyData(
      sunrise: json['astronomy']['astro']['sunrise'],
      sunset: json['astronomy']['astro']['sunset'],
      moonrise: json['astronomy']['astro']['moonrise'],
      moonset: json['astronomy']['astro']['moonset'],
    );
  }
}
