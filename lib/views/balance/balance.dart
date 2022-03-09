import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/extensions/date_extension.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/data_card.dart';

import '../../models/history_action.dart';
import '../../models/user.dart';
import '../../widgets/history_item.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({Key? key}) : super(key: key);

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  @override
  Widget build(BuildContext context) {
    SessionCubit sessionCubit = context.read<SessionCubit>();
    final Stream<DocumentSnapshot> userStream =
        context.read<UserRepository>().getUserStream();

    final Stream<QuerySnapshot<Map<String, dynamic>>> historyStream =
        context.read<UserRepository>().getBalanceHistoryStream();

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Баланс"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: userStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Что-пошло не так');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              User newUser =
                  User.fromJson(snapshot.data!.data() as Map<String, dynamic>);
              sessionCubit.setUser(user: newUser);

              return ListView(
                children: [
                  DataCard(
                    value: newUser.balance.toString(),
                    units: 'ByteCoin',
                    image: const Padding(
                      padding: EdgeInsets.only(
                        top: 6,
                        right: 10,
                      ),
                      child: Image(
                        height: 52,
                        width: 52,
                        image: AssetImage('assets/money.png'),
                      ),
                    ),
                  ),
                  DataCard(
                    value: newUser.trashCounter.toString(),
                    units: 'мешков',
                    image: const Padding(
                      padding: EdgeInsets.only(top: 10, right: 10, left: 6),
                      child: Image(
                        height: 44,
                        width: 44,
                        image: AssetImage('assets/basket.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: historyStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Что-пошло не так');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot document) {
                            HistoryAction data = HistoryAction.fromJson(
                                document.data() as Map<String, dynamic>);
                            return HistoryItem(action: data);
                          },
                        ).toList(),
                      );
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
