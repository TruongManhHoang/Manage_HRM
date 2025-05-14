import 'package:admin_hrm/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser> fetchUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Người dùng chưa đăng nhập");

    final tokenResult = await user.getIdTokenResult(true);
    final token = tokenResult.token ?? '';

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (!userDoc.exists) throw Exception("Không tìm thấy thông tin người dùng");

    return AppUser.fromMap(userDoc.data()!, uid: user.uid, token: token);
  }
}
