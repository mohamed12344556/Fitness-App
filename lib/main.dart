import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/core/di/dependency_injection.dart';
import 'package:fitness_app/core/routes/app_router.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/fitness_app.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize dependency injection
  await init();
  runApp(FitnessApp(appRouter: AppRouter()));
}