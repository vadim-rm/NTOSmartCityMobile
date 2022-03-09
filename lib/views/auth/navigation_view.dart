import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nagib_pay/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/views/admin/containers_view.dart';
import 'package:nagib_pay/views/admin/users_view.dart';
import 'package:nagib_pay/views/balance/balance.dart';
import 'package:nagib_pay/views/profile/profile.dart';

import '../admin/history.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userRole = context.read<SessionCubit>().user!.role;

    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IndexedStack(
                      index: currentIndex,
                      children: [
                        const BalanceView(),
                        const ProfileView(),
                        if (userRole == "admin") ...[
                          const UsersView(),
                          const HistoryView(),
                          const ContainersView(),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavigationBar(
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  height: 60,
                  selectedIndex: currentIndex,
                  onDestinationSelected: (index) =>
                      context.read<BottomNavigationCubit>().selectTab(index),
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(FeatherIcons.creditCard),
                      label: "Мои Е-баллы",
                    ),
                    const NavigationDestination(
                      icon: Icon(FeatherIcons.user),
                      label: "Моё ебало",
                    ),
                    if (userRole == "admin") ...[
                      const NavigationDestination(
                        icon: Icon(FeatherIcons.users),
                        label: "Все ебалы",
                      ),
                      const NavigationDestination(
                        icon: Icon(FeatherIcons.list),
                        label: "Движения ебалов",
                      ),
                      const NavigationDestination(
                        icon: Icon(FeatherIcons.trash),
                        label: "Состояние ебал",
                      )
                    ]
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
