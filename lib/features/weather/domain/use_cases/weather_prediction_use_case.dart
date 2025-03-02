import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_prediction_entity.dart';
import 'package:fitness_app/features/weather/domain/repos/weather_prediction_repo.dart';

class WeatherPredictionUseCase {
  final WeatherPredictionRepo weatherPredictionRepo;
  
  WeatherPredictionUseCase(this.weatherPredictionRepo);
  
  Future<Either<Failure, WeatherPredictionEntity>> call(WeatherEntity weatherEntity) {
    return weatherPredictionRepo.predictOutdoorActivity(weatherEntity);
  }
}