import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nagib_pay/bloc/bottom_navigation/bottom_navigation_cubit.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        Container(),
                        Container(),
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
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(FeatherIcons.creditCard),
                      label: "Мои Е-баллы",
                    ),
                    NavigationDestination(
                      icon: Icon(FeatherIcons.user),
                      label: "Моё ебало",
                    )
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
