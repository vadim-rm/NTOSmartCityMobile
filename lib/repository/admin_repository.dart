import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nagib_pay/models/container.dart';
import 'package:nagib_pay/models/user.dart';

import '../models/history_action.dart';

class AdminRepository {
  Future<List<User?>> getUsers({bool showAdmin = false}) async {
    CollectionReference<Map<String, dynamic>> usersCollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot<Map<String, dynamic>> usersSnapshot;
    if (!showAdmin) {
      usersSnapshot =
          await usersCollection.where("role", isNotEqualTo: "admin").get();
    } else {
      usersSnapshot = await usersCollection.get();
    }

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
        userId: user.id!);

    await history.add(action.toJson());
  }

  Future<List<HistoryAction>> getHistory() async {
    List<User?> usersList = await getUsers(showAdmin: true);
    Map<String, User> users = {for (var e in usersList) e!.id!: e};

    QuerySnapshot<Map<String, dynamic>> historySnapshot =
        await FirebaseFirestore.instance
            .collection('history')
            .orderBy('date', descending: true)
            .get();

    List<HistoryAction> history = historySnapshot.docs
        .map<HistoryAction>(
            (his) => HistoryAction.fromJson(his.data()).copyWith(
                  user: users[his.data()["userId"]],
                ))
        .toList();

    return history;
  }

  Future<List<TrashContainer>> getContainers() async {
    QuerySnapshot<Map<String, dynamic>> containersSnapshot =
        await FirebaseFirestore.instance.collection('containers').get();

    List<TrashContainer> containers = containersSnapshot.docs
        .map(
          (container) => TrashContainer.fromJson(container.data())
              .copyWith(id: container.id),
        )
        .toList();
    return containers;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getContainerHistoryStream(
      String containerId) {
    return FirebaseFirestore.instance
        .collection('history')
        .where('userId', isEqualTo: containerId)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
