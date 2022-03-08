import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/auth/auth_bloc.dart';
import 'package:nagib_pay/bloc/auth/auth_cubit.dart';
import 'package:nagib_pay/bloc/auth/auth_event.dart';
import 'package:nagib_pay/bloc/auth/auth_state.dart';
import 'package:nagib_pay/bloc/auth/form_mode.dart';
import 'package:nagib_pay/bloc/from_submission_status.dart';
import 'package:nagib_pay/repository/auth_repository.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/custom_alert_dialog.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/rounded_button.dart';

class SignInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: _loginForm(),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog().fromError(context: context, error: error);
        });
  }

  Widget _loginForm() {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showAlertDialog(context, formStatus.failure.toString());
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Привет"),
                  SizedBox(
                    width: 8,
                  ),
                  Image(
                    height: 32,
                    width: 32,
                    image: AssetImage("assets/waving_hand.png"),
                  ),
                ],
              ),
              buttons: [
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return TextButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(FormModeChanged()),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      firstChild: const Text('Регистрация'),
                      secondChild: const Text('Вход'),
                      crossFadeState: (state.formMode is SignInMode)
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: _formKey,
                child: Wrap(
                  runSpacing: 24,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _emailField(),
                    _passwordField(),
                    _formSubmitButton(),
                    // _signInWithGoogleButton(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _emailField() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email',
        ),
        onChanged: (value) => context.read<AuthBloc>().add(
              AuthEmailChanged(email: value),
            ),
        validator: (value) => state.isValidEmail ? null : 'Неверный Email',
        autofillHints: const [AutofillHints.email],
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Пароль',
          suffixIcon: IconButton(
            color: Colors.grey,
            icon: Icon(state.passwordObscured
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded),
            onPressed: () =>
                context.read<AuthBloc>().add(ObscurePasswordStateChanged()),
          ),
        ),
        onChanged: (value) => context.read<AuthBloc>().add(
              AuthPasswordChanged(password: value),
            ),
        validator: (value) => state.isValidPassword
            ? null
            : 'Пароль должен содержать минимум 8 символов',
        obscureText: state.passwordObscured,
        autofillHints: const [AutofillHints.password],
        onFieldSubmitted: (_) {
          if (_formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(FormSubmitted());
          }
        },
      );
    });
  }

  Widget _formSubmitButton() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.formStatus is FormSubmitting) {
        return const RoundedButton(
          text: "Выполняется вход...",
          onPressed: null,
        );
      }
      return RoundedButton(
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: const Text('Вход'),
          secondChild: const Text('Регистрация'),
          crossFadeState: (state.formMode is SignInMode)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(FormSubmitted());
          }
        },
      );
    });
  }

//   Widget _signInWithGoogleButton() {
//     return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//       return SignInWithGoogleButton(
//         enabled: state.formStatus is! FormSubmitting,
//         onPressed: () {
//           context.read<AuthBloc>().add(SignInWithGoogleSubmitted());
//         },
//       );
//     });
//   }
}
