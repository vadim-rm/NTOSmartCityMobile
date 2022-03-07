import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/bloc/from_sbmission_status.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/bloc/user_edit/user_edit_bloc.dart';
import 'package:nagib_pay/bloc/user_edit/user_edit_event.dart';
import 'package:nagib_pay/bloc/user_edit/user_edit_state.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/rounded_button.dart';

class UserEditView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final bool skipIfFilled;

  UserEditView({Key? key, this.skipIfFilled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text("Редактировать профиль")),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: BlocProvider(
            create: (context) => UserEditBloc(
              skipIfFilled: skipIfFilled,
              sessionCubit: context.read<SessionCubit>(),
              userRepository: context.read<UserRepository>(),
            )..add(Init()),
            child: BlocBuilder<UserEditBloc, UserEditState>(
                builder: (context, state) {
              if (!state.loaded) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _infoForm(),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _infoForm() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: _formKey,
        child: Wrap(
            runSpacing: 24,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _nameField(),
              _surnameField(),
              _formSubmitButton(),
            ]),
      ),
    );
  }

  Widget _nameField() {
    return BlocBuilder<UserEditBloc, UserEditState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Имя',
        ),
        autofillHints: const [AutofillHints.givenName],
        validator: (_) => state.isNameValid
            ? "Имя должно содержать только русские буквы"
            : null,
        initialValue: state.user!.name,
        onChanged: (name) => context.read<UserEditBloc>().add(
              NameChanged(name: name),
            ),
      );
    });
  }

  Widget _surnameField() {
    return BlocBuilder<UserEditBloc, UserEditState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Фамилия',
        ),
        autofillHints: const [AutofillHints.familyName],
        validator: (_) => state.isNameValid
            ? "Фамилия должна содержать только русские буквы"
            : null,
        initialValue: state.user!.surname,
        onChanged: (surname) => context.read<UserEditBloc>().add(
              SurnameChanged(surname: surname),
            ),
        onFieldSubmitted: (_) {
          if (_formKey.currentState!.validate()) {
            context.read<UserEditBloc>().add(FormSubmitted());
          }
        },
      );
    });
  }

  Widget _formSubmitButton() {
    return BlocBuilder<UserEditBloc, UserEditState>(builder: (context, state) {
      if (state.formStatus is FormSubmitting) {
        return const RoundedButton(
          text: "Сохраняем данные...",
          onPressed: null,
        );
      }
      return RoundedButton(
        text: "Подтвердить",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<UserEditBloc>().add(FormSubmitted());
          }
        },
      );
    });
  }
}
