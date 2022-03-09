import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/history/history_bloc.dart';
import 'package:nagib_pay/bloc/history/history_event.dart';
import 'package:nagib_pay/bloc/history/history_state.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/views/admin/user_details.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';

import '../../widgets/history_item.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("История"),
      ),
      body: BlocProvider(
        create: (context) =>
            HistoryBloc(adminRepository: context.read<AdminRepository>())
              ..add(Init()),
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (!state.loaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                  child: ListView(
                    children: state.history!
                        .map(
                          (his) => GestureDetector(
                            child: HistoryItem(action: his),
                            onTap: () => {
                              if (his.type == "user")
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UserDetailsView(
                                          user: his.user!,
                                        );
                                      },
                                    ),
                                  ).then((_) =>
                                      context.read<HistoryBloc>().add(Init()))
                                },
                            },
                          ),
                        )
                        .toList(),
                  ),
                  onRefresh: () async =>
                      context.read<HistoryBloc>().add(Init())),
            );
          },
        ),
      ),
    );
  }
}
