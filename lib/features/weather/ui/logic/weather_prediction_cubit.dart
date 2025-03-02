import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_prediction_entity.dart';
import 'package:fitness_app/features/weather/domain/use_cases/weather_prediction_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_prediction_state.dart';

class WeatherPredictionCubit extends Cubit<WeatherPredictionState> {
  final WeatherPredictionUseCase predictionUseCase;
  
  WeatherPredictionCubit(this.predictionUseCase) : super(WeatherPredictionInitial());
  
  Future<void> predictOutdoorActivity(WeatherEntity weatherEntity) async {
    emit(WeatherPredictionLoading());
    
    final result = await predictionUseCase(weatherEntity);
    
    result.fold(
      (failure) => emit(WeatherPredictionFailure(message: failure.message)),
      (prediction) => emit(WeatherPredictionLoaded(prediction: prediction)),
    );
  }
}
