import 'package:json_annotation/json_annotation.dart';

part 'weather_request_body.g.dart';

@JsonSerializable()
class WeatherRequestBody {
  @JsonKey(name: 'q')
  final String cityName;

  WeatherRequestBody({required this.cityName});

  factory WeatherRequestBody.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherRequestBodyToJson(this);
}
