import 'package:fitness_app/features/auth/ui/logic/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/auth_params.dart';
import '../../domain/repo/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(const AuthLoading());
    final result = await _authRepository.signUp(
      SignUpParams(
        email: email,
        password: password,
        fullName: fullName,
      ),
    );

    switch (result) {
      case Success():
        emit(const AuthSuccess());
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _authRepository.signIn(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    switch (result) {
      case Success():
        emit(const AuthSuccess());
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }
}