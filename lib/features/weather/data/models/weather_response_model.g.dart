// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  name: json['name'] as String,
  region: json['region'] as String,
  country: json['country'] as String,
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
  tz_id: json['tz_id'] as String,
  localtime: json['localtime'] as String,
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'name': instance.name,
  'region': instance.region,
  'country': instance.country,
  'lat': instance.lat,
  'lon': instance.lon,
  'tz_id': instance.tz_id,
  'localtime': instance.localtime,
};

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      temp_c: (json['temp_c'] as num).toDouble(),
      temp_f: (json['temp_f'] as num).toDouble(),
      is_day: (json['is_day'] as num).toInt(),
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
      wind_kph: (json['wind_kph'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      cloud: (json['cloud'] as num).toInt(),
      feelslike_c: (json['feelslike_c'] as num).toDouble(),
      vis_km: (json['vis_km'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'temp_c': instance.temp_c,
      'temp_f': instance.temp_f,
      'is_day': instance.is_day,
      'condition': instance.condition,
      'wind_kph': instance.wind_kph,
      'humidity': instance.humidity,
      'cloud': instance.cloud,
      'feelslike_c': instance.feelslike_c,
      'vis_km': instance.vis_km,
      'uv': instance.uv,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
  text: json['text'] as String,
  icon: json['icon'] as String,
  code: (json['code'] as num).toInt(),
);

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
  'text': instance.text,
  'icon': instance.icon,
  'code': instance.code,
};
