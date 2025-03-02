import 'package:fitness_app/core/di/dependency_injection.dart';
import 'package:fitness_app/core/routes/routs.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCurrentWeatherByName extends StatelessWidget {
  const GetCurrentWeatherByName({super.key});

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
  String _userName = "User"; // Default username

  @override
  void initState() {
    super.initState();
    final weatherCubit = context.read<WeatherCubit>();
    _cityController.text = weatherCubit.currentCity;
    context.read<WeatherCubit>().getCurrentWeather(_cityController.text);
    _getCurrentUserName();
  }

  Future<void> _getCurrentUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // First check if the user has a display name set
        if (user.displayName != null && user.displayName!.isNotEmpty) {
          setState(() {
            _userName = user.displayName!;
          });
        } else {
          // If no display name, try to get the name from Firestore
          final userDoc =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();

          if (userDoc.exists) {
            // Check for fullName field with correct case sensitivity
            if (userDoc.data()!.containsKey('fullName')) {
              setState(() {
                _userName = userDoc.data()!['fullName'];
              });
            }
            // Then check other possible fields as fallbacks
            else if (userDoc.data()!.containsKey('name')) {
              setState(() {
                _userName = userDoc.data()!['name'];
              });
            } else if (userDoc.data()!.containsKey('userName')) {
              setState(() {
                _userName = userDoc.data()!['userName'];
              });
            } else if (user.email != null) {
              setState(() {
                _userName = user.email!.split('@')[0]; // Just use part before @
              });
            }
          } else if (user.email != null) {
            // If document doesn't exist, use email as fallback
            setState(() {
              _userName = user.email!.split('@')[0];
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF001C40), // Dark blue background
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),

              // Map Placeholder with Weather Info
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Map placeholder
                        Container(
                          color: const Color(0xFF0A2646),
                          child: Center(
                            child: BlocBuilder<WeatherCubit, WeatherState>(
                              builder: (context, state) {
                                if (state is WeatherLoaded) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.amber,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        state.weather.cityName,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${state.weather.temp_c}°C',
                                        style: const TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _weatherInfoItem(
                                            Icons.water_drop,
                                            '${state.weather.humidity}%',
                                            'Humidity',
                                          ),
                                          const SizedBox(width: 30),
                                          _weatherInfoItem(
                                            Icons.thermostat,
                                            '${state.weather.feelslike_c}°C',
                                            'Feels Like',
                                          ),
                                          const SizedBox(width: 30),
                                          _weatherInfoItem(
                                            Icons.cloud,
                                            '${state.weather.cloud}%',
                                            'Cloud',
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else if (state is WeatherLoading) {
                                  return const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                } else if (state is WeatherFailure) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Error: ${state.message}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Text(
                                    'Search for a city',
                                    style: TextStyle(color: Colors.white),
                                  );
                                }
                              },
                            ),
                          ),
                        ),

                        // "Extend" Label at Bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            color: Colors.black.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: const Text(
                              'Extend',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Search Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _cityController,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: 'Destination',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final cityName = _cityController.text.trim();
                        if (cityName.isNotEmpty) {
                          context.read<WeatherCubit>().getCurrentWeather(
                            cityName,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),

              // Navigation Bar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1929),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _navBarItem(
                      Icons.wb_sunny,
                      'Current',
                      isSelected: true, // This is the current page
                    ),
                    _navBarItem(
                      Icons.cloud,
                      'Forecast',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.weatherHome,
                        );
                      },
                    ),
                    _navBarItem(
                      Icons.auto_awesome,
                      'AI Predict',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.aiWeatherPrediction,
                        );
                      },
                    ),
                    _navBarItem(
                      Icons.dashboard,
                      'Dashboard',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.dashboard,
                        );
                      },
                    ),
                    _navBarItem(
                      Icons.settings,
                      'Settings',
                      onTap: () {
                        _showComingSoonDialog(context, 'Settings');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Coming Soon'),
            content: Text(
              'The $feature feature will be available in a future update.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Widget _weatherInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _navBarItem(
    IconData icon,
    String label, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border:
                  isSelected ? Border.all(color: Colors.white, width: 2) : null,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
