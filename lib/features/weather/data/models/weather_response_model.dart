import 'package:json_annotation/json_annotation.dart';

part 'weather_response_model.g.dart';

@JsonSerializable()
class WeatherResponse {
  final Location location;
  final CurrentWeather current;
  @JsonKey(defaultValue: null)
  final ForecastData? forecast;

  WeatherResponse({
    required this.location, 
    required this.current, 
    this.forecast
  });

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

@JsonSerializable()
class ForecastData {
  final List<ForecastDay>? forecastday;

  ForecastData({this.forecastday = const []});

  factory ForecastData.fromJson(Map<String, dynamic> json) =>
      _$ForecastDataFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastDataToJson(this);
}

@JsonSerializable()
class ForecastDay {
  final String date;
  final int date_epoch;
  final DayWeather day;
  final Astro astro;
  @JsonKey(defaultValue: const [])
  final List<HourWeather> hour;

  ForecastDay({
    required this.date,
    required this.date_epoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);
}

@JsonSerializable()
class DayWeather {
  final double maxtemp_c;
  final double mintemp_c;
  final double avgtemp_c;
  final double maxwind_kph;
  final double totalprecip_mm;
  final double avgvis_km;
  final double avghumidity;
  final Condition condition;
  final double uv;

  DayWeather({
    required this.maxtemp_c,
    required this.mintemp_c,
    required this.avgtemp_c,
    required this.maxwind_kph,
    required this.totalprecip_mm,
    required this.avgvis_km,
    required this.avghumidity,
    required this.condition,
    required this.uv,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) =>
      _$DayWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$DayWeatherToJson(this);
}

@JsonSerializable()
class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moon_phase;
  final int moon_illumination; // Changed to int
  @JsonKey(defaultValue: 0)
  final int? is_moon_up;
  @JsonKey(defaultValue: 0)
  final int? is_sun_up;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moon_phase,
    required this.moon_illumination,
    this.is_moon_up,
    this.is_sun_up,
  });

  factory Astro.fromJson(Map<String, dynamic> json) =>
      _$AstroFromJson(json);
  Map<String, dynamic> toJson() => _$AstroToJson(this);
}

@JsonSerializable()
class HourWeather {
  final int time_epoch;
  final String time;
  final double temp_c;
  final double temp_f;
  final int is_day;
  final Condition condition;
  final double wind_kph;
  final int humidity;
  final double feelslike_c;

  HourWeather({
    required this.time_epoch,
    required this.time,
    required this.temp_c,
    required this.temp_f,
    required this.is_day,
    required this.condition,
    required this.wind_kph,
    required this.humidity,
    required this.feelslike_c,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) =>
      _$HourWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$HourWeatherToJson(this);
}