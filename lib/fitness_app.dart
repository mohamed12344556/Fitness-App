import 'package:fitness_app/core/routes/app_router.dart';
import 'package:fitness_app/core/routes/routs.dart';
import 'package:flutter/material.dart';

class FitnessApp extends StatelessWidget {
  final AppRouter appRouter;
  const FitnessApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: Routes.signUp,
    );
  }
}
