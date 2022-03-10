import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/models/container.dart';
import 'package:nagib_pay/models/history_action.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/widgets/card_with_title.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/history_item.dart';

class ContainerDetails extends StatelessWidget {
  final TrashContainer container;

  const ContainerDetails({
    Key? key,
    required this.container,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> containerHistoryStream =
        context
            .read<AdminRepository>()
            .getContainerHistoryStream(container.id!);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("История контейнера"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                CardWithTitle(title: "ID", body: Text(container.id.toString())),
                CardWithTitle(
                    title: "Тип", body: Text(container.typeDescription)),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: containerHistoryStream,
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
            ),
          ),
        ),
      ),
    );
  }
}
