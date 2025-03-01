class CurrentWeatherEntity {
  final String cityName;
  final num temp_c;
  final num humidity;
  final num feelslike_c;
  final num cloud;

  CurrentWeatherEntity({
    required this.cityName,
    required this.temp_c,
    required this.humidity,
    required this.feelslike_c,
    required this.cloud,
  });
}
