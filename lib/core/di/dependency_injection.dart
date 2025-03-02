import 'package:dio/dio.dart';
import 'package:fitness_app/core/api/api_service.dart';
import 'package:fitness_app/core/api/dio_factory.dart';
import 'package:fitness_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitness_app/features/auth/data/repo/auth_repository_impl.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repository.dart';
import 'package:fitness_app/features/auth/ui/logic/auth_cubit.dart';
import 'package:fitness_app/features/weather/data/data_sources/weather_prediction_data_source.dart';
import 'package:fitness_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:fitness_app/features/weather/data/repos/current_weather_repo_imp.dart';
import 'package:fitness_app/features/weather/data/repos/weather_prediction_repo_impl.dart';
import 'package:fitness_app/features/weather/domain/repos/weather_prediction_repo.dart';
import 'package:fitness_app/features/weather/domain/repos/weather_repo.dart';
import 'package:fitness_app/features/weather/domain/use_cases/current_weather_use_case.dart';
import 'package:fitness_app/features/weather/domain/use_cases/forecast_weather_use_case.dart';
import 'package:fitness_app/features/weather/domain/use_cases/weather_prediction_use_case.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_cubit.dart';
import 'package:fitness_app/features/weather/ui/logic/weather_prediction_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firestore);

  // Network
  sl.registerLazySingleton<Dio>(() => DioFactory.getDio());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // Cubits
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => WeatherCubit(sl(), sl()));
  sl.registerFactory(() => WeatherPredictionCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => CurrentWeatherUseCase(sl()));
  sl.registerLazySingleton(() => ForecastWeatherUseCase(sl()));
  sl.registerLazySingleton(() => WeatherPredictionUseCase(sl()));
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<WeatherRepo>(() => CurrentWeatherRepoImpl(sl()));
  sl.registerLazySingleton<WeatherPredictionRepo>(
    () => WeatherPredictionRepoImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
    ),
  );
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(apiService: sl()),
  );
  sl.registerLazySingleton<WeatherPredictionDataSource>(
    () => WeatherPredictionDataSourceImpl(dio: sl<Dio>()),
  );
}
