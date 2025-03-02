class WeatherPredictionEntity {
  final int prediction;
  final String message;

  WeatherPredictionEntity({
    required this.prediction,
    required this.message,
  });

  bool get canGoOutside => prediction == 1;
}
