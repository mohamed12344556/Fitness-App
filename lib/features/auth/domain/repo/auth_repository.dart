import '../../../../core/api/result.dart';
import '../entities/auth_params.dart';

// واجهة المستودع للتوثيق
abstract class AuthRepository {
  // تسجيل حساب جديد
  Future<Result<void>> signUp(SignUpParams params);

  // تسجيل الدخول
  Future<Result<void>> signIn(SignInParams params);

  // استعادة كلمة المرور
  Future<Result<void>> forgotPassword(String email);

  // تسجيل الخروج
  Future<Result<void>> signOut();
  
  // الحصول على بيانات المستخدم
  Future<Result<Map<String, dynamic>?>> getUserData(String userId);
}