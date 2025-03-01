import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/weather/domain/entities/current_weather_entity.dart';
import 'package:fitness_app/features/weather/domain/use_cases/current_weather_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final CurrentWeatherUseCase currentWeatherUseCase;

  WeatherCubit(this.currentWeatherUseCase) : super(WeatherInitial());

  Future<void> getCurrentWeather(String cityName) async {
    emit(WeatherLoading());
    final result = await currentWeatherUseCase(cityName);
    result.fold(
      (failure) => emit(WeatherFailure(message: failure.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }
}
