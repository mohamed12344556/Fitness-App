import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/features/auth/domain/entities/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(SignUpParams params);
  Future<void> signIn(SignInParams params);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<void> signUp(SignUpParams params) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    await userCredential.user?.updateDisplayName(params.fullName);
  }

  @override
  Future<void> signIn(SignInParams params) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}