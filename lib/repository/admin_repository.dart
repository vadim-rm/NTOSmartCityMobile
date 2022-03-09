import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nagib_pay/models/user.dart';

import '../models/history_action.dart';

class AdminRepository {
  Future<List<User?>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> usersSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where("role", isNotEqualTo: "admin")
        .get();
    List<User?> users = usersSnapshot.docs
        .map(
          (firebaseUser) => User.fromJson(firebaseUser.data()).copyWith(
            id: firebaseUser.id,
          ),
        )
        .toList();
    // List<QueryDocumentSnapshot<Map<String, dynamic>>>
    return users;
  }

  Future<void> changeBalance({
    required User user,
    required int balance,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    await users.doc(user.id).update({
      'balance': balance,
    });

    CollectionReference history = firestore.collection('history');
    HistoryAction action = HistoryAction(
      action: balance > user.balance ? "balance_increase" : "buy",
      amount: (user.balance - balance).abs(),
      date: DateTime.now().toUtc(),
      type: "user",
      userId: user.id!
    );

    await history.add(action.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHistoryStream() {
    return FirebaseFirestore.instance
        .collection('history')
        .orderBy('date', descending: true)
        .snapshots();
  }
}
