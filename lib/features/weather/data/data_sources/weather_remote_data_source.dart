import 'package:fitness_app/core/api/api_service.dart';
import 'package:fitness_app/features/weather/data/models/weather_request_body.dart';
import 'package:fitness_app/features/weather/data/models/weather_response_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> getCurrentWeatherByCityName(
    WeatherRequestBody request,
  );
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiService apiService;

  WeatherRemoteDataSourceImpl({required this.apiService});
  
  @override
  Future<WeatherResponse> getCurrentWeatherByCityName(WeatherRequestBody request) async {
    return await apiService.getCurrentWeatherByCityName(request.cityName);
  }
}