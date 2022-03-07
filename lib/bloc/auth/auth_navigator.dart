import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/auth/auth_cubit.dart';
import 'package:nagib_pay/views/auth/sign_in_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthNavigationState>(
        builder: (context, state) {
      return Navigator(
        pages: [
          if (state == AuthNavigationState.auth)
            MaterialPage(child: SignInView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
