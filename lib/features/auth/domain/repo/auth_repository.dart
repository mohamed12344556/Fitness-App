import 'package:fitness_app/core/error/result.dart';
import 'package:fitness_app/features/auth/domain/entities/auth_params.dart';


abstract class AuthRepository {
  Future<Result<void>> signUp(SignUpParams params);
  Future<Result<void>> signIn(SignInParams params);
  Future<void> signOut();
}