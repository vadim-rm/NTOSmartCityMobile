import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nagib_pay/models/user.dart';

class AdminRepository {
  Future<List<User?>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> usersSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where("role", isNotEqualTo: "admin")
        .get();
    List<User?> users = usersSnapshot.docs
        .map((firebaseUser) => User.fromJson(firebaseUser.data()))
        .toList();
    // List<QueryDocumentSnapshot<Map<String, dynamic>>>
    return users;
  }
}
