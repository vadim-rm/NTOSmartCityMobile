import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/history/history_event.dart';
import 'package:nagib_pay/bloc/history/history_state.dart';
import 'package:nagib_pay/models/history_action.dart';
import 'package:nagib_pay/repository/admin_repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final AdminRepository adminRepository;

  HistoryBloc({
    required this.adminRepository,
  }) : super(HistoryState()) {
    on<Init>(
      (event, emit) async {
        List<HistoryAction> history = await adminRepository.getHistory();

        emit(
          state.copyWith(
            history: history,
            loaded: true,
          ),
        );
      },
    );
  }
}
