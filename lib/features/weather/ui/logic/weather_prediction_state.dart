part of 'weather_prediction_cubit.dart';

abstract class WeatherPredictionState extends Equatable {
  const WeatherPredictionState();
  
  @override
  List<Object> get props => [];
}

class WeatherPredictionInitial extends WeatherPredictionState {}

class WeatherPredictionLoading extends WeatherPredictionState {}

class WeatherPredictionLoaded extends WeatherPredictionState {
  final WeatherPredictionEntity prediction;
  
  const WeatherPredictionLoaded({required this.prediction});
  
  @override
  List<Object> get props => [prediction];
}

class WeatherPredictionFailure extends WeatherPredictionState {
  final String message;
  
  const WeatherPredictionFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}