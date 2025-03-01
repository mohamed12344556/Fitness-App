import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/di/dependency_injection.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_cubit.dart';

class WeatherHomeView extends StatelessWidget {
  const WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherCubit>(),
      child: const _HomeViewContent(),
    );
  }
}

class _HomeViewContent extends StatefulWidget {
  const _HomeViewContent();

  @override
  State<_HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<_HomeViewContent> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Default city
    _cityController.text = 'London';
    // Get weather for default city
    context.read<WeatherCubit>().getCurrentWeather(_cityController.text);
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final cityName = _cityController.text.trim();
                    if (cityName.isNotEmpty) {
                      context.read<WeatherCubit>().getCurrentWeather(cityName);
                    }
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  final weather = state.weather;
                  return _buildWeatherInfo(weather);
                } else if (state is WeatherFailure) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(
                  child: Text('Search for a city to get weather information'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(weather) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _infoRow('Temperature', '${weather.temp_c}°C'),
            _infoRow('Feels Like', '${weather.feelslike_c}°C'),
            _infoRow('Humidity', '${weather.humidity}%'),
            _infoRow('Cloud Coverage', '${weather.cloud}%'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
