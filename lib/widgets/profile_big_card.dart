import 'package:flutter/material.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/card_with_title.dart';
import 'package:nagib_pay/widgets/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBigCard extends StatelessWidget {
  final User user;
  const ProfileBigCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Hero(
            transitionOnUserGestures: true,
            tag: user.fullName,
            child: Avatar(
                user: user, userRepository: context.read<UserRepository>()),
          ),
          const SizedBox(
            width: 30,
          ),
          Wrap(
            runSpacing: 8,
            children: [
              CardWithTitle(title: "ФИО", body: user.fullNameWithMiddle),
              CardWithTitle(title: "Адрес проживания", body: user.address),
              CardWithTitle(title: "Роль", body: user.roleDescription)
            ],
          ),
        ],
      ),
    );
  }
}
