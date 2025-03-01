import 'package:json_annotation/json_annotation.dart';

part 'weather_response_model.g.dart';

@JsonSerializable()
class WeatherResponse {
  final Location location;
  final CurrentWeather current;

  WeatherResponse({required this.location, required this.current});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tz_id;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tz_id,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class CurrentWeather {
  final double temp_c;
  final double temp_f;
  final int is_day;
  final Condition condition;
  final double wind_kph;
  final int humidity;
  final int cloud;
  final double feelslike_c;
  final double vis_km;
  final double uv;

  CurrentWeather({
    required this.temp_c,
    required this.temp_f,
    required this.is_day,
    required this.condition,
    required this.wind_kph,
    required this.humidity,
    required this.cloud,
    required this.feelslike_c,
    required this.vis_km,
    required this.uv,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}

@JsonSerializable()
class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}