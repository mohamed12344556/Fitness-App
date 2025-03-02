import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/use_cases/current_weather_use_case.dart';
import 'package:fitness_app/features/weather/domain/use_cases/forecast_weather_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final CurrentWeatherUseCase currentWeatherUseCase;
  final ForecastWeatherUseCase forecastWeatherUseCase;
  int selectedDayIndex = 0;

  WeatherCubit(this.currentWeatherUseCase, this.forecastWeatherUseCase) 
      : super(WeatherInitial());

  Future<void> getCurrentWeather(String cityName) async {
    emit(WeatherLoading());
    final result = await currentWeatherUseCase(cityName);
    result.fold(
      (failure) => emit(WeatherFailure(message: failure.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }
  
  Future<void> getForecastWeather(String cityName, {int days = 3}) async {
    emit(WeatherLoading());
    final result = await forecastWeatherUseCase(ForecastParams(
      cityName: cityName,
      days: days,
    ));
    
    result.fold(
      (failure) => emit(WeatherFailure(message: failure.message)),
      (weather) {
        emit(WeatherLoaded(
          weather: weather,
          selectedDayIndex: selectedDayIndex,
        ));
      },
    );
  }
  
  void selectDay(int index) {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      
      if (index >= 0 && index < currentState.weather.forecastDays.length) {
        selectedDayIndex = index;
        emit(WeatherLoaded(
          weather: currentState.weather,
          selectedDayIndex: selectedDayIndex,
        ));
      }
    }
  }
}