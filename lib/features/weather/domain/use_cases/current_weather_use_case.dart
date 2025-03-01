import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/core/use_cases/use_case.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/repos/current_weather_repo.dart';

class CurrentWeatherUseCase extends UseCase<Failure, WeatherEntity, String> {
  final CurrentWeatherRepo currentWeatherRepo;
  CurrentWeatherUseCase(this.currentWeatherRepo);

  @override
  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return currentWeatherRepo.getCurrentWeatherByCityName(cityName);
  }
}
