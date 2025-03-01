import 'package:dio/dio.dart';
import 'package:fitness_app/core/api/api_constants.dart';
import 'package:fitness_app/features/weather/data/models/weather_response_model.dart';

import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET(ApiConstants.currentWeather)
  Future<WeatherResponse> getCurrentWeatherByCityName(@Query('q') String cityName);
}