import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(SignUpParams params);
  Future<void> signIn(SignInParams params);
  Future<void> forgotPassword(String email);
  Future<void> signOut();
  Future<Map<String, dynamic>?> getUserData(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  @override
  Future<void> signUp(SignUpParams params) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    if (userCredential.user != null) {
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': params.fullName,
        'email': params.email,
        if (params.birthDate != null) 'birthDate': params.birthDate,
        if (params.height != null) 'height': params.height,
        if (params.weight != null) 'weight': params.weight,
        'createdAt': FieldValue.serverTimestamp(),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<void> signIn(SignInParams params) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final docSnapshot = await _firestore.collection('users').doc(userId).get();
    if (docSnapshot.exists) {
      return docSnapshot.data();
    }
    return null;
  }
}
