class WeatherEntity {
  final String cityName;
  final num temp_c;
  final num humidity;
  final num feelslike_c;
  final num cloud;
  final List<ForecastDayEntity> forecastDays;
  final String conditionText;
  final String conditionIcon;

  WeatherEntity({
    required this.cityName,
    required this.temp_c,
    required this.humidity,
    required this.feelslike_c,
    required this.cloud,
    required this.forecastDays,
    required this.conditionText,
    required this.conditionIcon,
  });
}

class ForecastDayEntity {
  final String date;
  final String dayName; // Sun, Mon, etc.
  final int dayNumber;
  final num maxTemp;
  final num minTemp;
  final num avgTemp;
  final num humidity;
  final String conditionText;
  final String conditionIcon;
  final List<HourlyForecastEntity> hourlyForecasts;

  // Fitness app related metrics (mock data in real implementation)
  final int steps;
  final double distance; // in km
  final int heartRate;
  final int calories;
  final List<List<num>> chartData; // For visualizing activity data

  ForecastDayEntity({
    required this.date,
    required this.dayName,
    required this.dayNumber,
    required this.maxTemp,
    required this.minTemp,
    required this.avgTemp,
    required this.humidity,
    required this.conditionText,
    required this.conditionIcon,
    required this.hourlyForecasts,
    required this.steps,
    required this.distance,
    required this.heartRate,
    required this.calories,
    required this.chartData,
  });
}

class HourlyForecastEntity {
  final String time;
  final num temp_c;
  final num humidity;
  final num feelslike_c;
  final String conditionText;
  final String conditionIcon;

  HourlyForecastEntity({
    required this.time,
    required this.temp_c,
    required this.humidity,
    required this.feelslike_c,
    required this.conditionText,
    required this.conditionIcon,
  });
}