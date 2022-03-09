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

        emit(
          state.copyWith(
            allUsers: users,
            filteredUsers: users,
            loaded: true,
          ),
        );
      },
    );

    on<SearchBarTextChanged>(
      (event, emit) {
        emit(
          state.copyWith(
            filteredUsers: state.allUsers
                .where(
                  (user) => user!.searchData.toLowerCase().contains(event.text.toLowerCase()),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
