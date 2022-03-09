import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';

import '../../models/history_action.dart';
import '../../widgets/history_item.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> historyStream =
        context.read<AdminRepository>().getHistoryStream();

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("История"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: historyStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Что-пошло не так');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
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
    );
  }
}
