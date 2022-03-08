import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/users/users_bloc.dart';
import 'package:nagib_pay/bloc/users/users_event.dart';
import 'package:nagib_pay/bloc/users/users_state.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/views/admin/user_details.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/profile_card.dart';
import 'package:nagib_pay/widgets/search_bar.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Пользователи"),
      ),
      body: BlocProvider(
        create: (context) => UsersBloc(
          adminRepository: context.read<AdminRepository>(),
        )..add(Init()),
        child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
          if (!state.loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: RefreshIndicator(
                child: ListView(children: [
                  SearchBar(),
                  ...state.users
                      .map((user) => GestureDetector(
                            child: ProfileCard(
                              user: user!,
                              showRole: false,
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserDetailsView(user: user);
                              }));
                            },
                          ))
                      .toList(),
                ]),
                onRefresh: () async {
                  context.read<UsersBloc>().add(Init());
                },
              ));
        }),
      ),
    );
  }
}
