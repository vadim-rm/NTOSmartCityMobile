import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/models/user.dart' as Account;

class UserRepository {
  Future<void> createUser(Account.User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users.add(user.toJson());
    } catch (_) {
      throw Failure(ErrorCode.INTERNAL);
    }
  }

  Future<Account.User> getCurrentUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot snapshot = await users.doc(userID).get();
    if (snapshot.exists) {
      return Account.User.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    throw Failure(ErrorCode.USER_NOT_LOGGED);
  }

  Future<void> updateUser(Account.User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    try {
      await users.doc(userID).update(user.toJson());
    } catch (_) {
      throw Failure(ErrorCode.INTERNAL);
    }
  }
}
