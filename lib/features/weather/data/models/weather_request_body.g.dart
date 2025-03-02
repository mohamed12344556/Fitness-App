// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherRequestBody _$WeatherRequestBodyFromJson(Map<String, dynamic> json) =>
    WeatherRequestBody(
      cityName: json['q'] as String,
      days: (json['days'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$WeatherRequestBodyToJson(WeatherRequestBody instance) =>
    <String, dynamic>{'q': instance.cityName, 'days': instance.days};
