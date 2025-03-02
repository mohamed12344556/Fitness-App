import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/core/use_cases/use_case.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/repos/weather_repo.dart';

class ForecastParams {
  final String cityName;
  final int days;

  ForecastParams({required this.cityName, this.days = 3});
}

class ForecastWeatherUseCase
    extends UseCase<Failure, WeatherEntity, ForecastParams> {
  final WeatherRepo weatherRepo;
  ForecastWeatherUseCase(this.weatherRepo);

  @override
  Future<Either<Failure, WeatherEntity>> call(ForecastParams params) {
    return weatherRepo.getForecastWeatherByCityName(
      params.cityName,
      days: params.days,
    );
  }
}
