import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'displayName': displayName,
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("🔥 Firestore set error: $e");
      rethrow;
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isAdmin() async {
    final user = _auth.currentUser;
    if (user != null) {
      final tokenResult = await user.getIdTokenResult(true);
      return tokenResult.claims?['admin'] == true;
    }
    return false;
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
