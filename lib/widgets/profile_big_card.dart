import 'package:flutter/material.dart';
import 'package:nagib_pay/bloc/balance_edit/balance_bloc.dart';
import 'package:nagib_pay/bloc/balance_edit/balance_event.dart';
import 'package:nagib_pay/bloc/balance_edit/balance_state.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/card_with_title.dart';
import 'package:nagib_pay/widgets/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagib_pay/widgets/rounded_button.dart';

import '../bloc/from_submission_status.dart';
import 'custom_alert_dialog.dart';

class ProfileBigCard extends StatelessWidget {
  final User user;

  const ProfileBigCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  void _showAlertDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog().fromError(context: context, error: error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BalanceBloc(
          user: user, adminRepository: context.read<AdminRepository>()),
      child: BlocBuilder<BalanceBloc, BalanceState>(
        builder: (context, state) {
          return BlocListener<BalanceBloc, BalanceState>(
            listener: (context, state) {
              final formStatus = state.formStatus;
              if (formStatus is SubmissionFailed) {
                _showAlertDialog(context, formStatus.failure.toString());
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: user.fullName,
                    child: Avatar(
                      user: user,
                      userRepository: context.read<UserRepository>(),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Wrap(
                    runSpacing: 8,
                    children: [
                      CardWithTitle(
                        title: "ФИО",
                        body: Text(
                          user.fullNameWithMiddle,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      CardWithTitle(
                        title: "Адрес проживания",
                        body: Text(
                          user.address,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                          maxLines: 5,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      CardWithTitle(
                        title: "Роль",
                        body: Text(
                          user.roleDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CardWithTitle(
                        title: "Баланс",
                        body: TextFormField(
                          initialValue: user.balance.toString(),
                          onChanged: (balance) =>
                              context.read<BalanceBloc>().add(
                                    BalanceChanged(
                                      balance: int.parse(balance.isEmpty ? "0" : balance),
                                    ),
                                  ),
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black,
                                  ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            icon: const Image(
                              height: 52,
                              width: 52,
                              image: AssetImage('assets/dollar.png'),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: (state.formStatus is FormSubmitting)
                                ? const RoundedButton(
                                    onPressed: null,
                                    text: "Обновляем баланс",
                                  )
                                : RoundedButton(
                                    onPressed: () =>
                                        context.read<BalanceBloc>().add(
                                              FormSubmitted(),
                                            ),
                                    text: "Обновить",
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
