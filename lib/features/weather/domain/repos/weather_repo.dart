import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepo {
  Future<Either<Failure, WeatherEntity>> getCurrentWeatherByCityName(
    String cityName,
  );
  Future<Either<Failure, WeatherEntity>> getForecastWeatherByCityName(
    String cityName, {
    int days = 3,
  });
}
