import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:fitness_app/features/weather/data/models/weather_request_body.dart';
import 'package:fitness_app/features/weather/domain/entities/current_weather_entity.dart';
import 'package:fitness_app/features/weather/domain/repos/current_weather_repo.dart';

class CurrentWeatherRepoImpl implements CurrentWeatherRepo {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  CurrentWeatherRepoImpl(this.weatherRemoteDataSource);

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeatherByCityName(
    String cityName,
  ) async {
    try {
      final weatherRequestBody = WeatherRequestBody(cityName: cityName);
      final result = await weatherRemoteDataSource.getCurrentWeatherByCityName(
        weatherRequestBody,
      );
      return Right(
        CurrentWeatherEntity(
          cityName: result.location.name,
          temp_c: result.current.temp_c,
          humidity: result.current.humidity,
          feelslike_c: result.current.feelslike_c,
          cloud: result.current.cloud,
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
