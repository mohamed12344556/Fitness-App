import 'package:json_annotation/json_annotation.dart';

part 'weather_request_body.g.dart';

@JsonSerializable()
class WeatherRequestBody {
  @JsonKey(name: 'q')
  final String cityName;
  
  @JsonKey(name: 'days')
  final int days;

  WeatherRequestBody({
    required this.cityName,
    this.days = 3, // Default to 3 days for forecast
  });

  factory WeatherRequestBody.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherRequestBodyToJson(this);
}