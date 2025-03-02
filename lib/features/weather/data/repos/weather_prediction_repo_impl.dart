import 'package:dartz/dartz.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/data/data_sources/weather_prediction_data_source.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_prediction_entity.dart';
import 'package:fitness_app/features/weather/domain/repos/weather_prediction_repo.dart';

class WeatherPredictionRepoImpl implements WeatherPredictionRepo {
  final WeatherPredictionDataSource predictionDataSource;

  WeatherPredictionRepoImpl(this.predictionDataSource);

  @override
  Future<Either<Failure, WeatherPredictionEntity>> predictOutdoorActivity(
    WeatherEntity weatherEntity,
  ) async {
    try {
      final features = _convertWeatherToFeatures(weatherEntity);
      final result = await predictionDataSource.getPrediction(features);

      String message =
          result == 1
              ? "¡Buen momento para salir! El clima es favorable."
              : "No es recomendable salir. El clima no es favorable.";

      return Right(
        WeatherPredictionEntity(prediction: result, message: message),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  List<int> _convertWeatherToFeatures(WeatherEntity weatherEntity) {
    List<int> features = [0, 0, 0, 0, 0];

    if (weatherEntity.conditionText.toLowerCase().contains('rain') ||
        weatherEntity.conditionText.toLowerCase().contains('lluvia') ||
        weatherEntity.conditionText.toLowerCase().contains('shower')) {
      features[0] = 1; 
    }
    else if (weatherEntity.conditionText.toLowerCase().contains('sun') ||
        weatherEntity.conditionText.toLowerCase().contains('sol') ||
        weatherEntity.conditionText.toLowerCase().contains('clear') ||
        weatherEntity.conditionText.toLowerCase().contains('sunny')) {
      features[1] = 1; 
    }

    if (weatherEntity.temp_c > 30) {
      features[2] = 1; 
    } else if (weatherEntity.temp_c > 15 && weatherEntity.temp_c <= 30) {
      features[3] = 1; 
    }

    if (weatherEntity.humidity >= 30 && weatherEntity.humidity <= 60) {
      features[4] = 1; 
    }

    return features;
  }
}
