import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../core/error/result.dart';
import '../../domain/entities/auth_params.dart';
import '../../domain/repo/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<void>> signUp(SignUpParams params) async {
    try {
      await remoteDataSource.signUp(params);
      return const Success(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Failure(e.message ?? 'Authentication failed');
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<void>> signIn(SignInParams params) async {
    try {
      await remoteDataSource.signIn(params);
      return const Success(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Failure(e.message ?? 'Authentication failed');
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}