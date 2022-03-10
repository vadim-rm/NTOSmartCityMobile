import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/containers/containers_bloc.dart';
import 'package:nagib_pay/bloc/containers/containers_event.dart';
import 'package:nagib_pay/bloc/containers/containers_state.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/models/history_action.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/views/admin/containers_details.dart';
import 'package:nagib_pay/views/staff/bluetooth_view.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/container_item.dart';
import 'package:nagib_pay/widgets/history_item.dart';
import 'package:nagib_pay/widgets/rounded_button.dart';

class ContainersView extends StatelessWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text("Контейнеры")),
      body: BlocProvider(
        create: (context) =>
            ContainersBloc(adminRepository: context.read<AdminRepository>())
              ..add(Init()),
        child: BlocBuilder<ContainersBloc, ContainersState>(
          builder: (context, state) {
            if (!state.loaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: RefreshIndicator(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(children: [
                        ...state.containers!
                            .map(
                              (con) => GestureDetector(
                                child: ContainerItem(
                                  container: con,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ContainerDetails(container: con);
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                        const SizedBox(height: 20),
                        (state.formStatus is FormSubmitting)
                            ? const RoundedButton(
                                onPressed: null,
                                text: "Блокируем станцию",
                              )
                            : RoundedButton(
                                onPressed: () => context.read<ContainersBloc>().add(
                                      FormSubmitted(),
                                    ),
                                text: (state.blocked
                                    ? "Разблокировать станцию"
                                    : "Заблокировать станцию"),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...state.reports
                            .map(
                              (report) => GestureDetector(
                                child: HistoryItem(
                                  action: HistoryAction(
                                    action: "report_created",
                                    type: "trash",
                                    date: report.date!,
                                    amount: 1,
                                    userId: "1",
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BluetoothView(
                                        isEditable: false,
                                        trashReport: report,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ]),
                    ),
                    onRefresh: () async =>
                        context.read<ContainersBloc>().add(Init())),
              ),
            );
          },
        ),
      ),
    );
  }
}
