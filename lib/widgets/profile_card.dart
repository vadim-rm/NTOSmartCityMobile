import 'package:flutter/material.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/widgets/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  final bool showRole;
  const ProfileCard({
    Key? key,
    required this.user,
    required this.showRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: user.fullName,
              child: Avatar(
                  user: user, userRepository: context.read<UserRepository>()),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showRole) ...[
                    Text(
                      user.roleDescription,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                  Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    user.middleName,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    user.address,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
