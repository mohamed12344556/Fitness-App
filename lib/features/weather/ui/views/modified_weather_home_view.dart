import 'package:fitness_app/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/di/dependency_injection.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_cubit.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_prediction_cubit.dart';
import 'package:fitness_app/features/weather/ui/widgets/weather_prediction_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/core/routes/routs.dart';

class ModifiedWeatherHomeView extends StatelessWidget {
  const ModifiedWeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<WeatherCubit>()),
        BlocProvider(create: (context) => sl<WeatherPredictionCubit>()),
      ],
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
    context.read<WeatherCubit>().getForecastWeather(_cityController.text);
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
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (state is WeatherFailure) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (state is WeatherLoaded) {
                final weather = state.weather;
                final selectedDay = state.selectedDay;

                return Column(
                  children: [
                    // Header Section with User Name instead of city name
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
                                _userName, // Display user name instead of city name
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

                    // Weather Location Display (Added to show current city)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              weather.cityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Weather Search Option
Padding(
  padding: const EdgeInsets.all(10),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search city...',
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            final cityName = _cityController.text.trim();
            if (cityName.isNotEmpty) {
              context.read<WeatherCubit>().getForecastWeather(cityName);
              FocusScope.of(context).unfocus(); // إخفاء لوحة المفاتيح
            }
          },
        ),
      ],
    ),
  ),
),

                    // Day Selector
                    SizedBox(
                      height: 90,
                      child: _buildDaySelector(weather, state.selectedDayIndex),
                    ),

                    // AI Prediction Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<WeatherPredictionCubit>()
                              .predictOutdoorActivity(weather);
                          _showPredictionResults(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.auto_awesome),
                        label: const Text(
                          'هل يجب أن أخرج اليوم؟',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    // Steps Count with Icon
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.directions_walk,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                selectedDay.steps.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Steps',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                    // Metrics Row
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMetricCircle(
                            selectedDay.distance.toStringAsFixed(1),
                            'KM',
                            selectedDay.distance / 15, // Percentage for circle
                          ),
                          _buildMetricCircle(
                            selectedDay.heartRate.toString(),
                            'Heart Rate',
                            selectedDay.heartRate /
                                200, // Percentage for circle
                          ),
                          _buildMetricCircle(
                            selectedDay.calories.toString(),
                            'CAL',
                            selectedDay.calories /
                                1000, // Percentage for circle
                          ),
                        ],
                      ),
                    ),

                    // Activity Chart
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A1929),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildActivityChart(selectedDay.chartData),
                          ),
                        ),
                      ),
                    ),

                    // Navigation Bar - Updated with AI Prediction navigation
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
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.weatherByCity,
                              );
                            },
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
                            isSelected: true, // Esta es la página actual
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
                );
              }

              return const Center(
                child: Text(
                  'Search for a city to get weather information',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Method to show prediction results
  void _showPredictionResults(BuildContext context) {
    final cubit = context.read<WeatherPredictionCubit>();

    showDialog(
      context: context,
      builder:
          (dialogContext) => BlocProvider.value(
            value: cubit, // تمرير Cubit الموجود بالفعل
            child: Builder(
              builder:
                  (providerContext) => BlocBuilder<
                    WeatherPredictionCubit,
                    WeatherPredictionState
                  >(
                    builder: (builderContext, state) {
                      if (state is WeatherPredictionLoading) {
                        return const AlertDialog(
                          backgroundColor: Color(0xFF0A1929),
                          content: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else if (state is WeatherPredictionLoaded) {
                        return WeatherPredictionDialog(
                          prediction: state.prediction,
                        );
                      } else if (state is WeatherPredictionFailure) {
                        return AlertDialog(
                          backgroundColor: const Color(0xFF0A1929),
                          title: const Text(
                            'خطأ',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                            'لم نتمكن من الحصول على التنبؤ: ${state.message}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed:
                                  () => Navigator.of(dialogContext).pop(),
                              child: const Text('إغلاق'),
                            ),
                          ],
                        );
                      }
                      return const AlertDialog(
                        backgroundColor: Color(0xFF0A1929),
                        content: Text(
                          'جاري تحميل التنبؤ...',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
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
            title: const Text('قريباً'),
            content: Text('ستتوفر ميزة $feature في تحديث مستقبلي.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('حسناً'),
              ),
            ],
          ),
    );
  }

  Widget _buildDaySelector(WeatherEntity weather, int selectedIndex) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1929),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.forecastDays.length,
        itemBuilder: (context, index) {
          final day = weather.forecastDays[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              context.read<WeatherCubit>().selectDay(index);
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.dayName,
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    day.dayNumber.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCircle(String value, String label, double percentage) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 8,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChart(List<List<num>> chartData) {
    final spots =
        chartData.map((point) {
          return FlSpot(point[0].toDouble(), point[1].toDouble());
        }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.white10, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: chartData.isNotEmpty ? chartData.last[0].toDouble() : 100,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }

  // Updated NavBar item to handle navigation
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
