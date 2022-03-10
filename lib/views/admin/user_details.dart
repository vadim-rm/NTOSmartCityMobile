import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nagib_pay/models/history_action.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/history_item.dart';
import 'package:nagib_pay/widgets/profile_big_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsView extends StatelessWidget {
  final User user;

  const UserDetailsView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> historyStream =
        context.read<UserRepository>().getBalanceHistoryStream(userId: user.id);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Информация о пользователе"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              ProfileBigCard(user: user),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: historyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Что-пошло не так');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          HistoryAction data = HistoryAction.fromJson(
                              document.data() as Map<String, dynamic>);
                          return HistoryItem(action: data);
                        },
                      ).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
