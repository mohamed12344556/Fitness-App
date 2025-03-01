import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/domain/entities/current_weather_entity.dart';

abstract class CurrentWeatherRepo {
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeatherByCityName(
    String cityName,
  );
}
