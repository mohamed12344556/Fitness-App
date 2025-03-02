import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_prediction_entity.dart';

abstract class WeatherPredictionRepo {
  Future<Either<Failure, WeatherPredictionEntity>> predictOutdoorActivity(WeatherEntity weatherEntity);
}