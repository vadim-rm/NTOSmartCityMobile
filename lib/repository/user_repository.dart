import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nagib_pay/bloc/failure.dart';
import 'package:nagib_pay/models/user.dart' as account;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserRepository {
  Future<void> createUser(account.User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? userID = FirebaseAuth.instance.currentUser?.uid;

    try {
      await users.doc(userID).set(user.toJson());
    } catch (e) {
      throw Failure(ErrorCode.INTERNAL);
    }
  }

  Future<account.User> getCurrentUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Failure(ErrorCode.USER_NOT_LOGGED);
    }
    DocumentSnapshot snapshot = await users.doc(userID).get();
    if (snapshot.exists) {
      return account.User.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      throw Failure(ErrorCode.USER_NOT_CREATED);
    }
  }

  Future<void> updateUser(account.User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    try {
      await users.doc(userID).update(user.toJson());
    } catch (e) {
      throw Failure(ErrorCode.INTERNAL);
    }
  }

  Future<String?> getAvatarUrl({String? userID}) async {
    userID ??= FirebaseAuth.instance.currentUser?.uid;
    try {
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('avatars/$userID.png')
          .getDownloadURL();

      return downloadURL;
    } catch (e) {
      return null;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBalanceHistoryStream() {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('history')
        .where('userId', isEqualTo: userID)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
