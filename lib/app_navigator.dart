import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/auth/auth_navigator.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/bloc/session/session_state.dart';
import 'package:nagib_pay/views/auth/navigation_view.dart';
import 'package:nagib_pay/views/auth/user_edit_view.dart';

import 'bloc/auth/auth_cubit.dart';

class AppNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => !await _navigatorKey.currentState!.maybePop(),
        child: Navigator(
          key: _navigatorKey,
          pages: [
            if (state is Unknown)
              MaterialPage(
                child: Container(),
              ),
            // Show auth flow
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => AuthCubit(
                    sessionCubit: context.read<SessionCubit>(),
                  ),
                  child: const AuthNavigator(),
                ),
              ),

            // Show session flow
            if (state is Authenticated) ...[
              if (!state.blockPop) const MaterialPage(child: NavigationView()),
              if (state.showEditView) MaterialPage(child: UserEditView()),
            ]
          ],
          onPopPage: (route, result) {
            if (state is Authenticated) {
              if (state.showEditView) {
                context.read<SessionCubit>().popFromEditView();
              }
            }
            return route.didPop(result);
          },
        ),
      );
    });
  }
}
