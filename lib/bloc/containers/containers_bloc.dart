import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/containers/containers_event.dart';
import 'package:nagib_pay/bloc/containers/containers_state.dart';
import 'package:nagib_pay/models/container.dart';
import 'package:nagib_pay/repository/admin_repository.dart';

class ContainersBloc extends Bloc<ContainersEvent, ContainersState> {
  final AdminRepository adminRepository;

  ContainersBloc({
    required this.adminRepository,
  }) : super(ContainersState()) {
    on<Init>(
      (event, emit) async {
        List<TrashContainer> containers = await adminRepository.getContainers();

        emit(
          state.copyWith(
            containers: containers,
            loaded: true,
          ),
        );
      },
    );
  }
}
