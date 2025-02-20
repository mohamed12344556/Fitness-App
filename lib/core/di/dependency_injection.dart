import 'package:fitness_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitness_app/features/auth/data/repo/auth_repository_impl.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repository.dart';
import 'package:fitness_app/features/auth/ui/logic/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  // Cubits
  sl.registerFactory(() => AuthCubit(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
}