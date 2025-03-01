import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class AuthForgotPasswordSuccess extends AuthState {
  const AuthForgotPasswordSuccess();
}

class AuthUserDataLoaded extends AuthState {
  final Map<String, dynamic> userData;

  const AuthUserDataLoaded(this.userData);

  @override
  List<Object?> get props => [userData];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}