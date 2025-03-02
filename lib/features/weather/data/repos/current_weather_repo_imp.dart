import 'package:dartz/dartz.dart';
import 'package:fitness_app/features/weather/domain/repos/weather_repo.dart';
import 'package:intl/intl.dart';
import 'package:fitness_app/core/api/result.dart';
import 'package:fitness_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:fitness_app/features/weather/data/models/weather_request_body.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'dart:math';

class CurrentWeatherRepoImpl implements WeatherRepo {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  CurrentWeatherRepoImpl(this.weatherRemoteDataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeatherByCityName(
    String cityName,
  ) async {
    try {
      final weatherRequestBody = WeatherRequestBody(cityName: cityName);
      final result = await weatherRemoteDataSource.getCurrentWeatherByCityName(
        weatherRequestBody,
      );

      // Create a default entity with mock data for testing
      final now = DateTime.now();
      final random = Random();

      return Right(
        WeatherEntity(
          cityName: result.location.name,
          temp_c: result.current.temp_c,
          humidity: result.current.humidity,
          feelslike_c: result.current.feelslike_c,
          cloud: result.current.cloud,
          forecastDays: _createMockForecastDays(
            3,
            now,
          ), // Create mock forecast days
          conditionText: result.current.condition.text,
          conditionIcon: result.current.condition.icon,
        ),
      );
    } catch (e) {
      print("Error in getCurrentWeatherByCityName: $e");
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getForecastWeatherByCityName(
    String cityName, {
    int days = 3,
  }) async {
    try {
      final weatherRequestBody = WeatherRequestBody(
        cityName: cityName,
        days: days,
      );
      final result = await weatherRemoteDataSource.getForecastWeatherByCityName(
        weatherRequestBody,
      );

      // Check if forecast data exists
      final forecastDays = <ForecastDayEntity>[];

      if (result.forecast != null && result.forecast!.forecastday != null) {
        // Use real forecast data
        forecastDays.addAll(
          result.forecast!.forecastday!.map((forecastDay) {
            try {
              // Parse date to get day name and day number
              final date = DateTime.parse(forecastDay.date);
              final dayName = DateFormat('E').format(date); // Mon, Tue, etc.
              final dayNumber = date.day;

              // Generate random fitness data for mock purposes
              final random = Random();
              final steps = 4000 + random.nextInt(2000);
              final distance = (10 + random.nextInt(5)) / 1.0;
              final heartRate = 70 + random.nextInt(40);
              final calories = 500 + random.nextInt(300);

              // Generate chart data (mock activity data)
              final chartData = List.generate(10, (index) {
                final x = index * 10.0;
                final y = (20 + random.nextInt(60)).toDouble();
                return <num>[x, y];
              });

              // Create hourly forecasts - handle empty hour array
              final hourlyForecasts =
                  forecastDay.hour.isEmpty
                      ? _generateDummyHourlyForecasts(date)
                      : forecastDay.hour.map((hour) {
                        return HourlyForecastEntity(
                          time:
                              hour.time.split(' ')[1], // Extract time part only
                          temp_c: hour.temp_c,
                          humidity: hour.humidity,
                          feelslike_c: hour.feelslike_c,
                          conditionText: hour.condition.text,
                          conditionIcon: hour.condition.icon,
                        );
                      }).toList();

              return ForecastDayEntity(
                date: forecastDay.date,
                dayName: dayName,
                dayNumber: dayNumber,
                maxTemp: forecastDay.day.maxtemp_c,
                minTemp: forecastDay.day.mintemp_c,
                avgTemp: forecastDay.day.avgtemp_c,
                humidity: forecastDay.day.avghumidity,
                conditionText: forecastDay.day.condition.text,
                conditionIcon: forecastDay.day.condition.icon,
                hourlyForecasts: hourlyForecasts,
                steps: steps,
                distance: distance,
                heartRate: heartRate,
                calories: calories,
                chartData: chartData,
              );
            } catch (e) {
              print('Error mapping forecast day: $e');
              // Return a default entity if there's an error
              return _createDefaultForecastDay();
            }
          }).toList(),
        );
      } else {
        // Create mock forecast days if forecast data is missing
        print("No forecast data found, creating mock data");
        final now = DateTime.now();
        forecastDays.addAll(_createMockForecastDays(days, now));
      }

      return Right(
        WeatherEntity(
          cityName: result.location.name,
          temp_c: result.current.temp_c,
          humidity: result.current.humidity,
          feelslike_c: result.current.feelslike_c,
          cloud: result.current.cloud,
          forecastDays: forecastDays,
          conditionText: result.current.condition.text,
          conditionIcon: result.current.condition.icon,
        ),
      );
    } catch (e) {
      print('Repository error in getForecastWeatherByCityName: $e');
      return Left(Failure(message: e.toString()));
    }
  }

  // Create mock forecast days
  List<ForecastDayEntity> _createMockForecastDays(
    int count,
    DateTime startDate,
  ) {
    return List.generate(count, (index) {
      final date = startDate.add(Duration(days: index));
      return _createMockForecastDay(date);
    });
  }

  // Create a mock forecast day for a specific date
  ForecastDayEntity _createMockForecastDay(DateTime date) {
    final dayName = DateFormat('E').format(date);
    final random = Random();

    // Generate random temperature values
    final minTemp = 10.0 + random.nextDouble() * 5;
    final maxTemp = minTemp + 5.0 + random.nextDouble() * 10;
    final avgTemp = (minTemp + maxTemp) / 2;

    // Generate random fitness data
    final steps = 4000 + random.nextInt(2000);
    final distance = (10 + random.nextInt(5)) / 1.0;
    final heartRate = 70 + random.nextInt(40);
    final calories = 500 + random.nextInt(300);

    // Generate chart data
    final chartData = List.generate(10, (index) {
      final x = index * 10.0;
      final y = (20 + random.nextInt(60)).toDouble();
      return <num>[x, y];
    });

    return ForecastDayEntity(
      date: DateFormat('yyyy-MM-dd').format(date),
      dayName: dayName,
      dayNumber: date.day,
      maxTemp: maxTemp,
      minTemp: minTemp,
      avgTemp: avgTemp,
      humidity: 40.0 + random.nextDouble() * 40,
      conditionText: 'Sunny',
      conditionIcon: '//cdn.weatherapi.com/weather/64x64/day/113.png',
      hourlyForecasts: _generateDummyHourlyForecasts(date),
      steps: steps,
      distance: distance,
      heartRate: heartRate,
      calories: calories,
      chartData: chartData,
    );
  }

  // Generate dummy hourly forecasts when the API doesn't provide them
  List<HourlyForecastEntity> _generateDummyHourlyForecasts(DateTime date) {
    final random = Random();
    return List.generate(24, (index) {
      final hour = index;
      final timeString = '$hour:00';
      final temp = 15.0 + random.nextDouble() * 10;

      return HourlyForecastEntity(
        time: timeString,
        temp_c: temp,
        humidity: 50 + random.nextInt(30),
        feelslike_c: temp - 1 + random.nextDouble() * 2,
        conditionText: 'Sunny',
        conditionIcon: '//cdn.weatherapi.com/weather/64x64/day/113.png',
      );
    });
  }

  // Create a default forecast day when there's an error
  ForecastDayEntity _createDefaultForecastDay() {
    final now = DateTime.now();
    final dayName = DateFormat('E').format(now);
    final random = Random();

    return ForecastDayEntity(
      date: DateFormat('yyyy-MM-dd').format(now),
      dayName: dayName,
      dayNumber: now.day,
      maxTemp: 25.0,
      minTemp: 15.0,
      avgTemp: 20.0,
      humidity: 60.0,
      conditionText: 'Sunny',
      conditionIcon: '//cdn.weatherapi.com/weather/64x64/day/113.png',
      hourlyForecasts: _generateDummyHourlyForecasts(now),
      steps: 5000,
      distance: 12.0,
      heartRate: 80,
      calories: 600,
      chartData: List.generate(
        10,
        (index) => <num>[index * 10.0, 30.0 + random.nextDouble() * 40],
      ),
    );
  }
}
