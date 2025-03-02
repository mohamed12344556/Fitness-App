part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  final int selectedDayIndex;

  const WeatherLoaded({
    required this.weather,
    this.selectedDayIndex = 0,
  });

  @override
  List<Object> get props => [weather, selectedDayIndex];
  
  ForecastDayEntity get selectedDay => 
      weather.forecastDays.isNotEmpty 
          ? weather.forecastDays[selectedDayIndex]
          : throw Exception('No forecast data available');
}

class WeatherFailure extends WeatherState {
  final String message;

  const WeatherFailure({required this.message});

  @override
  List<Object> get props => [message];
}