import 'package:fitness_app/core/di/dependency_injection.dart';
import 'package:fitness_app/core/routes/routs.dart';
import 'package:fitness_app/features/auth/ui/logic/auth_cubit.dart';
import 'package:fitness_app/features/auth/ui/views/login_screen.dart';
import 'package:fitness_app/features/auth/ui/views/sign_up_screen.dart';
import 'package:fitness_app/features/home/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.logIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUp:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => sl<AuthCubit>(),
                child: SignUpScreen(),
              ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return null;
    }
  }
}
