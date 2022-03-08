import 'package:bloc/bloc.dart';
import 'package:nagib_pay/bloc/users/users_event.dart';
import 'package:nagib_pay/bloc/users/users_state.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/admin_repository.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AdminRepository adminRepository;

  UsersBloc({
    required this.adminRepository,
  }) : super(UsersState()) {
    on<Init>(
      (event, emit) async {
        List<User?> users = await adminRepository.getUsers();

        emit(state.copyWith(
          users: users,
          loaded: true,
        ));
      },
    );

    on<SearchBarChanged>(
      (event, emit) {
        print(event.searchText);
        emit(state.copyWith(
            users: state.users
                .where((user) =>
                    user!.fullNameWithMiddle.contains(event.searchText))
                .toList()));
      },
    );
  }
}
