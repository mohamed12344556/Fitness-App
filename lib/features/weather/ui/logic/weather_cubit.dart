import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:fitness_app/features/weather/domain/use_cases/current_weather_use_case.dart';
import 'package:fitness_app/features/weather/domain/use_cases/forecast_weather_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // إضافة هذا الاستيراد

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final CurrentWeatherUseCase currentWeatherUseCase;
  final ForecastWeatherUseCase forecastWeatherUseCase;
  int selectedDayIndex = 0;
  String currentCity = "Egypt"; // قيمة افتراضية

  WeatherCubit(this.currentWeatherUseCase, this.forecastWeatherUseCase) 
      : super(WeatherInitial()) {
    // استدعاء دالة تحميل اسم المدينة المخزن عند إنشاء الـ Cubit
    _loadSavedCity();
  }

  // دالة جديدة لتحميل اسم المدينة المخزن
  Future<void> _loadSavedCity() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCity = prefs.getString('currentCity');
      if (savedCity != null && savedCity.isNotEmpty) {
        currentCity = savedCity;
        // إذا كانت الحالة الحالية هي WeatherInitial، نقوم بتحميل بيانات الطقس للمدينة المخزنة
        if (state is WeatherInitial) {
          getForecastWeather(currentCity);
        }
      }
    } catch (e) {
      print('Error loading saved city: $e');
    }
  }

  // دالة جديدة لحفظ اسم المدينة
  Future<void> _saveCity(String cityName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentCity', cityName);
      currentCity = cityName;
    } catch (e) {
      print('Error saving city: $e');
    }
  }

  Future<void> getCurrentWeather(String cityName) async {
    emit(WeatherLoading());
    // حفظ اسم المدينة الجديد
    await _saveCity(cityName);
    
    final result = await currentWeatherUseCase(cityName);
    result.fold(
      (failure) => emit(WeatherFailure(message: failure.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }
  
  Future<void> getForecastWeather(String cityName, {int days = 3}) async {
    emit(WeatherLoading());
    // حفظ اسم المدينة الجديد
    await _saveCity(cityName);
    
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
