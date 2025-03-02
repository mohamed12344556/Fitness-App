// ملف: lib/core/routes/app_router.dart

import 'package:fitness_app/core/routes/routs.dart';
import 'package:fitness_app/features/auth/ui/views/welcome_screen.dart';
import 'package:fitness_app/features/auth/ui/views/login_screen.dart';
import 'package:fitness_app/features/auth/ui/views/sign_up_screen.dart';
import 'package:fitness_app/features/weather/ui/views/get_current_weather_by_name.dart';
import 'package:fitness_app/features/weather/ui/views/dashboard_screen.dart';
import 'package:fitness_app/features/weather/ui/views/modified_weather_home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/ui/logic/auth_cubit.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_cubit.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_prediction_cubit.dart'; // استيراد الـ cubit الجديد
import 'package:fitness_app/core/di/dependency_injection.dart';

import '../../features/weather/ui/views/weather_home_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => sl<AuthCubit>(),
                child: const WelcomeScreen(),
              ),
        );

      case Routes.logIn:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => sl<AuthCubit>(),
                child: const LoginScreen(),
              ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => sl<AuthCubit>(),
                child: const SignUpScreen(),
              ),
        );

      case Routes.dashboard:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => sl<AuthCubit>(),
                child: const DashboardScreen(),
              ),
        );

      case Routes.weatherHome:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
                  BlocProvider<WeatherCubit>(
                    create: (context) => sl<WeatherCubit>(),
                  ),
                ],
                child: const WeatherHomeView(),
              ),
        );

      case Routes.weatherByCity:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AuthCubit>(
                create: (context) => sl<AuthCubit>(),
                child: const GetCurrentWeatherByName(),
              ),
        );

      case Routes.aiWeatherPrediction:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
                  BlocProvider<WeatherCubit>(
                    create: (context) => sl<WeatherCubit>(),
                  ),
                  BlocProvider<WeatherPredictionCubit>(
                    create: (context) => sl<WeatherPredictionCubit>(),
                  ),
                ],
                child: const ModifiedWeatherHomeView(),
              ),
        );

      default:
        return null;
    }
  }
}
