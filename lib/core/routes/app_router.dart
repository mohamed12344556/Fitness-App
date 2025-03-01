import 'package:fitness_app/core/routes/routs.dart';
import 'package:fitness_app/features/auth/ui/views/welcome_screen.dart';
import 'package:fitness_app/features/auth/ui/views/login_screen.dart';
import 'package:fitness_app/features/auth/ui/views/sign_up_screen.dart';
import 'package:fitness_app/features/weather/ui/views/weather_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/auth/ui/logic/auth_cubit.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_cubit.dart';
import 'package:fitness_app/core/di/dependency_injection.dart';

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

      default:
        return null;
    }
  }
}
