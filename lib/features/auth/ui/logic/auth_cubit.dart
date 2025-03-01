import 'package:fitness_app/features/auth/ui/logic/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/api/result.dart';
import '../../domain/entities/auth_params.dart';
import '../../domain/repo/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._authRepository) 
      : _firebaseAuth = FirebaseAuth.instance,
        super(const AuthInitial());

  // الحصول على معرف المستخدم الحالي
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  // التحقق مما إذا كان المستخدم مسجل دخوله
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? birthYear,
    String? birthMonth,
    String? birthDay,
    String? height,
    String? weight,
  }) async {
    emit(const AuthLoading());

    // تحويل الطول والوزن إلى أرقام إذا كانت متوفرة
    int? heightInt;
    int? weightInt;

    if (height != null && height.isNotEmpty) {
      heightInt = int.tryParse(height);
    }

    if (weight != null && weight.isNotEmpty) {
      weightInt = int.tryParse(weight);
    }

    final params = SignUpParams(
      email: email,
      password: password,
      fullName: fullName,
      birthDate: _formatBirthDate(birthYear, birthMonth, birthDay),
      height: heightInt,
      weight: weightInt,
    );

    final result = await _authRepository.signUp(params);

    switch (result) {
      case Success():
        emit(const AuthSuccess());
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }

  String? _formatBirthDate(String? year, String? month, String? day) {
    if (year == null || month == null || day == null) {
      return null;
    }

    if (year.isEmpty || month.isEmpty || day.isEmpty) {
      return null;
    }

    return '$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}';
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading());

    final result = await _authRepository.signIn(
      SignInParams(email: email, password: password),
    );

    switch (result) {
      case Success():
        emit(const AuthSuccess());
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthLoading());

    final result = await _authRepository.forgotPassword(email);

    switch (result) {
      case Success():
        emit(const AuthForgotPasswordSuccess());
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());

    final result = await _authRepository.signOut();

    switch (result) {
      case Success():
        emit(const AuthInitial());
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }
  
  // طريقة للحصول على بيانات المستخدم
  Future<void> getUserData() async {
    if (currentUserId == null) {
      emit(const AuthError("لا يوجد مستخدم مسجل حالياً"));
      return;
    }
    
    emit(const AuthLoading());
    
    final result = await _authRepository.getUserData(currentUserId!);
    
    switch (result) {
      case Success(data: var userData):
        if (userData != null) {
          emit(AuthUserDataLoaded(userData));
        } else {
          emit(const AuthError("لا توجد بيانات للمستخدم"));
        }
      case Failure(message: var message):
        emit(AuthError(message));
    }
  }
}