import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/data_card.dart';

import '../../models/user.dart';

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

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Баланс"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      padding: EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 6
                      ),
                      child: Image(
                        height: 44,
                        width: 44,
                        image: AssetImage('assets/basket.png'),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}