import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/bloc/staff/staff_bloc.dart';
import 'package:nagib_pay/bloc/staff/staff_event.dart';
import 'package:nagib_pay/bloc/staff/staff_state.dart';
import 'package:nagib_pay/models/trash_report.dart';
import 'package:nagib_pay/repository/staff_repository.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';
import 'package:nagib_pay/widgets/checkbox_card.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/rounded_button.dart';

class BluetoothView extends StatelessWidget {
  final bool isEditable;
  final TrashReport? trashReport;

  const BluetoothView({
    this.isEditable = true,
    this.trashReport,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text("Проверка станции")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => StaffBloc(
            staffRepository: context.read<StaffRepository>(),
            trashReport: trashReport,
            isEditable: isEditable,
          ),
          child: BlocBuilder<StaffBloc, StaffState>(
            builder: (context, state) {
              // if (!state.isConnected && isEditable) {
              //   return Center(
              //     child: RoundedButton(
              //       onPressed: () {
              //         context.read<StaffBloc>().add(ConnectBluetooth());
              //       },
              //       text: "Подключиться к станции",
              //     ),
              //   );
              // }
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    children: [
                      Column(
                        children: const [
                          // if (isEditable) ...[
                          //   RoundedButton(
                          //     onPressed: () {
                          //       context.read<StaffBloc>().add(CheckServo());
                          //     },
                          //     text: "Проверить сервоприводы",
                          //   ),
                          // ],
                          SizedBox(
                            height: 20,
                          ),
                          CheckboxCard(
                            sensorType: SensorType.servo,
                            trashType: TrashType.paper,
                          ),
                          CheckboxCard(
                            sensorType: SensorType.servo,
                            trashType: TrashType.plastic,
                          ),
                          CheckboxCard(
                            sensorType: SensorType.servo,
                            trashType: TrashType.glass,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          if (isEditable) ...[
                            Text(
                              "Проверка датчиков цвета",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Начните подносить карточки соответствующих цветов к сенсорам",
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                          const CheckboxCard(
                            sensorType: SensorType.color,
                            trashType: TrashType.paper,
                          ),
                          const CheckboxCard(
                            sensorType: SensorType.color,
                            trashType: TrashType.plastic,
                          ),
                          const CheckboxCard(
                            sensorType: SensorType.color,
                            trashType: TrashType.glass,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          if (isEditable) ...[
                            Text(
                              "Проверка датчиков расстояния",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Поднесите предмет к сенсору",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                          const CheckboxCard(
                            sensorType: SensorType.distance,
                            trashType: TrashType.paper,
                          ),
                          const CheckboxCard(
                            sensorType: SensorType.distance,
                            trashType: TrashType.plastic,
                          ),
                          const CheckboxCard(
                            sensorType: SensorType.distance,
                            trashType: TrashType.glass,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isEditable) ...[
                        (state.formStatus is FormSubmitting)
                            ? const RoundedButton(
                                onPressed: null,
                                text: "Отправляем отчет",
                              )
                            : RoundedButton(
                                onPressed: () => context
                                    .read<StaffBloc>()
                                    .add(FormSubmitted()),
                                text: "Отправить отчет",
                              ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
