import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../core/api/result.dart';
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
  Future<Result<void>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Success(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Failure(e.message ?? 'Password reset failed');
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }
  
  @override
  Future<Result<Map<String, dynamic>?>> getUserData(String userId) async {
    try {
      final userData = await remoteDataSource.getUserData(userId);
      return Success(userData);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}