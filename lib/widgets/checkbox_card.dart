import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/staff/staff_bloc.dart';
import 'package:nagib_pay/bloc/staff/staff_event.dart';
import 'package:nagib_pay/bloc/staff/staff_state.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';

class CheckboxCard extends StatelessWidget {
  final TrashType trashType;
  final SensorType sensorType;

  const CheckboxCard({
    required this.trashType,
    required this.sensorType,
    Key? key,
  }) : super(key: key);

  String getTitle() {
    return "${sensorType.getDescription()} ${trashType.getDescription().toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        return Card(
          child: ListTile(
            leading: Text(
              getTitle(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: Checkbox(
              value: state.trashReport.status[sensorType]![trashType],
              onChanged: (_) {
                if (state.isEditable) {
                  context.read<StaffBloc>().add(ChangedCheckbox(
                      sensorType: sensorType, trashType: trashType));
                }
              },
              activeColor: Colors.green,
              fillColor: MaterialStateProperty.resolveWith(
                (state) {
                  if (state.contains(MaterialState.selected)) {
                    return Colors.green;
                  }
                  return Colors.red;
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
