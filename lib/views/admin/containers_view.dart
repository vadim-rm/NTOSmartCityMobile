import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/containers/containers_bloc.dart';
import 'package:nagib_pay/bloc/containers/containers_event.dart';
import 'package:nagib_pay/bloc/containers/containers_state.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/views/admin/containers_details.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/container_item.dart';

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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                  children: state.containers!
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
                      .toList()),
            );
          },
        ),
      ),
    );
  }
}
